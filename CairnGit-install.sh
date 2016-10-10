#!/bin/bash

	apt update
	apt upgrade
	apt install dialog

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
	echo -e "Mise à jour.......\033[32mFait\033[00m"

	# Install apache2
	apt install apache2
	a2enmod ssl
	systemctl restart apache2
	echo -e "Installation d'apache2.......\033[32mFait\033[00m"

	# Install Mysql
	apt install mysql-server
	mysql_secure_installation
	systemctl restart apache2
	echo -e "Installation de MySQL.......\033[32mFait\033[00m"

	# Install PHP
	apt install php libapache2-mod-php php-mcrypt php-mysql php-cli
	systemctl restart apache2
	echo -e "Installation de PHP.......\033[32mFait\033[00m"

	# Install phpmyadmin
	apt install phpmyadmin php-mbstring php-gettext
	phpenmod mcrypt
	phpenmod mbstring
	systemctl restart apache2
	echo -e "Installation de PHPmyadmin.......\033[32mFait\033[00m"

	# Install CairnGit
	wget https://github.com/Gspohu/gitmh/archive/master.zip
	mkdir /var/www/CairnGit/
	apt install unzip
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
	apt install python-letsencrypt-apache
	letsencrypt --apache
	a2ensite CairnGit.conf
	echo -e "Installation de let's encrypt.......\033[32mFait\033[00m"

	# Ajout d'une règle cron pour renouveller automatique le certificat
	echo "* * * 2 * letsencrypt renew" > /tmp/crontab.tmp
	crontab /tmp/crontab.tmp
	rm /tmp/crontab.tmp

	# Creation of CairnGit user
	USER="CairnGit"
	HOME_BASE="/home/"
	echo "Creation of CairnGit user"
	read -s -p "Password :" PASSWORD
	useradd -p ${PASSWORD} -m -d ${HOME_BASE}${USER} ${USER}
	echo "Creation of ".${USER}." user" OK

	# Ajout de l'acces sécurisé
	echo "#Identification :" > /var/www/CairnGit/secure_access
	echo "cairngit" >> /var/www/CairnGit/secure_access
	echo "#Password :" >> /var/www/CairnGit/secure_access
	echo "MySQL Password :"
	read -s pass
	echo $pass >> /var/www/CairnGit/secure_access
	chmod 777 /var/www/CairnGit/secure_access

	# Ajout des bases de données
	mysql -u root -p${pass} -e "CREATE DATABASE cairngit;"
	mysql -u root -p${pass} -e "GRANT ALL PRIVILEGES ON cairngit.* TO cairngit@localhost IDENTIFIED BY '$pass';"
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Captcha.sql
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Content_EN.sql
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Member.sql
	mysql -h localhost -p${pass} -u cairngit cairngit < /var/www/CairnGit/SQL/Projects.sql

	echo -e "Ajout des bases de données.......\033[32mFait\033[00m"


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
