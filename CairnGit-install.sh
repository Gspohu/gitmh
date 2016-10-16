#!/bin/bash

	apt update
	apt upgrade
	echo -e "Mise à jour.......\033[32mFait\033[00m"

	apt-get -y install dialog 
	apt-get -y install git
	apt-get -y install unzip

	DIALOG=${DIALOG=dialog}
	fichtemp=`tempfile 2>/dev/null` || fichtemp=/tmp/test$$
	trap "rm -f $fichtemp" 0 1 2 5 15
	$DIALOG --clear --title "Installation CairnGit" \
		--menu "Bonjour, choisissez votre type d'installation :" 15 80 5 \
		 "Dedicated" "Installation dédié à CairnGit uniquement" \
		 "Cohabitation" "Installation de CairnGit a côté d'autres services" \
		 "Infrastructure" "Installation de CairnGit infrastructure de serveur" \
	 	 "Minimal" "Installation minimale" 2> $fichtemp
	valret=$?
	choix=`cat $fichtemp`
	case $valret in
	 0)	echo "'$choix' est votre choix";;
	 1) 	echo "Appuyé sur Annuler.";;
	255) 	echo "Appuyé sur Echap.";;
	esac

if [ "$choix" = "Dedicated" ]
then

	# Password for installation (Mysql, etc)
        echo "Choose the password for the installation"
        passnohash="0"
        repassnohash="1"
        while [ "$passnohash" != "$repassnohash" ]      
        do
                read -s -p "Password : " passnohash
                echo ""
                read -s -p "RE-Password : " repassnohash
                echo ""
                if [ "$passnohash" != "$repassnohash" ]
                then
                        echo "Passwords does not match"
                fi
        done
        pass=$(echo -n $passnohash | sha256sum | sed 's/  -//g')
	passnohash="0"

	# Install apache2
	apt-get -y install apache2
	a2enmod ssl
	a2enmod rewrite
	systemctl restart apache2
	echo -e "Installation d'apache2.......\033[32mFait\033[00m"

	# Install Mysql
	echo "mysql-server mysql-server/root_password password $pass" | sudo debconf-set-selections
	echo "mysql-server mysql-server/root_password_again password $pass" | sudo debconf-set-selections
	apt-get -y install mysql-server
	mysql -u root -p${pass} -e "DELETE FROM mysql.user WHERE User=''"
	mysql -u root -p${pass} -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
	mysql -u root -p${pass} -e "FLUSH PRIVILEGES"
	systemctl restart apache2
	echo -e "Installation de MySQL.......\033[32mFait\033[00m"

	# Install PHP
	apt-get -y install php libapache2-mod-php php-mcrypt php-mysql php-cli
	systemctl restart apache2
	echo -e "Installation de PHP.......\033[32mFait\033[00m"

	# Install phpmyadmin
	apt-get -y install php-mbstring php-gettext
	echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
	echo "phpmyadmin phpmyadmin/app-password-confirm password $pass" | sudo debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/admin-pass password $pass" | sudo debconf-set-selections
	echo "phpmyadmin phpmyadmin/mysql/app-pass password $pass" | sudo debconf-set-selections
	echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections
	apt-get -y install phpmyadmin
	phpenmod mcrypt
	phpenmod mbstring
	systemctl restart apache2
	echo -e "Installation de PHPmyadmin.......\033[32mFait\033[00m"

	# Install mail server
		# Install dependency
		apt-get -y install php7.0-imap

		# DNS
		echo "Consider to update your DNS like this :"
		echo "hostname			IN			A				ipv4 of your server"
		echo "hostname			IN			AAAA			ipv6 of your server"

		echo "mail				IN			A				ipv4 of your server"
		echo "mail				IN			AAAA			ipv6 of your server"
	
		echo "postfixadmin		IN			CNAME			hostname"
		echo "rainloop			IN			CNAME			hostname"

		echo "@				IN			MX	10			mail.domain.tld."
	
		echo "smtp				IN			CNAME			hostname"
		echo "imap				IN			CNAME			hostname"


		# Install Postfix
		apt-get -y install postfix postfix-mysql postfix-policyd-spf-python

		# Create database
		mysql -u root -p${pass} -e "CREATE DATABASE postfix;"
		mysql -u root -p${pass} -e "CREATE USER 'postfix'@'localhost' IDENTIFIED BY '$pass';"
		mysql -u root -p${pass} -e "GRANT USAGE ON *.* TO 'postfix'@'localhost';"
		mysql -u root -p${pass} -e "GRANT ALL PRIVILEGES ON postfix.* TO 'postfix'@'localhost';"

		# Install Postfixadmin
		wget https://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-3.0/postfixadmin-3.0.tar.gz
		tar -xzf postfixadmin-3.0.tar.gz
		mv postfixadmin-3.0 /var/www/postfixadmin
		rm postfixadmin-2.92.tar.gz
		chown -R www-data:www-data /var/www/postfixadmin

		# Configuration of Postfixadmin
		sed -ie "25 s/false/true/g" /var/www/postfixadmin/config.inc.php
		sed -ie "87 s/postfixadmin/$pass/g" /var/www/postfixadmin/config.inc.php

		# Configuration of Apache2
		echo "<VirtualHost *:80>" > /etc/apache2/sites-available/postfixadmin.conf
		echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "ServerName  postfixadmin.cairngit.eu" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "ServerAlias  postfixadmin.cairngit.eu" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "DocumentRoot /var/www/postfixadmin/" >> /etc/apache2/sites-available/postfixadmin.conf

		echo "Redirect permanent / https://postfixadmin.cairngit.eu/" >> /etc/apache2/sites-available/postfixadmin.conf

		echo "ErrorLog /var/www/postfixadmin/logs/error.log" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "CustomLog /var/www/postfixadmin/logs/access.log combined" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "</VirtualHost>" >> /etc/apache2/sites-available/postfixadmin.conf

		echo "<VirtualHost *:443>" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "ServerName  postfixadmin.cairngit.eu" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "ServerAlias  postfixadmin.cairngit.eu/" >> /etc/apache2/sites-available/postfixadmin.conf

		echo "DocumentRoot /var/www/postfixadmin/" >> /etc/apache2/sites-available/postfixadmin.conf

		echo "<Directory /var/www/postfixadmin/>" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "Options Indexes FollowSymLinks" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "AllowOverride all" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "Order allow,deny" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "allow from all" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "</Directory>" >> /etc/apache2/sites-available/postfixadmin.conf


		echo "SSLEngine on" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "SSLProtocol -all -SSLv3 +TLSv1.2" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "SSLCipherSuite ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "SSLCertificateFile /etc/letsencrypt/live/cairngit.eu/cert.pem" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "SSLCertificateKeyFile /etc/letsencrypt/live/cairngit.eu/privkey.pem" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "SSLCertificateChainFile /etc/letsencrypt/live/cairngit.eu/fullchain.pem" >> /etc/apache2/sites-available/postfixadmin.conf

		echo "ErrorLog /var/www/CairnGit/logs/error.log" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "CustomLog /var/www/CairnGit/logs/access.log combined" >> /etc/apache2/sites-available/postfixadmin.conf
		echo "</VirtualHost>" >> /etc/apache2/sites-available/postfixadmin.conf

	systemctl restart apache2

		# Configuration of main.cf

		
		#  SSL

	
		# Configuration of Postfix in order to interact with MySQL
		echo "hosts = 127.0.0.1" > /etc/postfix/mysql-virtual-mailbox-domains.cf
		echo "user = postfix" >> /etc/postfix/mysql-virtual-mailbox-domains.cf
		echo "password = $pass" >> /etc/postfix/mysql-virtual-mailbox-domains.cf
		echo "dbname = postfix" >> /etc/postfix/mysql-virtual-mailbox-domains.cf
		echo "query = SELECT domain FROM domain WHERE domain='%s' and backupmx = 0 and active = 1" >> /etc/postfix/mysql-virtual-mailbox-domains.cf

		echo "hosts = 127.0.0.1" > /etc/postfix/mysql-virtual-mailbox-maps.cf
		echo "user = postfix" >> /etc/postfix/mysql-virtual-mailbox-maps.cf
		echo "password = $pass" >> /etc/postfix/mysql-virtual-mailbox-maps.cf
		echo "dbname = postfix" >> /etc/postfix/mysql-virtual-mailbox-maps.cf
		echo "query = SELECT maildir FROM mailbox WHERE username='%s' AND active = 1" >> /etc/postfix/mysql-virtual-mailbox-maps.cf

		echo "hosts = 127.0.0.1" > /etc/postfix/mysql-virtual-alias-maps.cf
		echo "user = postfix" >> /etc/postfix/mysql-virtual-alias-maps.cf
		echo "password = $pass" >> /etc/postfix/mysql-virtual-alias-maps.cf
		echo "dbname = postfix" >> /etc/postfix/mysql-virtual-alias-maps.cf
		echo "query = SELECT goto FROM alias WHERE address='%s' AND active = 1" >> /etc/postfix/mysql-virtual-alias-maps.cf


		# Configuration of master.cf


		# Installation of Dovecot
		apt-get -y install dovecot-core dovecot-imapd dovecot-lmtpd dovecot-mysql dovecot-sieve dovecot-managesieved


		# Configuration of Dovecot


		# Installation of DKIMProxy
		apt-get -y install dkimproxy 	


	# Install Kanboard
		# Dependency
		apt-get -y install php7.0-sqlite3

		# Download and extract kanboard
		wget https://kanboard.net/kanboard-1.0.34.zip
		unzip kanboard-1.0.33.zip -d /var/www/CairnGit/
		rm kanboard-1.0.33.zip


	# Install Mattermost
	
		# Create database
		mysql -u root -p${pass} -e "CREATE DATABASE mattermost;"
		mysql -u root -p${pass} -e "CREATE USER 'mattermost'@'localhost' IDENTIFIED BY '$pass';"
		mysql -u root -p${pass} -e "GRANT USAGE ON *.* TO 'mattermost'@'localhost';"
		mysql -u root -p${pass} -e "GRANT ALL PRIVILEGES ON mattermost.* TO mattermost@localhost IDENTIFIED BY '$pass';"

		# Create mattermost user
		USER="mattermost"
		echo "Creation of mattermost user"
		useradd -p $pass -M -r -U $USER
		echo "Creation of ".${USER}." user" OK

		# Copie of the system file of Mattermost
		wget https://releases.mattermost.com/3.4.0/mattermost-team-3.4.0-linux-amd64.tar.gz
		tar -xvzf mattermost-team-3.4.0-linux-amd64.tar.gz
		mv mattermost* /var/www
		mkdir  /var/www/mattermost/data
		chown -R mattermost:mattermost /var/www/mattermost/
		rm /var/www/mattermost-team-3.4.0-linux-amd64.tar.gz

		# Configuration of mattermost
		sed -ie 's/"DataSource": "mmuser:mostest@tcp(dockerhost:3306)\/mattermost_test?charset=utf8mb4,utf8",/"DataSource": "mattermost:mattermost_password@tcp(localhost:3306)\/mattermost?charset=utf8",/g' /var/www/mattermost/config/config.json

		# Add Mattermost to systemd
		echo "[Unit]" > /etc/systemd/system/mattermost.service
		echo "Description=Mattermost is an open source, self-hosted Slack-alternative" >> /etc/systemd/system/mattermost.service
		echo "After=syslog.target network.target" >> /etc/systemd/system/mattermost.service

		echo "[Service]" >> /etc/systemd/system/mattermost.service
		echo "Type=simple" >> /etc/systemd/system/mattermost.service
		echo "User=mattermost" >> /etc/systemd/system/mattermost.service
		echo "Group=mattermost" >> /etc/systemd/system/mattermost.service
		echo "ExecStart=/var/www/mattermost/bin/platform" >> /etc/systemd/system/mattermost.service
		echo "PrivateTmp=yes" >> /etc/systemd/system/mattermost.service
		echo "WorkingDirectory=/var/www/mattermost" >> /etc/systemd/system/mattermost.service
		echo "Restart=always" >> /etc/systemd/system/mattermost.service
		echo "RestartSec=30" >> /etc/systemd/system/mattermost.service

		echo "[Install]" >> /etc/systemd/system/mattermost.service
		echo "WantedBy=multi-user.target" >> /etc/systemd/system/mattermost.service

		# Configuration Apache2 for Mattermost
		echo "<VirtualHost *:80>" > /etc/apache2/sites-available/mattermost.conf
		echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/mattermost.conf
		echo "ServerName  cairngit.eu/discuss" >> /etc/apache2/sites-available/mattermost.conf
		echo "ServerAlias  cairngit.eu/discuss" >> /etc/apache2/sites-available/mattermost.conf
		echo "DocumentRoot /var/www/mattermost/" >> /etc/apache2/sites-available/mattermost.conf

		echo "Redirect permanent / https://cairngit.eu/discuss" >> /etc/apache2/sites-available/mattermost.conf

		echo "ErrorLog /var/www/mattermost/logs/error.log" >> /etc/apache2/sites-available/mattermost.conf
		echo "CustomLog /var/www/mattermost/logs/access.log combined" >> /etc/apache2/sites-available/mattermost.conf
		echo "</VirtualHost>" >> /etc/apache2/sites-available/mattermost.conf

		echo "<VirtualHost *:443>" >> /etc/apache2/sites-available/mattermost.conf
		echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/mattermost.conf
		echo "ServerName  cairngit.eu/discuss" >> /etc/apache2/sites-available/mattermost.conf
		echo "ServerAlias  cairngit.eu/discuss" >> /etc/apache2/sites-available/mattermost.conf

		echo "DocumentRoot /var/www/mattermost/" >> /etc/apache2/sites-available/mattermost.conf

		echo "ProxyPass / http://localhost:8065/" >> /etc/apache2/sites-available/mattermost.conf
		echo "ProxyPassReverse / http://localhost:8065/" >> /etc/apache2/sites-available/mattermost.conf

		echo "SSLEngine on" >> /etc/apache2/sites-available/mattermost.conf
		echo "SSLProtocol -all -SSLv3 +TLSv1.2" >> /etc/apache2/sites-available/mattermost.conf
		echo "SSLCipherSuite ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM" >> /etc/apache2/sites-available/mattermost.conf
		echo "SSLCertificateFile /etc/letsencrypt/live/cairngit.eu/cert.pem" >> /etc/apache2/sites-available/mattermost.conf
		echo "SSLCertificateKeyFile /etc/letsencrypt/live/cairngit.eu/privkey.pem" >> /etc/apache2/sites-available/mattermost.conf
		echo "SSLCertificateChainFile /etc/letsencrypt/live/cairngit.eu/fullchain.pem" >> /etc/apache2/sites-available/mattermost.conf

		echo "ErrorLog /var/www/mattermost/logs/error.log" >> /etc/apache2/sites-available/mattermost.conf
		echo "CustomLog /var/www/mattermost/logs/access.log combined" >> /etc/apache2/sites-available/mattermost.conf
		echo "</VirtualHost>" >> /etc/apache2/sites-available/mattermost.conf

		systemctl restart apache2

	# Install framadate
		# Install dependency
		apt-get -y install php7.0-intl

		#Create user framadate
		USER="framadate"
		echo "Creation of framadate user"
		useradd -p $pass -M -r -U $USER
		echo "Creation of ".${USER}." user" OK

		# Install framadate
		mkdir /var/www/framadate
		cd /var/www/framadate
		git clone https://git.framasoft.org/framasoft/framadate.git .
		git checkout 0.9.6
		chown framadate:framadate -R /var/www/framadate
		cd ~
	
		#Install composer
		su framadate -c php -r "readfile('https://getcomposer.org/installer');" | php
		su framadate -c ./composer.phar install
		su framadate -c ./composer.phar update

		# Create MySQL database for framadate
		mysql -u root -p${pass} -e "CREATE DATABASE framadate;"
		mysql -u root -p${pass} -e "CREATE USER 'framadate'@'localhost' IDENTIFIED BY '$pass';"
		mysql -u root -p${pass} -e "GRANT USAGE ON *.* TO 'framadate'@'localhost';"
		mysql -u root -p${pass} -e "GRANT ALL PRIVILEGES ON framadate.* TO framadate@localhost IDENTIFIED BY '$pass';"

		# Configuration Apache2
		

		# Configuration framadate		


	# Install Jitsi Meet
		# Install dependency
		apt-get -y  install apt-transport-https	

		# Add repository
		echo 'deb https://download.jitsi.org stable/' >> /etc/apt/sources.list.d/jitsi-stable.list
		wget -qO -  https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -
		apt update

		# Install Jitsi Meet
		apt-get -y  install jitsi-meet

		# Certif
		systemctl restart prosody

		# Configuration of Jitsi Meet
		echo "disableThirdPartyRequests: true," >> /etc/jitsi/meet/*-config.js

		# Configuration Apache2

	# Install Wisemapping
		# Install dependency
		apt-get -y install openjdk-9-jdk

		# Create wisemapping user
		useradd wisemapping
		groupadd wisemapping
		mkdir /var/www/wisemapping
		chown wisemapping:wisemapping -R /var/www/wisemapping

		# Download Wisemapping
		cd /var/www/wisemapping
		wget https://bitbucket.org/wisemapping/wisemapping-open-source/downloads/wisemapping-v4.0.3.zip
		unzip wisemapping-v4.0.3.zip
		mv wisemapping-v4.0.3/* . && rmdir wisemapping-v4.0.3 && rm wisemapping-v4.0.3.zip
		cd ~

		# Configuration MySQL
		sed -ie "s/PASSWORD(".*")/PASSWORD('$pass')/g" /var/www/wisemapping/config/database/mysql/create-database.sql
		mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/wisemapping/config/database/mysql/create-database.sql
		mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/wisemapping/config/database/mysql/create-schemas.sql

		# Configuration Wisemapping
		sed -ie '6,12 s/^.//g' /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties
                sed -ie '26,32 s/^./#d/g' /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties
                sed -ie "10 s/password=password/password=$pass/g" /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties
		sed -ie '95 s/^.//g' /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties
		sed -ie '95 s/8080/8082/g' /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties
		# Ajouter la configuration mail une fois le serveur installé

		# Configuration Apache2
		echo "<VirtualHost *:80>" > /etc/apache2/sites-available/wisemapping.conf
		echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/wisemapping.conf
		echo "ServerName  cairngit.eu/mindmap" >> /etc/apache2/sites-available/wisemapping.conf
		echo "ServerAlias  cairngit.eu/mindmap" >> /etc/apache2/sites-available/wisemapping.conf
		echo "DocumentRoot /var/www/wisemapping/" >> /etc/apache2/sites-available/wisemapping.conf

		echo "Redirect permanent / https://cairngit.eu/mindmap" >> /etc/apache2/sites-available/wisemapping.conf

		echo "ErrorLog /var/www/wisemapping/logs/error.log" >> /etc/apache2/sites-available/wisemapping.conf
		echo "CustomLog /var/www/wisemapping/logs/access.log combined" >> /etc/apache2/sites-available/wisemapping.conf
		echo "</VirtualHost>" >> /etc/apache2/sites-available/wisemapping.conf

		echo "<VirtualHost *:443>" >> /etc/apache2/sites-available/wisemapping.conf
		echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/wisemapping.conf
		echo "ServerName  cairngit.eu/mindmap" >> /etc/apache2/sites-available/wisemapping.conf
		echo "ServerAlias  cairngit.eu/mindmap" >> /etc/apache2/sites-available/wisemapping.conf

		echo "DocumentRoot /var/www/wisemapping/" >> /etc/apache2/sites-available/wisemapping.conf

		echo "ProxyPass / http://localhost:8082/" >> /etc/apache2/sites-available/wisemapping.conf
		echo "ProxyPassReverse / http://localhost:8082/" >> /etc/apache2/sites-available/wisemapping.conf

		echo "SSLEngine on" >> /etc/apache2/sites-available/wisemapping.conf
		echo "SSLProtocol -all -SSLv3 +TLSv1.2" >> /etc/apache2/sites-available/wisemapping.conf
		echo "SSLCipherSuite ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM" >> /etc/apache2/sites-available/wisemapping.conf
		echo "SSLCertificateFile /etc/letsencrypt/live/cairngit.eu/cert.pem" >> /etc/apache2/sites-available/wisemapping.conf
		echo "SSLCertificateKeyFile /etc/letsencrypt/live/cairngit.eu/privkey.pem" >> /etc/apache2/sites-available/wisemapping.conf
		echo "SSLCertificateChainFile /etc/letsencrypt/live/cairngit.eu/fullchain.pem" >> /etc/apache2/sites-available/wisemapping.conf

		echo "ErrorLog /var/www/wisemapping/logs/error.log" >> /etc/apache2/sites-available/wisemapping.conf
		echo "CustomLog /var/www/wisemapping/logs/access.log combined" >> /etc/apache2/sites-available/wisemapping.conf
		echo "</VirtualHost>" >> /etc/apache2/sites-available/wisemapping.conf

		systemctl restart apache2


		# Launch Wisemapping
		./var/www/wisemapping/start.sh &

		# Add  Wisemapping to systemd
		echo "[Unit]" > /etc/systemd/system/wisemapping.service
		echo "Description=wisemapping" >> /etc/systemd/system/wisemapping.service
		echo "After=syslog.target network.target" >> /etc/systemd/system/wisemapping.service

		echo "[Service]" >> /etc/systemd/system/wisemapping.service
		echo "Type=simple" >> /etc/systemd/system/wisemapping.service
		echo "User=wisemapping" >> /etc/systemd/system/wisemapping.service
		echo "Group=wisemapping" >> /etc/systemd/system/wisemapping.service
		echo "ExecStart=/var/www/wisemapping/start.sh" >> /etc/systemd/system/wisemapping.service
		echo "PrivateTmp=yes" >> /etc/systemd/system/wisemapping.service
		echo "WorkingDirectory=/var/www/wisemapping" >> /etc/systemd/system/wisemapping.service
		echo "Restart=always" >> /etc/systemd/system/wisemapping.service
		echo "RestartSec=30" >> /etc/systemd/system/wisemapping.service

		echo "[Install]" >> /etc/systemd/system/wisemapping.service
		echo "WantedBy=multi-user.target" >> /etc/systemd/system/wisemapping.service


	# Install Scrumblr
		# Install dependency
		apt-get -y install nodejs

		# Create scrumblr user
		useradd scrumblr
		groupadd scrumblr		

		# Install Scrumblr
		cd /var/www/
		git clone https://github.com/aliasaria/scrumblr.git
		chown scrumblr:scrumblr -R /var/www/scrumblr

		# Install dependency
		su scrumblr -s npm install

		# Add Scrumblr to systemd
		echo "[Unit]" > /etc/systemd/system/scrumblr.service
		echo "Description=Scrumblr service" >> /etc/systemd/system/scrumblr.service
		echo "Documentation=https://github.com/aliasaria/scrumblr/" >> /etc/systemd/system/scrumblr.service
		echo "Requires=network.target" >> /etc/systemd/system/scrumblr.service
		echo "Requires=redis-server.service" >> /etc/systemd/system/scrumblr.service
		echo "After=network.target" >> /etc/systemd/system/scrumblr.service
		echo "After=redis-server.service" >> /etc/systemd/system/scrumblr.service

		echo "[Service]" >> /etc/systemd/system/scrumblr.service
		echo "Type=simple" >> /etc/systemd/system/scrumblr.service
		echo "User=scrumblr" >> /etc/systemd/system/scrumblr.service
		echo "WorkingDirectory=/var/www/scrumblr" >> /etc/systemd/system/scrumblr.service
		echo "ExecStart=/usr/bin/node server.js --port 4242" >> /etc/systemd/system/scrumblr.service

		echo "[Install]" >> /etc/systemd/system/scrumblr.service
		echo "WantedBy=multi-user.target" >> /etc/systemd/system/scrumblr.service

		systemctl daemon-reload
		systemctl enable scrumblr.service
		systemctl start scrumblr.service

		# Configuration Apache
		echo "<VirtualHost *:80>" > /etc/apache2/sites-available/scrumblr.conf
		echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/scrumblr.conf
		echo "ServerName  cairngit.eu/brainstorming" >> /etc/apache2/sites-available/scrumblr.conf
		echo "ServerAlias  cairngit.eu/brainstorming" >> /etc/apache2/sites-available/scrumblr.conf
		echo "DocumentRoot /var/www/scrumblr/" >> /etc/apache2/sites-available/scrumblr.conf

		echo "Redirect permanent / https://cairngit.eu/brainstorming" >> /etc/apache2/sites-available/scrumblr.conf

		echo "ErrorLog /var/www/scrumblr/logs/error.log" >> /etc/apache2/sites-available/scrumblr.conf
		echo "CustomLog /var/www/scrumblr/logs/access.log combined" >> /etc/apache2/sites-available/scrumblr.conf
		echo "</VirtualHost>" >> /etc/apache2/sites-available/scrumblr.conf

		echo "<VirtualHost *:443>" >> /etc/apache2/sites-available/scrumblr.conf
		echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/scrumblr.conf
		echo "ServerName  cairngit.eu/brainstorming" >> /etc/apache2/sites-available/scrumblr.conf
		echo "ServerAlias  cairngit.eu/brainstorming" >> /etc/apache2/sites-available/scrumblr.conf

		echo "DocumentRoot /var/www/scrumblr/" >> /etc/apache2/sites-available/scrumblr.conf

		echo "ProxyPass / http://localhost:8082/" >> /etc/apache2/sites-available/scrumblr.conf
		echo "ProxyPassReverse / http://localhost:4242/" >> /etc/apache2/sites-available/scrumblr.conf

		echo "SSLEngine on" >> /etc/apache2/sites-available/scrumblr.conf
		echo "SSLProtocol -all -SSLv3 +TLSv1.2" >> /etc/apache2/sites-available/scrumblr.conf
		echo "SSLCipherSuite ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM" >> /etc/apache2/sites-available/scrumblr.conf
		echo "SSLCertificateFile /etc/letsencrypt/live/cairngit.eu/cert.pem" >> /etc/apache2/sites-available/scrumblr.conf
		echo "SSLCertificateKeyFile /etc/letsencrypt/live/cairngit.eu/privkey.pem" >> /etc/apache2/sites-available/scrumblr.conf
		echo "SSLCertificateChainFile /etc/letsencrypt/live/cairngit.eu/fullchain.pem" >> /etc/apache2/sites-available/scrumblr.conf

		echo "ErrorLog /var/www/scrumblr/logs/error.log" >> /etc/apache2/sites-available/scrumblr.conf
		echo "CustomLog /var/www/scrumblr/logs/access.log combined" >> /etc/apache2/sites-available/scrumblr.conf
		echo "</VirtualHost>" >> /etc/apache2/sites-available/scrumblr.conf

		systemctl restart apache2

	# Install CairnGit
	wget https://github.com/Gspohu/gitmh/archive/master.zip
	mkdir /var/www/CairnGit/
	unzip master.zip -d /var/www/CairnGit/
	rsync -a /var/www/CairnGit/gitmh-master/ /var/www/CairnGit/ 
	chmod -R 777 /var/www/CairnGit
	rm master.zip 
	rm -r /var/www/CairnGit/gitmh-master/
	echo -e "Installation de CairnGit.......\033[32mFait\033[00m"

	# Configuration apache
	echo "<VirtualHost *:80>" > /etc/apache2/sites-available/CairnGit.conf
	echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/CairnGit.conf
	echo "ServerName  cairngit.eu" >> /etc/apache2/sites-available/CairnGit.conf
	echo "ServerAlias  cairngit.eu" >> /etc/apache2/sites-available/CairnGit.conf
	echo "DocumentRoot /var/www/CairnGit/" >> /etc/apache2/sites-available/CairnGit.conf

	echo "Redirect permanent / https://cairngit.eu/" >> /etc/apache2/sites-available/CairnGit.conf

	echo "ErrorLog /var/www/CairnGit/logs/error.log" >> /etc/apache2/sites-available/CairnGit.conf
	echo "CustomLog /var/www/CairnGit/logs/access.log combined" >> /etc/apache2/sites-available/CairnGit.conf
	echo "</VirtualHost>" >> /etc/apache2/sites-available/CairnGit.conf

	echo "<VirtualHost *:443>" >> /etc/apache2/sites-available/CairnGit.conf
	echo "ServerAdmin postmaster@cairn-devices.eu" >> /etc/apache2/sites-available/CairnGit.conf
	echo "ServerName  cairngit.eu" >> /etc/apache2/sites-available/CairnGit.conf
	echo "ServerAlias  cairngit.eu/" >> /etc/apache2/sites-available/CairnGit.conf

	echo "DocumentRoot /var/www/CairnGit/" >> /etc/apache2/sites-available/CairnGit.conf

	echo "<Directory /var/www/CairnGit/>" >> /etc/apache2/sites-available/CairnGit.conf
	echo "Options Indexes FollowSymLinks" >> /etc/apache2/sites-available/CairnGit.conf
	echo "AllowOverride all" >> /etc/apache2/sites-available/CairnGit.conf
	echo "Order allow,deny" >> /etc/apache2/sites-available/CairnGit.conf
	echo "allow from all" >> /etc/apache2/sites-available/CairnGit.conf
	echo "</Directory>" >> /etc/apache2/sites-available/CairnGit.conf


	echo "SSLEngine on" >> /etc/apache2/sites-available/CairnGit.conf
	echo "SSLProtocol -all -SSLv3 +TLSv1.2" >> /etc/apache2/sites-available/CairnGit.conf
	echo "SSLCipherSuite ALL:!aNULL:!ADH:!eNULL:!LOW:!EXP:RC4+RSA:+HIGH:+MEDIUM" >> /etc/apache2/sites-available/CairnGit.conf
	echo "SSLCertificateFile /etc/letsencrypt/live/cairngit.eu/cert.pem" >> /etc/apache2/sites-available/CairnGit.conf
	echo "SSLCertificateKeyFile /etc/letsencrypt/live/cairngit.eu/privkey.pem" >> /etc/apache2/sites-available/CairnGit.conf
	echo "SSLCertificateChainFile /etc/letsencrypt/live/cairngit.eu/fullchain.pem" >> /etc/apache2/sites-available/CairnGit.conf

	echo "ErrorLog /var/www/CairnGit/logs/error.log" >> /etc/apache2/sites-available/CairnGit.conf
	echo "CustomLog /var/www/CairnGit/logs/access.log combined" >> /etc/apache2/sites-available/CairnGit.conf
	echo "</VirtualHost>" >> /etc/apache2/sites-available/CairnGit.conf

	systemctl restart apache2
	echo -e "Configuration d'apache2.......\033[32mFait\033[00m"

	# Configuration letsencrypt cerbot
	apt-get -y install python-letsencrypt-apache
	letsencrypt --apache
	a2ensite CairnGit.conf
	echo -e "Installation de let's encrypt.......\033[32mFait\033[00m"

	# Ajout d'une règle cron pour renouveller automatique le certificat
	echo "* * * 2 * letsencrypt renew" > /tmp/crontab.tmp
	crontab /tmp/crontab.tmp
	rm /tmp/crontab.tmp

	# Creation of CairnGit user
	USER="CairnGit"
	echo "Creation of CairnGit user"
	useradd -p $pass -M -r -U $USER
	echo "Creation of ".${USER}." user" OK

	# Ajout de l'acces sécurisé
	echo "cairngit" > /var/www/CairnGit/.htpasswd
	echo $pass >> /var/www/CairnGit/.htpasswd
	chmod 777 /var/www/CairnGit/.htpasswd

	# Ajout des bases de données
	mysql -u root -p${pass} -e "CREATE DATABASE cairngit;"
	mysql -u root -p${pass} -e "GRANT ALL PRIVILEGES ON cairngit.* TO cairngit@localhost IDENTIFIED BY '$pass';"
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Captcha.sql
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Text_content.sql
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Member.sql
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Projects.sql
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Colors.sql
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Project_types.sql

	echo -e "Ajout des bases de données.......\033[32mFait\033[00m"

	reboot


elif [ "$choix" = "Cohabitation" ]
then
	echo "Pas encore implémenté"

elif [ "$choix" = "Infrastructure" ]
then
	echo "Pas encore implémenté"

elif [ "$choix" = "Minimal" ]
then
	echo "Pas encore implémenté"

fi

