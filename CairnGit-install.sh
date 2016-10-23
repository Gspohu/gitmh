#!/bin/bash

# Error log
exec 2> >(tee -a /srv/error.log)

apt-get -y update
apt-get -y upgrade
echo -e "Mise à jour.......\033[32mFait\033[00m"

apt-get -y install dialog 
apt-get -y install git
apt-get -y install unzip

DIALOG=${DIALOG=dialog}
fichtemp=`tempfile 2>/dev/null` || fichtemp=/tmp/test$$
trap "rm -f $fichtemp" 0 1 2 5 15
$DIALOG --clear --title "Installation of CairnGit" \
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
  read -s -p "Enter password : " passnohash
  echo ""
  read -s -p "Retype p	assword : " repassnohash
  echo ""
  if [ "$passnohash" != "$repassnohash" ]
  then
    echo "Sorry, passwords do not match"
  fi
done
pass=$(echo -n $passnohash | sha256sum | sed 's/  -//g')
passnohash="0"

# Ask for domain name
echo "Please enter your domain name"
read -p "Domain name : " domainName
echo ""

# Install apache2
apt-get -y install apache2
a2enmod ssl
a2enmod rewrite
a2enmod proxy
a2enmod proxy_http
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
apt-get -y install php7.0-imap php7.0-curl

# DNS
echo "Consider to update your DNS like this :"
echo "hostname------IN------A----------ipv4 of your server"
echo "hostname------IN------AAAA-------ipv6 of your server"
echo "mail----------IN------A----------ipv4 of your server"
echo "mail----------IN------AAAA-------ipv6 of your server"
echo "postfixadmin--IN------CNAME------hostname"
echo "rainloop------IN------CNAME------hostname"
echo "@-------------IN------MX 10------mail.$domainName."
echo "smtp----------IN------CNAME------hostname"
echo "imap----------IN------CNAME------hostname"


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
mkdir /var/www/postfixadmin/logs
rm postfixadmin-3.0.tar.gz
chown -R www-data:www-data /var/www/postfixadmin

# Configuration of Postfixadmin
sed -i "25 s/false/true/g" /var/www/postfixadmin/config.inc.php
pass_MD5=$(echo -n $pass | md5sum | sed 's/  -//g')
pass_SHA1=$(echo -n $pass_MD5:$pass | sha1sum | sed 's/  -//g')
sed -i "30 s/changeme/$pass_MD5:$pass_SHA1/g" /var/www/postfixadmin/config.inc.php
sed -i "87 s/postfixadmin/$pass/g" /var/www/postfixadmin/config.inc.php
sed -i "120 s/''/'admin@$domainName'/g" /var/www/postfixadmin/config.inc.php
sed -i "198 s/change-this-to-your.domain.tld/$domainName/g" /var/www/postfixadmin/config.inc.php
sed -i "199 s/change-this-to-your.domain.tld/$domainName/g" /var/www/postfixadmin/config.inc.php
sed -i "200 s/change-this-to-your.domain.tld/$domainName/g" /var/www/postfixadmin/config.inc.php
sed -i "201 s/change-this-to-your.domain.tld/$domainName/g" /var/www/postfixadmin/config.inc.php
sed -i "420 s/change-this-to-your.domain.tld/$domainName/g" /var/www/postfixadmin/config.inc.php
sed -i "421 s/change-this-to-your.domain.tld/$domainName/g" /var/www/postfixadmin/config.inc.php

# Configuration of Apache2
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/postfixadmin.conf
echo "ServerAdmin postmaster@$domainName" >> /etc/apache2/sites-available/postfixadmin.conf
echo "ServerName  postfixadmin.$domainName" >> /etc/apache2/sites-available/postfixadmin.conf
echo "ServerAlias  postfixadmin.$domainName" >> /etc/apache2/sites-available/postfixadmin.conf
echo "DocumentRoot /var/www/postfixadmin/" >> /etc/apache2/sites-available/postfixadmin.conf
echo "<Directory /var/www/postfixadmin/>" >> /etc/apache2/sites-available/postfixadmin.conf
echo "Options Indexes FollowSymLinks" >> /etc/apache2/sites-available/postfixadmin.conf
echo "AllowOverride all" >> /etc/apache2/sites-available/postfixadmin.conf
echo "Order allow,deny" >> /etc/apache2/sites-available/postfixadmin.conf
echo "allow from all" >> /etc/apache2/sites-available/postfixadmin.conf
echo "</Directory>" >> /etc/apache2/sites-available/postfixadmin.conf
echo "ErrorLog /var/www/postfixadmin/logs/error.log" >> /etc/apache2/sites-available/postfixadmin.conf
echo "CustomLog /var/www/postfixadmin/logs/access.log combined" >> /etc/apache2/sites-available/postfixadmin.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/postfixadmin.conf

a2ensite postfixadmin.conf
systemctl restart apache2

sed -i "1 s/<?php/<?php\nif (\!isset(\$_SERVER[\"HTTP_HOST\"]))\n{\n    parse_str(\$argv[1], \$_POST);\n}\n\$_SERVER[\'REQUEST_METHOD\']=\'POST\';\n\$_SERVER[\'HTTP_HOST\']=\'$domainName\';/g" /var/www/postfixadmin/setup.php

cd /var/www/postfixadmin/

php -f /var/www/postfixadmin/setup.php "form=createadmin&setup_password=$pass&username=admin@$domainName&password=$pass&password2=$pass"

cd ~

sed -i "2,7d " /var/www/postfixadmin/setup.php

# Configuration of main.cf
echo "# The first text sent to a connecting process." > /etc/postfix/main.cf
echo "smtpd_banner = \$myhostname ESMTP \$mail_name" >> /etc/postfix/main.cf
echo "biff = no" >> /etc/postfix/main.cf
echo "# appending .domain is the MUA's job." >> /etc/postfix/main.cf
echo "append_dot_mydomain = no" >> /etc/postfix/main.cf
echo "readme_directory = no" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# SASL parameters" >> /etc/postfix/main.cf
echo "# ---------------------------------" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# Use Dovecot to authenticate." >> /etc/postfix/main.cf
echo "smtpd_sasl_type = dovecot" >> /etc/postfix/main.cf
echo "# Referring to /var/spool/postfix/private/auth" >> /etc/postfix/main.cf
echo "smtpd_sasl_path = private/auth" >> /etc/postfix/main.cf
echo "smtpd_sasl_auth_enable = yes" >> /etc/postfix/main.cf
echo "broken_sasl_auth_clients = yes" >> /etc/postfix/main.cf
echo "smtpd_sasl_security_options = noanonymous" >> /etc/postfix/main.cf
echo "smtpd_sasl_local_domain =" >> /etc/postfix/main.cf
echo "smtpd_sasl_authenticated_header = yes" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# TLS parameters" >> /etc/postfix/main.cf
echo "# ---------------------------------" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# Replace this with your SSL certificate path if you are using one." >> /etc/postfix/main.cf
echo "smtpd_tls_cert_file = /etc/letsencrypt/live/acert.$domainName/fullchain.pem" >> /etc/postfix/main.cf
echo "smtpd_tls_key_file = /etc/letsencrypt/live/acert.$domainName/privkey.pem" >> /etc/postfix/main.cf
echo "# The snakeoil self-signed certificate has no need for a CA file. But" >> /etc/postfix/main.cf
echo "# if you are using your own SSL certificate, then you probably have" >> /etc/postfix/main.cf
echo "# a CA certificate bundle from your provider. The path to that goes" >> /etc/postfix/main.cf
echo "# here." >> /etc/postfix/main.cf
echo "smtpd_use_tls=yes" >> /etc/postfix/main.cf
echo "smtp_tls_security_level = may" >> /etc/postfix/main.cf
echo "smtpd_tls_security_level = may" >> /etc/postfix/main.cf
echo "#smtpd_tls_auth_only = no" >> /etc/postfix/main.cf
echo "smtp_tls_note_starttls_offer = yes" >> /etc/postfix/main.cf
echo "smtpd_tls_loglevel = 1" >> /etc/postfix/main.cf
echo "smtpd_tls_received_header = yes" >> /etc/postfix/main.cf
echo "smtpd_tls_session_cache_timeout = 3600s" >> /etc/postfix/main.cf
echo "tls_random_source = dev:/dev/urandom" >> /etc/postfix/main.cf
echo "#smtpd_tls_session_cache_database = btree:\${data_directory}/smtpd_scache" >> /etc/postfix/main.cf
echo "#smtp_tls_session_cache_database = btree:\${data_directory}/smtp_scache" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# See /usr/share/doc/postfix/TLS_README.gz in the postfix-doc package for" >> /etc/postfix/main.cf
echo "# information on enabling SSL in the smtp client." >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# SMTPD parameters" >> /etc/postfix/main.cf
echo "# ---------------------------------" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# Uncomment the next line to generate "delayed mail" warnings" >> /etc/postfix/main.cf
echo "#delay_warning_time = 4h" >> /etc/postfix/main.cf
echo "# will it be a permanent error or temporary" >> /etc/postfix/main.cf
echo "unknown_local_recipient_reject_code = 450" >> /etc/postfix/main.cf
echo "# how long to keep message on queue before return as failed." >> /etc/postfix/main.cf
echo "# some have 3 days, I have 16 days as I am backup server for some people" >> /etc/postfix/main.cf
echo "# whom go on holiday with their server switched off." >> /etc/postfix/main.cf
echo "maximal_queue_lifetime = 7d" >> /etc/postfix/main.cf
echo "# max and min time in seconds between retries if connection failed" >> /etc/postfix/main.cf
echo "minimal_backoff_time = 1000s" >> /etc/postfix/main.cf
echo "maximal_backoff_time = 8000s" >> /etc/postfix/main.cf
echo "# how long to wait when servers connect before receiving rest of data" >> /etc/postfix/main.cf
echo "smtp_helo_timeout = 60s" >> /etc/postfix/main.cf
echo "# how many address can be used in one message." >> /etc/postfix/main.cf
echo "# effective stopper to mass spammers, accidental copy in whole address list" >> /etc/postfix/main.cf
echo "# but may restrict intentional mail shots." >> /etc/postfix/main.cf
echo "smtpd_recipient_limit = 16" >> /etc/postfix/main.cf
echo "# how many error before back off." >> /etc/postfix/main.cf
echo "smtpd_soft_error_limit = 3" >> /etc/postfix/main.cf
echo "# how many max errors before blocking it." >> /etc/postfix/main.cf
echo "smtpd_hard_error_limit = 12" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# This next set are important for determining who can send mail and relay mail" >> /etc/postfix/main.cf
echo "# to other servers. It is very important to get this right - accidentally producing" >> /etc/postfix/main.cf
echo "# an open relay that allows unauthenticated sending of mail is a Very Bad Thing." >> /etc/postfix/main.cf
echo "#" >> /etc/postfix/main.cf
echo "# You are encouraged to read up on what exactly each of these options accomplish." >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# Requirements for the HELO statement" >> /etc/postfix/main.cf
echo "smtpd_helo_restrictions = permit_mynetworks, warn_if_reject reject_non_fqdn_hostname, reject_invalid_hostname, permit" >> /etc/postfix/main.cf
echo "# Requirements for the sender details" >> /etc/postfix/main.cf
echo "smtpd_sender_restrictions = permit_sasl_authenticated, permit_mynetworks, warn_if_reject reject_non_fqdn_sender, reject_unknown_sender_domain, reject_unauth_pipelining, permit" >> /etc/postfix/main.cf
echo "# Requirements for the connecting server" >> /etc/postfix/main.cf
echo "# Attention MODIFICATION de la config proposée." >> /etc/postfix/main.cf
echo "# ------------------------------------------------------------- " >> /etc/postfix/main.cf
echo "# Le serveur de blacklist dnsbl.njabl.org n'est plus en service depuis mars 2013 - Voir [[http://www.dnsbl.com/2007/03/how-well-do-various-blacklists-work.html]]" >> /etc/postfix/main.cf
echo "# Donc remplacer la ligne suivante " >> /etc/postfix/main.cf
echo "# smtpd_client_restrictions = reject_rbl_client sbl.spamhaus.org, reject_rbl_client blackholes.easynet.nl, reject_rbl_client dnsbl.njabl.org" >> /etc/postfix/main.cf
echo "# Par la nouvelle ligne" >> /etc/postfix/main.cf
echo "smtpd_client_restrictions = reject_rbl_client sbl.spamhaus.org, reject_rbl_client blackholes.easynet.nl" >> /etc/postfix/main.cf
echo "# Requirement for the recipient address. Note that the entry for" >> /etc/postfix/main.cf
echo "# "check_policy_service inet:127.0.0.1:10023" enables Postgrey." >> /etc/postfix/main.cf
echo "smtpd_recipient_restrictions = 	permit_mynetworks," >> /etc/postfix/main.cf
echo "					permit_sasl_authenticated," >> /etc/postfix/main.cf
echo "					reject_unauth_destination," >> /etc/postfix/main.cf
echo "					reject_non_fqdn_recipient," >> /etc/postfix/main.cf
echo "					reject_rbl_client zen.spamhaus.org," >> /etc/postfix/main.cf
echo "					check_policy_service inet:127.0.0.1:10023," >> /etc/postfix/main.cf
echo "					permit" >> /etc/postfix/main.cf
echo "smtpd_data_restrictions = reject_unauth_pipelining" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# require proper helo at connections" >> /etc/postfix/main.cf
echo "smtpd_helo_required = yes" >> /etc/postfix/main.cf
echo "# waste spammers time before rejecting them" >> /etc/postfix/main.cf
echo "smtpd_delay_reject = yes" >> /etc/postfix/main.cf
echo "disable_vrfy_command = yes" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# General host and delivery info" >> /etc/postfix/main.cf
echo "# ----------------------------------" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "myhostname = $domainName " >> /etc/postfix/main.cf
echo "myorigin = /etc/hostname" >> /etc/postfix/main.cf
echo "mydestination = localhost" >> /etc/postfix/main.cf
echo "#relayhost =" >> /etc/postfix/main.cf
echo "# If you have a separate web server that sends outgoing mail through this" >> /etc/postfix/main.cf
echo "# mailserver, you may want to add its IP address to the space-delimited list in" >> /etc/postfix/main.cf
echo "# mynetworks, e.g. as 111.222.333.444/32." >> /etc/postfix/main.cf
echo "mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128" >> /etc/postfix/main.cf
echo "mailbox_size_limit = 0" >> /etc/postfix/main.cf
echo "recipient_delimiter = +" >> /etc/postfix/main.cf
echo "inet_interfaces = all" >> /etc/postfix/main.cf
echo "mynetworks_style = host" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# This specifies where the virtual mailbox folders will be located." >> /etc/postfix/main.cf
echo "virtual_mailbox_base = /home/vmail" >> /etc/postfix/main.cf
echo "# This is for the mailbox location for each user. The domainaliases" >> /etc/postfix/main.cf
echo "# map allows us to make use of Postfix Admin's domain alias feature." >> /etc/postfix/main.cf
echo "virtual_mailbox_maps = mysql:/etc/postfix/mysql_virtual_mailbox_maps.cf, mysql:/etc/postfix/mysql_virtual_mailbox_domainaliases_maps.cf" >> /etc/postfix/main.cf
echo "# and their user id" >> /etc/postfix/main.cf
echo "virtual_uid_maps = static:150" >> /etc/postfix/main.cf
echo "# and group id" >> /etc/postfix/main.cf
echo "virtual_gid_maps = static:1001" >> /etc/postfix/main.cf
echo "# This is for aliases. The domainaliases map allows us to make" >> /etc/postfix/main.cf
echo "# use of Postfix Admin's domain alias feature." >> /etc/postfix/main.cf
echo "virtual_alias_maps = mysql:/etc/postfix/mysql_virtual_alias_maps.cf, mysql:/etc/postfix/mysql_virtual_alias_domainaliases_maps.cf" >> /etc/postfix/main.cf
echo "# This is for domain lookups." >> /etc/postfix/main.cf
echo "virtual_mailbox_domains = mysql:/etc/postfix/mysql_virtual_domains_maps.cf" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# Integration with other packages" >> /etc/postfix/main.cf
echo "# ---------------------------------------" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# Tell postfix to hand off mail to the definition for dovecot in master.cf" >> /etc/postfix/main.cf
echo "virtual_transport = dovecot" >> /etc/postfix/main.cf
echo "dovecot_destination_recipient_limit = 1" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# Use amavis for virus and spam scanning" >> /etc/postfix/main.cf
echo "content_filter = amavis:[127.0.0.1]:10024" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# Header manipulation" >> /etc/postfix/main.cf
echo "# --------------------------------------" >> /etc/postfix/main.cf
echo " " >> /etc/postfix/main.cf
echo "# Getting rid of unwanted headers. See: https://posluns.com/guides/header-removal/" >> /etc/postfix/main.cf
echo "header_checks = regexp:/etc/postfix/header_checks" >> /etc/postfix/main.cf
echo "# getting rid of x-original-to" >> /etc/postfix/main.cf
echo "enable_original_recipient = no" >> /etc/postfix/main.cf
echo "" >> /etc/postfix/main.cf
echo "message_size_limit =51200000" >> /etc/postfix/main.cf
echo "" >> /etc/postfix/main.cf
echo "# DKIM" >> /etc/postfix/main.cf
echo "milter_default_action = accept" >> /etc/postfix/main.cf
echo "milter_protocol = 6" >> /etc/postfix/main.cf
echo "smtpd_milters = inet:localhost:12345" >> /etc/postfix/main.cf
echo "non_smtpd_milters = inet:localhost:12345" >> /etc/postfix/main.cf


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
echo "#" >> /etc/postfix/master.cf
echo "# Postfix master process configuration file.  For details on the format" > /etc/postfix/master.cf
echo "# of the file, see the master(5) manual page (command: "man 5 master")." >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# Do not forget to execute "postfix reload" after editing this file." >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# ==========================================================================" >> /etc/postfix/master.cf
echo "# service type  private unpriv  chroot  wakeup  maxproc command + args" >> /etc/postfix/master.cf
echo "#               (yes)   (yes)   (yes)   (never) (100)" >> /etc/postfix/master.cf
echo "# ==========================================================================" >> /etc/postfix/master.cf
echo "smtp      inet  n       -       -       -       -       smtpd" >> /etc/postfix/master.cf
echo "5025      inet  n       -       -       -       -       smtpd" >> /etc/postfix/master.cf
echo "#smtp      inet  n       -       -       -       1       postscreen" >> /etc/postfix/master.cf
echo "#smtpd     pass  -       -       -       -       -       smtpd" >> /etc/postfix/master.cf
echo "#dnsblog   unix  -       -       -       -       0       dnsblog" >> /etc/postfix/master.cf
echo "#tlsproxy  unix  -       -       -       -       0       tlsproxy" >> /etc/postfix/master.cf
echo "#submission inet n       -       -       -       -       smtpd" >> /etc/postfix/master.cf
echo "#  -o syslog_name=postfix/submission" >> /etc/postfix/master.cf
echo "#  -o smtpd_tls_security_level=encrypt" >> /etc/postfix/master.cf
echo "#  -o smtpd_sasl_auth_enable=yes" >> /etc/postfix/master.cf
echo "#  -o smtpd_client_restrictions=permit_sasl_authenticated,reject" >> /etc/postfix/master.cf
echo "#  -o milter_macro_daemon_name=ORIGINATING" >> /etc/postfix/master.cf
echo "#smtps     inet  n       -       -       -       -       smtpd" >> /etc/postfix/master.cf
echo "#  -o syslog_name=postfix/smtps" >> /etc/postfix/master.cf
echo "#  -o smtpd_tls_wrappermode=yes" >> /etc/postfix/master.cf
echo "#  -o smtpd_sasl_auth_enable=yes" >> /etc/postfix/master.cf
echo "#  -o smtpd_tls_auth_only=yes" >> /etc/postfix/master.cf
echo "#  -o smtpd_client_restrictions=permit_sasl_authenticated,reject_unauth_destination,reject" >> /etc/postfix/master.cf
echo "#  -o smtpd_sasl_security_options=noanonymous,noplaintext" >> /etc/postfix/master.cf
echo "#  -o smtpd_sasl_tls_security_options=noanonymous" >> /etc/postfix/master.cf
echo "#  -o milter_macro_daemon_name=ORIGINATING" >> /etc/postfix/master.cf
echo "#628       inet  n       -       -       -       -       qmqpd" >> /etc/postfix/master.cf
echo "pickup    fifo  n       -       -       60      1       pickup" >> /etc/postfix/master.cf
echo "  -o content_filter=" >> /etc/postfix/master.cf
echo "  -o receive_override_options=no_header_body_checks" >> /etc/postfix/master.cf
echo "cleanup   unix  n       -       -       -       0       cleanup" >> /etc/postfix/master.cf
echo "qmgr      fifo  n       -       n       300     1       qmgr" >> /etc/postfix/master.cf
echo "#qmgr     fifo  n       -       n       300     1       oqmgr" >> /etc/postfix/master.cf
echo "tlsmgr    unix  -       -       -       1000?   1       tlsmgr" >> /etc/postfix/master.cf
echo "rewrite   unix  -       -       -       -       -       trivial-rewrite" >> /etc/postfix/master.cf
echo "bounce    unix  -       -       -       -       0       bounce" >> /etc/postfix/master.cf
echo "defer     unix  -       -       -       -       0       bounce" >> /etc/postfix/master.cf
echo "trace     unix  -       -       -       -       0       bounce" >> /etc/postfix/master.cf
echo "verify    unix  -       -       -       -       1       verify" >> /etc/postfix/master.cf
echo "flush     unix  n       -       -       1000?   0       flush" >> /etc/postfix/master.cf
echo "proxymap  unix  -       -       n       -       -       proxymap" >> /etc/postfix/master.cf
echo "proxywrite unix -       -       n       -       1       proxymap" >> /etc/postfix/master.cf
echo "smtp      unix  -       -       -       -       -       smtp" >> /etc/postfix/master.cf
echo "relay     unix  -       -       -       -       -       smtp" >> /etc/postfix/master.cf
echo "#       -o smtp_helo_timeout=5 -o smtp_connect_timeout=5" >> /etc/postfix/master.cf
echo "showq     unix  n       -       -       -       -       showq" >> /etc/postfix/master.cf
echo "error     unix  -       -       -       -       -       error" >> /etc/postfix/master.cf
echo "retry     unix  -       -       -       -       -       error" >> /etc/postfix/master.cf
echo "discard   unix  -       -       -       -       -       discard" >> /etc/postfix/master.cf
echo "local     unix  -       n       n       -       -       local" >> /etc/postfix/master.cf
echo "virtual   unix  -       n       n       -       -       virtual" >> /etc/postfix/master.cf
echo "lmtp      unix  -       -       -       -       -       lmtp" >> /etc/postfix/master.cf
echo "anvil     unix  -       -       -       -       1       anvil" >> /etc/postfix/master.cf
echo "scache    unix  -       -       -       -       1       scache" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# ====================================================================" >> /etc/postfix/master.cf
echo "# Interfaces to non-Postfix software. Be sure to examine the manual" >> /etc/postfix/master.cf
echo "# pages of the non-Postfix software to find out what options it wants." >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# Many of the following services use the Postfix pipe(8) delivery" >> /etc/postfix/master.cf
echo "# agent.  See the pipe(8) man page for information about \${recipient}" >> /etc/postfix/master.cf
echo "# and other message envelope options." >> /etc/postfix/master.cf
echo "# ====================================================================" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# maildrop. See the Postfix MAILDROP_README file for details." >> /etc/postfix/master.cf
echo "# Also specify in main.cf: maildrop_destination_recipient_limit=1" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "maildrop  unix  -       n       n       -       -       pipe" >> /etc/postfix/master.cf
echo "  flags=DRhu user=vmail argv=/usr/bin/maildrop -d \${recipient}" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# ====================================================================" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# Recent Cyrus versions can use the existing "lmtp" master.cf entry." >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# Specify in cyrus.conf:" >> /etc/postfix/master.cf
echo "#   lmtp    cmd="lmtpd -a" listen="localhost:lmtp" proto=tcp4" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# Specify in main.cf one or more of the following:" >> /etc/postfix/master.cf
echo "#  mailbox_transport = lmtp:inet:localhost" >> /etc/postfix/master.cf
echo "#  virtual_transport = lmtp:inet:localhost" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# ====================================================================" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# Cyrus 2.1.5 (Amos Gouaux)" >> /etc/postfix/master.cf
echo "# Also specify in main.cf: cyrus_destination_recipient_limit=1" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "#cyrus     unix  -       n       n       -       -       pipe" >> /etc/postfix/master.cf
echo "#  user=cyrus argv=/cyrus/bin/deliver -e -r \${sender} -m \${extension} \${user}" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# ====================================================================" >> /etc/postfix/master.cf
echo "# Old example of delivery via Cyrus." >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "#old-cyrus unix  -       n       n       -       -       pipe" >> /etc/postfix/master.cf
echo "#  flags=R user=cyrus argv=/cyrus/bin/deliver -e -m \${extension} \${user}" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# ====================================================================" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# See the Postfix UUCP_README file for configuration details." >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "uucp      unix  -       n       n       -       -       pipe" >> /etc/postfix/master.cf
echo "  flags=Fqhu user=uucp argv=uux -r -n -z -a\$sender - \$nexthop!rmail (\$recipient)" >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# Other external delivery methods." >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "ifmail    unix  -       n       n       -       -       pipe" >> /etc/postfix/master.cf
echo "  flags=F user=ftn argv=/usr/lib/ifmail/ifmail -r \$nexthop (\$recipient)" >> /etc/postfix/master.cf
echo "bsmtp     unix  -       n       n       -       -       pipe" >> /etc/postfix/master.cf
echo "  flags=Fq. user=bsmtp argv=/usr/lib/bsmtp/bsmtp -t\$nexthop -f\$sender \$recipient" >> /etc/postfix/master.cf
echo "scalemail-backend unix  -       n       n       -       2       pipe" >> /etc/postfix/master.cf
echo "  flags=R user=scalemail argv=/usr/lib/scalemail/bin/scalemail-store \${nexthop} \${user} \${extension}" >> /etc/postfix/master.cf
echo "mailman   unix  -       n       n       -       -       pipe" >> /etc/postfix/master.cf
echo "  flags=FR user=list argv=/usr/lib/mailman/bin/postfix-to-mailman.py" >> /etc/postfix/master.cf
echo "  \${nexthop} \${user} " >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "# Integration with Dovecot - hand mail over to it for local delivery, and" >> /etc/postfix/master.cf
echo "# run the process under the vmail user and mail group." >> /etc/postfix/master.cf
echo "#" >> /etc/postfix/master.cf
echo "dovecot      unix   -        n      n       -       -   pipe" >> /etc/postfix/master.cf
echo "        flags=DRhu user=vmail:mail argv=/usr/lib/dovecot/dovecot-lda -d \$(recipient)" >> /etc/postfix/master.cf

# Installation of Dovecot
apt-get -y install dovecot-core dovecot-imapd dovecot-lmtpd dovecot-mysql dovecot-sieve dovecot-managesieved


# Configuration of Dovecot
echo "## Dovecot configuration file" > /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# If you're in a hurry, see http://wiki2.dovecot.org/QuickConfiguration" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# "doveconf -n" command gives a clean output of the changed settings. Use it" >> /etc/dovecot/dovecot.conf
echo "# instead of copy&pasting files when posting to the Dovecot mailing list." >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# '#' character and everything after it is treated as comments. Extra spaces" >> /etc/dovecot/dovecot.conf
echo "# and tabs are ignored. If you want to use either of these explicitly, put the" >> /etc/dovecot/dovecot.conf
echo "# value inside quotes, eg.: key = "# char and trailing whitespace  "" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Default values are shown for each setting, it's not required to uncomment" >> /etc/dovecot/dovecot.conf
echo "# those. These are exceptions to this though: No sections (e.g. namespace {})" >> /etc/dovecot/dovecot.conf
echo "# or plugin settings are added by default, they're listed only as examples." >> /etc/dovecot/dovecot.conf
echo "# Paths are also just examples with the real defaults being based on configure" >> /etc/dovecot/dovecot.conf
echo "# options. The paths listed here are for configure --prefix=/usr" >> /etc/dovecot/dovecot.conf
echo "# --sysconfdir=/etc --localstatedir=/var" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Enable installed protocols" >> /etc/dovecot/dovecot.conf
echo "!include_try /usr/share/dovecot/protocols.d/*.protocol" >> /etc/dovecot/dovecot.conf
echo "protocols = imap lmtp sieve " >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# A comma separated list of IPs or hosts where to listen in for connections. " >> /etc/dovecot/dovecot.conf
echo "# "*" listens in all IPv4 interfaces, "::" listens in all IPv6 interfaces." >> /etc/dovecot/dovecot.conf
echo "# If you want to specify non-default ports or anything more complex," >> /etc/dovecot/dovecot.conf
echo "# edit conf.d/master.conf." >> /etc/dovecot/dovecot.conf
echo "listen = *, ::" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Base directory where to store runtime data." >> /etc/dovecot/dovecot.conf
echo "#base_dir = /var/run/dovecot/" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Name of this instance. In multi-instance setup doveadm and other commands" >> /etc/dovecot/dovecot.conf
echo "# can use -i <instance_name> to select which instance is used (an alternative" >> /etc/dovecot/dovecot.conf
echo "# to -c <config_path>). The instance name is also added to Dovecot processes" >> /etc/dovecot/dovecot.conf
echo "# in ps output." >> /etc/dovecot/dovecot.conf
echo "#instance_name = dovecot" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Greeting message for clients." >> /etc/dovecot/dovecot.conf
echo "#login_greeting = Dovecot ready." >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Space separated list of trusted network ranges. Connections from these" >> /etc/dovecot/dovecot.conf
echo "# IPs are allowed to override their IP addresses and ports (for logging and" >> /etc/dovecot/dovecot.conf
echo "# for authentication checks). disable_plaintext_auth is also ignored for" >> /etc/dovecot/dovecot.conf
echo "# these networks. Typically you'd specify your IMAP proxy servers here." >> /etc/dovecot/dovecot.conf
echo "#login_trusted_networks =" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Sepace separated list of login access check sockets (e.g. tcpwrap)" >> /etc/dovecot/dovecot.conf
echo "#login_access_sockets = " >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# With proxy_maybe=yes if proxy destination matches any of these IPs, don't do" >> /etc/dovecot/dovecot.conf
echo "# proxying. This isn't necessary normally, but may be useful if the destination" >> /etc/dovecot/dovecot.conf
echo "# IP is e.g. a load balancer's IP." >> /etc/dovecot/dovecot.conf
echo "#auth_proxy_self =" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Show more verbose process titles (in ps). Currently shows user name and" >> /etc/dovecot/dovecot.conf
echo "# IP address. Useful for seeing who are actually using the IMAP processes" >> /etc/dovecot/dovecot.conf
echo "# (eg. shared mailboxes or if same uid is used for multiple accounts)." >> /etc/dovecot/dovecot.conf
echo "#verbose_proctitle = no" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Should all processes be killed when Dovecot master process shuts down." >> /etc/dovecot/dovecot.conf
echo "# Setting this to "no" means that Dovecot can be upgraded without" >> /etc/dovecot/dovecot.conf
echo "# forcing existing client connections to close (although that could also be" >> /etc/dovecot/dovecot.conf
echo "# a problem if the upgrade is e.g. because of a security fix)." >> /etc/dovecot/dovecot.conf
echo "#shutdown_clients = yes" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# If non-zero, run mail commands via this many connections to doveadm server," >> /etc/dovecot/dovecot.conf
echo "# instead of running them directly in the same process." >> /etc/dovecot/dovecot.conf
echo "#doveadm_worker_count = 0" >> /etc/dovecot/dovecot.conf
echo "# UNIX socket or host:port used for connecting to doveadm server" >> /etc/dovecot/dovecot.conf
echo "#doveadm_socket_path = doveadm-server" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Space separated list of environment variables that are preserved on Dovecot" >> /etc/dovecot/dovecot.conf
echo "# startup and passed down to all of its child processes. You can also give" >> /etc/dovecot/dovecot.conf
echo "# key=value pairs to always set specific settings." >> /etc/dovecot/dovecot.conf
echo "#import_environment = TZ" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "##" >> /etc/dovecot/dovecot.conf
echo "## Dictionary server settings" >> /etc/dovecot/dovecot.conf
echo "##" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Dictionary can be used to store key=value lists. This is used by several" >> /etc/dovecot/dovecot.conf
echo "# plugins. The dictionary can be accessed either directly or though a" >> /etc/dovecot/dovecot.conf
echo "# dictionary server. The following dict block maps dictionary names to URIs" >> /etc/dovecot/dovecot.conf
echo "# when the server is used. These can then be referenced using URIs in format" >> /etc/dovecot/dovecot.conf
echo "# \"proxy::<name>\"." >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "dict {" >> /etc/dovecot/dovecot.conf
echo "  #quota = mysql:/etc/dovecot/dovecot-dict-sql.conf.ext" >> /etc/dovecot/dovecot.conf
echo "  #expire = sqlite:/etc/dovecot/dovecot-dict-sql.conf.ext" >> /etc/dovecot/dovecot.conf
echo "}" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# Most of the actual configuration gets included below. The filenames are" >> /etc/dovecot/dovecot.conf
echo "# first sorted by their ASCII value and parsed in that order. The 00-prefixes" >> /etc/dovecot/dovecot.conf
echo "# in filenames are intended to make it easier to understand the ordering." >> /etc/dovecot/dovecot.conf
echo "!include conf.d/*.conf" >> /etc/dovecot/dovecot.conf
echo "" >> /etc/dovecot/dovecot.conf
echo "# A config file can also tried to be included without giving an error if" >> /etc/dovecot/dovecot.conf
echo "# it's not found:" >> /etc/dovecot/dovecot.conf
echo "!include_try local.conf" >> /etc/dovecot/dovecot.conf

echo "##" > /etc/dovecot/conf.d/10-mail.conf
echo "## Mailbox locations and namespaces" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Location for users' mailboxes. The default is empty, which means that Dovecot" >> /etc/dovecot/conf.d/10-mail.conf
echo "# tries to find the mailboxes automatically. This won't work if the user" >> /etc/dovecot/conf.d/10-mail.conf
echo "# doesn't yet have any mail, so you should explicitly tell Dovecot the full" >> /etc/dovecot/conf.d/10-mail.conf
echo "# location." >> /etc/dovecot/conf.d/10-mail.conf
echo "#" >> /etc/dovecot/conf.d/10-mail.conf
echo "# If you're using mbox, giving a path to the INBOX file (eg. /var/mail/%u)" >> /etc/dovecot/conf.d/10-mail.conf
echo "# isn't enough. You'll also need to tell Dovecot where the other mailboxes are" >> /etc/dovecot/conf.d/10-mail.conf
echo "# kept. This is called the "root mail directory", and it must be the first" >> /etc/dovecot/conf.d/10-mail.conf
echo "# path given in the mail_location setting." >> /etc/dovecot/conf.d/10-mail.conf
echo "#" >> /etc/dovecot/conf.d/10-mail.conf
echo "# There are a few special variables you can use, eg.:" >> /etc/dovecot/conf.d/10-mail.conf
echo "#" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   %u - username" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   %n - user part in user@domain, same as %u if there's no domain" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   %d - domain part in user@domain, empty if there's no domain" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   %h - home directory" >> /etc/dovecot/conf.d/10-mail.conf
echo "#" >> /etc/dovecot/conf.d/10-mail.conf
echo "# See doc/wiki/Variables.txt for full list. Some examples:" >> /etc/dovecot/conf.d/10-mail.conf
echo "#" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   mail_location = maildir:~/Maildir" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   mail_location = mbox:~/mail:INBOX=/var/mail/%u" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   mail_location = mbox:/var/mail/%d/%1n/%n:INDEX=/var/indexes/%d/%1n/%n" >> /etc/dovecot/conf.d/10-mail.conf
echo "#" >> /etc/dovecot/conf.d/10-mail.conf
echo "# <doc/wiki/MailLocation.txt>" >> /etc/dovecot/conf.d/10-mail.conf
echo "#" >> /etc/dovecot/conf.d/10-mail.conf
echo "mail_location = maildir:/var/mail/vhosts/%d/%n/mail" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# If you need to set multiple mailbox locations or want to change default" >> /etc/dovecot/conf.d/10-mail.conf
echo "# namespace settings, you can do it by defining namespace sections." >> /etc/dovecot/conf.d/10-mail.conf
echo "#" >> /etc/dovecot/conf.d/10-mail.conf
echo "# You can have private, shared and public namespaces. Private namespaces" >> /etc/dovecot/conf.d/10-mail.conf
echo "# are for user's personal mails. Shared namespaces are for accessing other" >> /etc/dovecot/conf.d/10-mail.conf
echo "# users' mailboxes that have been shared. Public namespaces are for shared" >> /etc/dovecot/conf.d/10-mail.conf
echo "# mailboxes that are managed by sysadmin. If you create any shared or public" >> /etc/dovecot/conf.d/10-mail.conf
echo "# namespaces you'll typically want to enable ACL plugin also, otherwise all" >> /etc/dovecot/conf.d/10-mail.conf
echo "# users can access all the shared mailboxes, assuming they have permissions" >> /etc/dovecot/conf.d/10-mail.conf
echo "# on filesystem level to do so." >> /etc/dovecot/conf.d/10-mail.conf
echo "namespace inbox {" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # Namespace type: private, shared or public" >> /etc/dovecot/conf.d/10-mail.conf
echo "  #type = private" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # Hierarchy separator to use. You should use the same separator for all" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # namespaces or some clients get confused. '/' is usually a good one." >> /etc/dovecot/conf.d/10-mail.conf
echo "  # The default however depends on the underlying mail storage format." >> /etc/dovecot/conf.d/10-mail.conf
echo "  #separator = " >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # Prefix required to access this namespace. This needs to be different for" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # all namespaces. For example "Public/"." >> /etc/dovecot/conf.d/10-mail.conf
echo "  #prefix = " >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # Physical location of the mailbox. This is in same format as" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # mail_location, which is also the default for it." >> /etc/dovecot/conf.d/10-mail.conf
echo "  #location =" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # There can be only one INBOX, and this setting defines which namespace" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # has it." >> /etc/dovecot/conf.d/10-mail.conf
echo "  inbox = yes" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # If namespace is hidden, it's not advertised to clients via NAMESPACE" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # extension. You'll most likely also want to set list=no. This is mostly" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # useful when converting from another server with different namespaces which" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # you want to deprecate but still keep working. For example you can create" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # hidden namespaces with prefixes "~/mail/", "~%u/mail/" and "mail/"." >> /etc/dovecot/conf.d/10-mail.conf
echo "  #hidden = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # Show the mailboxes under this namespace with LIST command. This makes the" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # namespace visible for clients that don't support NAMESPACE extension." >> /etc/dovecot/conf.d/10-mail.conf
echo "  # "children" value lists child mailboxes, but hides the namespace prefix." >> /etc/dovecot/conf.d/10-mail.conf
echo "  #list = yes" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # Namespace handles its own subscriptions. If set to "no", the parent" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # namespace handles them (empty prefix should always have this as "yes")" >> /etc/dovecot/conf.d/10-mail.conf
echo "  #subscriptions = yes" >> /etc/dovecot/conf.d/10-mail.conf
echo "}" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Example shared namespace configuration" >> /etc/dovecot/conf.d/10-mail.conf
echo "#namespace {" >> /etc/dovecot/conf.d/10-mail.conf
echo "  #type = shared" >> /etc/dovecot/conf.d/10-mail.conf
echo "  #separator = /" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # Mailboxes are visible under "shared/user@domain/"" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # %%n, %%d and %%u are expanded to the destination user." >> /etc/dovecot/conf.d/10-mail.conf
echo "  #prefix = shared/%%u/" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # Mail location for other users' mailboxes. Note that %variables and ~/" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # expands to the logged in user's data. %%n, %%d, %%u and %%h expand to the" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # destination user's data." >> /etc/dovecot/conf.d/10-mail.conf
echo "  #location = maildir:%%h/Maildir:INDEX=~/Maildir/shared/%%u" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # Use the default namespace for saving subscriptions." >> /etc/dovecot/conf.d/10-mail.conf
echo "  #subscriptions = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "  # List the shared/ namespace only if there are visible shared mailboxes." >> /etc/dovecot/conf.d/10-mail.conf
echo "  #list = children" >> /etc/dovecot/conf.d/10-mail.conf
echo "#}" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Should shared INBOX be visible as "shared/user" or "shared/user/INBOX"?" >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_shared_explicit_inbox = yes" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# System user and group used to access mails. If you use multiple, userdb" >> /etc/dovecot/conf.d/10-mail.conf
echo "# can override these by returning uid or gid fields. You can use either numbers" >> /etc/dovecot/conf.d/10-mail.conf
echo "# or names. <doc/wiki/UserIds.txt>" >> /etc/dovecot/conf.d/10-mail.conf
echo "mail_uid = vmail" >> /etc/dovecot/conf.d/10-mail.conf
echo "mail_gid = mail" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Group to enable temporarily for privileged operations. Currently this is" >> /etc/dovecot/conf.d/10-mail.conf
echo "# used only with INBOX when either its initial creation or dotlocking fails." >> /etc/dovecot/conf.d/10-mail.conf
echo "# Typically this is set to "mail" to give access to /var/mail." >> /etc/dovecot/conf.d/10-mail.conf
echo "mail_privileged_group = vmail" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Grant access to these supplementary groups for mail processes. Typically" >> /etc/dovecot/conf.d/10-mail.conf
echo "# these are used to set up access to shared mailboxes. Note that it may be" >> /etc/dovecot/conf.d/10-mail.conf
echo "# dangerous to set these if users can create symlinks (e.g. if "mail" group is" >> /etc/dovecot/conf.d/10-mail.conf
echo "# set here, ln -s /var/mail ~/mail/var could allow a user to delete others'" >> /etc/dovecot/conf.d/10-mail.conf
echo "# mailboxes, or ln -s /secret/shared/box ~/mail/mybox would allow reading it)." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_access_groups =" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Allow full filesystem access to clients. There's no access checks other than" >> /etc/dovecot/conf.d/10-mail.conf
echo "# what the operating system does for the active UID/GID. It works with both" >> /etc/dovecot/conf.d/10-mail.conf
echo "# maildir and mboxes, allowing you to prefix mailboxes names with eg. /path/" >> /etc/dovecot/conf.d/10-mail.conf
echo "# or ~user/." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_full_filesystem_access = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "## Mail processes" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Don't use mmap() at all. This is required if you store indexes to shared" >> /etc/dovecot/conf.d/10-mail.conf
echo "# filesystems (NFS or clustered filesystem)." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mmap_disable = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Rely on O_EXCL to work when creating dotlock files. NFS supports O_EXCL" >> /etc/dovecot/conf.d/10-mail.conf
echo "# since version 3, so this should be safe to use nowadays by default." >> /etc/dovecot/conf.d/10-mail.conf
echo "#dotlock_use_excl = yes" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# When to use fsync() or fdatasync() calls:" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   optimized (default): Whenever necessary to avoid losing important data" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   always: Useful with e.g. NFS when write()s are delayed" >> /etc/dovecot/conf.d/10-mail.conf
echo "#   never: Never use it (best performance, but crashes can lose data)" >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_fsync = optimized" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Mail storage exists in NFS. Set this to yes to make Dovecot flush NFS caches" >> /etc/dovecot/conf.d/10-mail.conf
echo "# whenever needed. If you're using only a single mail server this isn't needed." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_nfs_storage = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Mail index files also exist in NFS. Setting this to yes requires" >> /etc/dovecot/conf.d/10-mail.conf
echo "# mmap_disable=yes and fsync_disable=no." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_nfs_index = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Locking method for index files. Alternatives are fcntl, flock and dotlock." >> /etc/dovecot/conf.d/10-mail.conf
echo "# Dotlocking uses some tricks which may create more disk I/O than other locking" >> /etc/dovecot/conf.d/10-mail.conf
echo "# methods. NFS users: flock doesn't work, remember to change mmap_disable." >> /etc/dovecot/conf.d/10-mail.conf
echo "#lock_method = fcntl" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Directory in which LDA/LMTP temporarily stores incoming mails >128 kB." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_temp_dir = /tmp" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Valid UID range for users, defaults to 500 and above. This is mostly" >> /etc/dovecot/conf.d/10-mail.conf
echo "# to make sure that users can't log in as daemons or other system users." >> /etc/dovecot/conf.d/10-mail.conf
echo "# Note that denying root logins is hardcoded to dovecot binary and can't" >> /etc/dovecot/conf.d/10-mail.conf
echo "# be done even if first_valid_uid is set to 0." >> /etc/dovecot/conf.d/10-mail.conf
echo "first_valid_uid = 5000 " >> /etc/dovecot/conf.d/10-mail.conf
echo "last_valid_uid = 5000" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Valid GID range for users, defaults to non-root/wheel. Users having" >> /etc/dovecot/conf.d/10-mail.conf
echo "# non-valid GID as primary group ID aren't allowed to log in. If user" >> /etc/dovecot/conf.d/10-mail.conf
echo "# belongs to supplementary groups with non-valid GIDs, those groups are" >> /etc/dovecot/conf.d/10-mail.conf
echo "# not set." >> /etc/dovecot/conf.d/10-mail.conf
echo "#first_valid_gid = 1" >> /etc/dovecot/conf.d/10-mail.conf
echo "#last_valid_gid = 0" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Maximum allowed length for mail keyword name. It's only forced when trying" >> /etc/dovecot/conf.d/10-mail.conf
echo "# to create new keywords." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_max_keyword_length = 50" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# ':' separated list of directories under which chrooting is allowed for mail" >> /etc/dovecot/conf.d/10-mail.conf
echo "# processes (ie. /var/mail will allow chrooting to /var/mail/foo/bar too)." >> /etc/dovecot/conf.d/10-mail.conf
echo "# This setting doesn't affect login_chroot, mail_chroot or auth chroot" >> /etc/dovecot/conf.d/10-mail.conf
echo "# settings. If this setting is empty, "/./" in home dirs are ignored." >> /etc/dovecot/conf.d/10-mail.conf
echo "# WARNING: Never add directories here which local users can modify, that" >> /etc/dovecot/conf.d/10-mail.conf
echo "# may lead to root exploit. Usually this should be done only if you don't" >> /etc/dovecot/conf.d/10-mail.conf
echo "# allow shell access for users. <doc/wiki/Chrooting.txt>" >> /etc/dovecot/conf.d/10-mail.conf
echo "#valid_chroot_dirs = " >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Default chroot directory for mail processes. This can be overridden for" >> /etc/dovecot/conf.d/10-mail.conf
echo "# specific users in user database by giving /./ in user's home directory" >> /etc/dovecot/conf.d/10-mail.conf
echo "# (eg. /home/./user chroots into /home). Note that usually there is no real" >> /etc/dovecot/conf.d/10-mail.conf
echo "# need to do chrooting, Dovecot doesn't allow users to access files outside" >> /etc/dovecot/conf.d/10-mail.conf
echo "# their mail directory anyway. If your home directories are prefixed with" >> /etc/dovecot/conf.d/10-mail.conf
echo "# the chroot directory, append "/." to mail_chroot. <doc/wiki/Chrooting.txt>" >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_chroot = " >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# UNIX socket path to master authentication server to find users." >> /etc/dovecot/conf.d/10-mail.conf
echo "# This is used by imap (for shared users) and lda." >> /etc/dovecot/conf.d/10-mail.conf
echo "#auth_socket_path = /var/run/dovecot/auth-userdb" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Directory where to look up mail plugins." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_plugin_dir = /usr/lib/dovecot/modules" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Space separated list of plugins to load for all services. Plugins specific to" >> /etc/dovecot/conf.d/10-mail.conf
echo "# IMAP, LDA, etc. are added to this list in their own .conf files." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_plugins = " >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "## Mailbox handling optimizations" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# The minimum number of mails in a mailbox before updates are done to cache" >> /etc/dovecot/conf.d/10-mail.conf
echo "# file. This allows optimizing Dovecot's behavior to do less disk writes at" >> /etc/dovecot/conf.d/10-mail.conf
echo "# the cost of more disk reads." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_cache_min_mail_count = 0" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# When IDLE command is running, mailbox is checked once in a while to see if" >> /etc/dovecot/conf.d/10-mail.conf
echo "# there are any new mails or other changes. This setting defines the minimum" >> /etc/dovecot/conf.d/10-mail.conf
echo "# time to wait between those checks. Dovecot can also use dnotify, inotify and" >> /etc/dovecot/conf.d/10-mail.conf
echo "# kqueue to find out immediately when changes occur." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mailbox_idle_check_interval = 30 secs" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Save mails with CR+LF instead of plain LF. This makes sending those mails" >> /etc/dovecot/conf.d/10-mail.conf
echo "# take less CPU, especially with sendfile() syscall with Linux and FreeBSD." >> /etc/dovecot/conf.d/10-mail.conf
echo "# But it also creates a bit more disk I/O which may just make it slower." >> /etc/dovecot/conf.d/10-mail.conf
echo "# Also note that if other software reads the mboxes/maildirs, they may handle" >> /etc/dovecot/conf.d/10-mail.conf
echo "# the extra CRs wrong and cause problems." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_save_crlf = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Max number of mails to keep open and prefetch to memory. This only works with" >> /etc/dovecot/conf.d/10-mail.conf
echo "# some mailbox formats and/or operating systems." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_prefetch_count = 0" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# How often to scan for stale temporary files and delete them (0 = never)." >> /etc/dovecot/conf.d/10-mail.conf
echo "# These should exist only after Dovecot dies in the middle of saving mails." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_temp_scan_interval = 1w" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "## Maildir-specific settings" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# By default LIST command returns all entries in maildir beginning with a dot." >> /etc/dovecot/conf.d/10-mail.conf
echo "# Enabling this option makes Dovecot return only entries which are directories." >> /etc/dovecot/conf.d/10-mail.conf
echo "# This is done by stat()ing each entry, so it causes more disk I/O." >> /etc/dovecot/conf.d/10-mail.conf
echo "# (For systems setting struct dirent->d_type, this check is free and it's" >> /etc/dovecot/conf.d/10-mail.conf
echo "# done always regardless of this setting)" >> /etc/dovecot/conf.d/10-mail.conf
echo "#maildir_stat_dirs = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# When copying a message, do it with hard links whenever possible. This makes" >> /etc/dovecot/conf.d/10-mail.conf
echo "# the performance much better, and it's unlikely to have any side effects." >> /etc/dovecot/conf.d/10-mail.conf
echo "#maildir_copy_with_hardlinks = yes" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Assume Dovecot is the only MUA accessing Maildir: Scan cur/ directory only" >> /etc/dovecot/conf.d/10-mail.conf
echo "# when its mtime changes unexpectedly or when we can't find the mail otherwise." >> /etc/dovecot/conf.d/10-mail.conf
echo "#maildir_very_dirty_syncs = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# If enabled, Dovecot doesn't use the S=<size> in the Maildir filenames for" >> /etc/dovecot/conf.d/10-mail.conf
echo "# getting the mail's physical size, except when recalculating Maildir++ quota." >> /etc/dovecot/conf.d/10-mail.conf
echo "# This can be useful in systems where a lot of the Maildir filenames have a" >> /etc/dovecot/conf.d/10-mail.conf
echo "# broken size. The performance hit for enabling this is very small." >> /etc/dovecot/conf.d/10-mail.conf
echo "#maildir_broken_filename_sizes = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "## mbox-specific settings" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Which locking methods to use for locking mbox. There are four available:" >> /etc/dovecot/conf.d/10-mail.conf
echo "#  dotlock: Create <mailbox>.lock file. This is the oldest and most NFS-safe" >> /etc/dovecot/conf.d/10-mail.conf
echo "#           solution. If you want to use /var/mail/ like directory, the users" >> /etc/dovecot/conf.d/10-mail.conf
echo "#           will need write access to that directory." >> /etc/dovecot/conf.d/10-mail.conf
echo "#  dotlock_try: Same as dotlock, but if it fails because of permissions or" >> /etc/dovecot/conf.d/10-mail.conf
echo "#               because there isn't enough disk space, just skip it." >> /etc/dovecot/conf.d/10-mail.conf
echo "#  fcntl  : Use this if possible. Works with NFS too if lockd is used." >> /etc/dovecot/conf.d/10-mail.conf
echo "#  flock  : May not exist in all systems. Doesn't work with NFS." >> /etc/dovecot/conf.d/10-mail.conf
echo "#  lockf  : May not exist in all systems. Doesn't work with NFS." >> /etc/dovecot/conf.d/10-mail.conf
echo "#" >> /etc/dovecot/conf.d/10-mail.conf
echo "# You can use multiple locking methods; if you do the order they're declared" >> /etc/dovecot/conf.d/10-mail.conf
echo "# in is important to avoid deadlocks if other MTAs/MUAs are using multiple" >> /etc/dovecot/conf.d/10-mail.conf
echo "# locking methods as well. Some operating systems don't allow using some of" >> /etc/dovecot/conf.d/10-mail.conf
echo "# them simultaneously." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mbox_read_locks = fcntl" >> /etc/dovecot/conf.d/10-mail.conf
echo "#mbox_write_locks = dotlock fcntl" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Maximum time to wait for lock (all of them) before aborting." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mbox_lock_timeout = 5 mins" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# If dotlock exists but the mailbox isn't modified in any way, override the" >> /etc/dovecot/conf.d/10-mail.conf
echo "# lock file after this much time." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mbox_dotlock_change_timeout = 2 mins" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# When mbox changes unexpectedly we have to fully read it to find out what" >> /etc/dovecot/conf.d/10-mail.conf
echo "# changed. If the mbox is large this can take a long time. Since the change" >> /etc/dovecot/conf.d/10-mail.conf
echo "# is usually just a newly appended mail, it'd be faster to simply read the" >> /etc/dovecot/conf.d/10-mail.conf
echo "# new mails. If this setting is enabled, Dovecot does this but still safely" >> /etc/dovecot/conf.d/10-mail.conf
echo "# fallbacks to re-reading the whole mbox file whenever something in mbox isn't" >> /etc/dovecot/conf.d/10-mail.conf
echo "# how it's expected to be. The only real downside to this setting is that if" >> /etc/dovecot/conf.d/10-mail.conf
echo "# some other MUA changes message flags, Dovecot doesn't notice it immediately." >> /etc/dovecot/conf.d/10-mail.conf
echo "# Note that a full sync is done with SELECT, EXAMINE, EXPUNGE and CHECK " >> /etc/dovecot/conf.d/10-mail.conf
echo "# commands." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mbox_dirty_syncs = yes" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Like mbox_dirty_syncs, but don't do full syncs even with SELECT, EXAMINE," >> /etc/dovecot/conf.d/10-mail.conf
echo "# EXPUNGE or CHECK commands. If this is set, mbox_dirty_syncs is ignored." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mbox_very_dirty_syncs = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Delay writing mbox headers until doing a full write sync (EXPUNGE and CHECK" >> /etc/dovecot/conf.d/10-mail.conf
echo "# commands and when closing the mailbox). This is especially useful for POP3" >> /etc/dovecot/conf.d/10-mail.conf
echo "# where clients often delete all mails. The downside is that our changes" >> /etc/dovecot/conf.d/10-mail.conf
echo "# aren't immediately visible to other MUAs." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mbox_lazy_writes = yes" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# If mbox size is smaller than this (e.g. 100k), don't write index files." >> /etc/dovecot/conf.d/10-mail.conf
echo "# If an index file already exists it's still read, just not updated." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mbox_min_index_size = 0" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Mail header selection algorithm to use for MD5 POP3 UIDLs when" >> /etc/dovecot/conf.d/10-mail.conf
echo "# pop3_uidl_format=%m. For backwards compatibility we use apop3d inspired" >> /etc/dovecot/conf.d/10-mail.conf
echo "# algorithm, but it fails if the first Received: header isn't unique in all" >> /etc/dovecot/conf.d/10-mail.conf
echo "# mails. An alternative algorithm is "all" that selects all headers." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mbox_md5 = apop3d" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "## mdbox-specific settings" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Maximum dbox file size until it's rotated." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mdbox_rotate_size = 2M" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Maximum dbox file age until it's rotated. Typically in days. Day begins" >> /etc/dovecot/conf.d/10-mail.conf
echo "# from midnight, so 1d = today, 2d = yesterday, etc. 0 = check disabled." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mdbox_rotate_interval = 0" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# When creating new mdbox files, immediately preallocate their size to" >> /etc/dovecot/conf.d/10-mail.conf
echo "# mdbox_rotate_size. This setting currently works only in Linux with some" >> /etc/dovecot/conf.d/10-mail.conf
echo "# filesystems (ext4, xfs)." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mdbox_preallocate_space = no" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "## Mail attachments" >> /etc/dovecot/conf.d/10-mail.conf
echo "##" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# sdbox and mdbox support saving mail attachments to external files, which" >> /etc/dovecot/conf.d/10-mail.conf
echo "# also allows single instance storage for them. Other backends don't support" >> /etc/dovecot/conf.d/10-mail.conf
echo "# this for now." >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# WARNING: This feature hasn't been tested much yet. Use at your own risk." >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Directory root where to store mail attachments. Disabled, if empty." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_attachment_dir =" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Attachments smaller than this aren't saved externally. It's also possible to" >> /etc/dovecot/conf.d/10-mail.conf
echo "# write a plugin to disable saving specific attachments externally." >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_attachment_min_size = 128k" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Filesystem backend to use for saving attachments:" >> /etc/dovecot/conf.d/10-mail.conf
echo "#  posix : No SiS done by Dovecot (but this might help FS's own deduplication)" >> /etc/dovecot/conf.d/10-mail.conf
echo "#  sis posix : SiS with immediate byte-by-byte comparison during saving" >> /etc/dovecot/conf.d/10-mail.conf
echo "#  sis-queue posix : SiS with delayed comparison and deduplication" >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_attachment_fs = sis posix" >> /etc/dovecot/conf.d/10-mail.conf
echo "" >> /etc/dovecot/conf.d/10-mail.conf
echo "# Hash format to use in attachment filenames. You can add any text and" >> /etc/dovecot/conf.d/10-mail.conf
echo "# variables: %{md4}, %{md5}, %{sha1}, %{sha256}, %{sha512}, %{size}." >> /etc/dovecot/conf.d/10-mail.conf
echo "# Variables can be truncated, e.g. %{sha256:80} returns only first 80 bits" >> /etc/dovecot/conf.d/10-mail.conf
echo "#mail_attachment_hash = %{sha1}" >> /etc/dovecot/conf.d/10-mail.conf

# Create folder of mail
mkdir -p /var/mail/vhosts/$domainName

# Create group vmail
groupadd -g 5000 vmail 
useradd -g vmail -u 5000 vmail -d /var/mail
chown -R vmail:vmail /var/mail

# Configuration of dovecot 10-auth.conf
echo "disable_plaintext_auth = yes" > /etc/dovecot/conf.d/10-auth.conf
echo "auth_mechanisms = plain login" >> /etc/dovecot/conf.d/10-auth.conf
echo "!include auth-sql.conf.ext" >> /etc/dovecot/conf.d/10-auth.conf

# Configuration of dovecot auth-sql.conf.ext
echo "passdb {" > /etc/dovecot/conf.d/auth-sql.conf.ext
echo "  driver = sql" >> /etc/dovecot/conf.d/auth-sql.conf.ext
echo "  args = /etc/dovecot/dovecot-sql.conf.ext" >> /etc/dovecot/conf.d/auth-sql.conf.ext
echo "}" >> /etc/dovecot/conf.d/auth-sql.conf.ext
echo "" >> /etc/dovecot/conf.d/auth-sql.conf.ext
echo "userdb {" >> /etc/dovecot/conf.d/auth-sql.conf.ext
echo "  driver = static" >> /etc/dovecot/conf.d/auth-sql.conf.ext
echo "  args = uid=vmail gid=vmail home=/var/mail/vhosts/%d/%n" >> /etc/dovecot/conf.d/auth-sql.conf.ext
echo "}"  >> /etc/dovecot/conf.d/auth-sql.conf.ext

# Configuration of dovecot-sql.conf.ext
echo "driver = mysql" > /etc/dovecot/dovecot-sql.conf.ext
echo "connect = host=127.0.0.1 dbname=postfix user=postfix password=$pass" >> /etc/dovecot/dovecot-sql.conf.ext
echo "" >> /etc/dovecot/dovecot-sql.conf.ext
echo "default_pass_scheme = MD5-CRYPT" >> /etc/dovecot/dovecot-sql.conf.ext
echo "" >> /etc/dovecot/dovecot-sql.conf.ext
echo "password_query = SELECT password FROM mailbox WHERE username = '%u'" >> /etc/dovecot/dovecot-sql.conf.ext

# Change permission on /etc/dovecot
chown -R vmail:dovecot /etc/dovecot
chmod -R o-rwx /etc/dovecot

# Configuration of 10-master.conf
echo "service imap-login {" > /etc/dovecot/conf.d/10-master.conf
echo "  inet_listener imap {" >> /etc/dovecot/conf.d/10-master.conf
echo "    port = 143" >> /etc/dovecot/conf.d/10-master.conf
echo "  }" >> /etc/dovecot/conf.d/10-master.conf
echo "  inet_listener imaps {" >> /etc/dovecot/conf.d/10-master.conf
echo "    port = 993" >> /etc/dovecot/conf.d/10-master.conf
echo "    ssl = yes" >> /etc/dovecot/conf.d/10-master.conf
echo "  }" >> /etc/dovecot/conf.d/10-master.conf
echo "  service_count = 0" >> /etc/dovecot/conf.d/10-master.conf
echo "}" >> /etc/dovecot/conf.d/10-master.conf
echo "" >> /etc/dovecot/conf.d/10-master.conf
echo "service imap {" >> /etc/dovecot/conf.d/10-master.conf
echo "}" >> /etc/dovecot/conf.d/10-master.conf
echo "" >> /etc/dovecot/conf.d/10-master.conf
echo "service lmtp {" >> /etc/dovecot/conf.d/10-master.conf
echo "  unix_listener /var/spool/postfix/private/dovecot-lmtp {" >> /etc/dovecot/conf.d/10-master.conf
echo "      mode = 0600" >> /etc/dovecot/conf.d/10-master.conf
echo "      user = postfix" >> /etc/dovecot/conf.d/10-master.conf
echo "      group = postfix" >> /etc/dovecot/conf.d/10-master.conf
echo "  }" >> /etc/dovecot/conf.d/10-master.conf
echo "}" >> /etc/dovecot/conf.d/10-master.conf
echo "" >> /etc/dovecot/conf.d/10-master.conf
echo "service auth {" >> /etc/dovecot/conf.d/10-master.conf
echo "  unix_listener /var/spool/postfix/private/auth {" >> /etc/dovecot/conf.d/10-master.conf
echo "      mode = 0666" >> /etc/dovecot/conf.d/10-master.conf
echo "      user = postfix" >> /etc/dovecot/conf.d/10-master.conf
echo "      group = postfix" >> /etc/dovecot/conf.d/10-master.conf
echo "  }" >> /etc/dovecot/conf.d/10-master.conf
echo "  unix_listener auth-userdb {" >> /etc/dovecot/conf.d/10-master.conf
echo "      mode = 0600" >> /etc/dovecot/conf.d/10-master.conf
echo "      user = vmail" >> /etc/dovecot/conf.d/10-master.conf
echo "      group = vmail" >> /etc/dovecot/conf.d/10-master.conf
echo "  }" >> /etc/dovecot/conf.d/10-master.conf
echo "  user = dovecot" >> /etc/dovecot/conf.d/10-master.conf
echo "}" >> /etc/dovecot/conf.d/10-master.conf
echo "" >> /etc/dovecot/conf.d/10-master.conf
echo "service auth-worker {" >> /etc/dovecot/conf.d/10-master.conf
echo "  user = vmail" >> /etc/dovecot/conf.d/10-master.conf
echo "}" >> /etc/dovecot/conf.d/10-master.conf

# Configuration of 10-ssl.conf
echo "ssl = required" > /etc/dovecot/conf.d/10-ssl.conf
echo "" >> /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_cert = </etc/letsencrypt/live/acert.$domainName/fullchain.pem" >> /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_key = </etc/letsencrypt/live/acert.$domainName/privkey.pem" >> /etc/dovecot/conf.d/10-ssl.conf
echo "" >> /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_cipher_list = AES128+EECDH:AES128+EDH" >> /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_prefer_server_ciphers = yes" >> /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_dh_parameters_length = 4096" >> /etc/dovecot/conf.d/10-ssl.conf
echo "ssl_protocols = !SSLv2 !SSLv3 !TLSv1 !TLSv1.1" >> /etc/dovecot/conf.d/10-ssl.conf

# Configuration of sieve
echo "protocol lmtp {" > /etc/dovecot/conf.d/20-lmtp.conf
echo "  postmaster_address = postmaster@$domainName" >> /etc/dovecot/conf.d/20-lmtp.conf
echo "  mail_plugins = \$mail_plugins sieve" >> /etc/dovecot/conf.d/20-lmtp.conf
echo "}" >> /etc/dovecot/conf.d/20-lmtp.conf

echo "plugin {" > /etc/dovecot/conf.d/90-sieve.conf
echo "   sieve = ~/.dovecot.sieve" >> /etc/dovecot/conf.d/90-sieve.conf
echo "   sieve_global_path = /var/lib/dovecot/sieve/default.sieve" >> /etc/dovecot/conf.d/90-sieve.conf
echo "   sieve_dir = ~/sieve" >> /etc/dovecot/conf.d/90-sieve.conf
echo "   sieve_global_dir = /var/lib/dovecot/sieve/" >> /etc/dovecot/conf.d/90-sieve.conf
echo "}" >> /etc/dovecot/conf.d/90-sieve.conf

mkdir -p /var/lib/dovecot/sieve/
touch /var/lib/dovecot/sieve/default.sieve &&  chown -R vmail:vmail /var/lib/dovecot/sieve/

echo "require \"fileinto\";" > /var/lib/dovecot/sieve/default.sieve
echo "if header :contains \"X-Spam-Flag\" \"YES\" {" >> /var/lib/dovecot/sieve/default.sieve
echo "  fileinto \"Spam\";" >> /var/lib/dovecot/sieve/default.sieve
echo "}" >> /var/lib/dovecot/sieve/default.sieve

# Launch Sieve
sievec /var/lib/dovecot/sieve/default.sieve

# Installation of OpenDKIM
apt-get -y install opendkim

# Generate public/private key
mkdir -p /etc/opendkim/
mv /etc/opendkim.conf /etc/opendkim/
ln -s /etc/opendkim/opendkim.conf /etc/opendkim.conf
openssl genrsa -out /etc/opendkim/opendkim.key 1024
openssl rsa -in /etc/opendkim/opendkim.key -pubout -out /etc/opendkim/opendkim.pub.key
chmod "u=rw,o=,g=" /etc/opendkim/opendkim.key
chown opendkim:opendkim /etc/opendkim/opendkim.key

# Configuration of OpenDKIM
echo "# This is a basic configuration that can easily be adapted to suit a standard" > /etc/opendkim/opendkim.conf
echo "# installation. For more advanced options, see opendkim.conf(5) and/or" >> /etc/opendkim/opendkim.conf
echo "# /usr/share/doc/opendkim/examples/opendkim.conf.sample." >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "# Log to syslog" >> /etc/opendkim/opendkim.conf
echo "Syslog                  yes" >> /etc/opendkim/opendkim.conf
echo "SyslogSuccess           yes" >> /etc/opendkim/opendkim.conf
echo "LogWhy                  yes" >> /etc/opendkim/opendkim.conf
echo "# Required to use local socket with MTAs that access the socket as a non-" >> /etc/opendkim/opendkim.conf
echo "# privileged user (e.g. Postfix)" >> /etc/opendkim/opendkim.conf
echo "UMask                   002" >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "# Sign for example.com with key in /etc/mail/dkim.key using" >> /etc/opendkim/opendkim.conf
echo "# selector '2007' (e.g. 2007._domainkey.example.com)" >> /etc/opendkim/opendkim.conf
echo "Domain                  $domainName" >> /etc/opendkim/opendkim.conf
echo "KeyFile                 /etc/opendkim/opendkim.key" >> /etc/opendkim/opendkim.conf
echo "Selector                dkim" >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "# Commonly-used options; the commented-out versions show the defaults." >> /etc/opendkim/opendkim.conf
echo "Canonicalization        simple" >> /etc/opendkim/opendkim.conf
echo "Mode                    sv" >> /etc/opendkim/opendkim.conf
echo "#SubDomains             no" >> /etc/opendkim/opendkim.conf
echo "#ADSPDiscard            no" >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "X-Header                yes" >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "# Always oversign From (sign using actual From and a null From to prevent" >> /etc/opendkim/opendkim.conf
echo "# malicious signatures header fields (From and/or others) between the signer" >> /etc/opendkim/opendkim.conf
echo "# and the verifier.  From is oversigned by default in the Debian pacakge" >> /etc/opendkim/opendkim.conf
echo "# because it is often the identity key used by reputation systems and thus" >> /etc/opendkim/opendkim.conf
echo "# somewhat security sensitive." >> /etc/opendkim/opendkim.conf
echo "OversignHeaders         From" >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "# List domains to use for RFC 6541 DKIM Authorized Third-Party Signatures" >> /etc/opendkim/opendkim.conf
echo "# (ATPS) (experimental)" >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "#ATPSDomains            example.com" >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "Socket                  inet:12345@localhost" >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "# Our KeyTable and SigningTable" >> /etc/opendkim/opendkim.conf
echo "KeyTable refile:/etc/opendkim/KeyTable" >> /etc/opendkim/opendkim.conf
echo "SigningTable refile:/etc/opendkim/SigningTable" >> /etc/opendkim/opendkim.conf
echo "" >> /etc/opendkim/opendkim.conf
echo "# Trusted Hosts" >> /etc/opendkim/opendkim.conf
echo "ExternalIgnoreList /etc/opendkim/TrustedHosts" >> /etc/opendkim/opendkim.conf
echo "InternalHosts /etc/opendkim/TrustedHosts" >> /etc/opendkim/opendkim.conf
echo "#ATPSDomains              example.com" >> /etc/opendkim/opendkim.conf

echo "SOCKET=\"inet:12345@localhost\"" >> /etc/default/opendkim

echo "$domainName	$domainName:dkim:/etc/opendkim/opendkim.key" > /etc/opendkim/KeyTable

echo "*@$domainName	$domainName" > /etc/opendkim/SigningTable

echo "127.0.0.1" > /etc/opendkim/TrustedHosts
echo "localhost" >> /etc/opendkim/TrustedHosts
echo "$domainName" >> /etc/opendkim/TrustedHosts
echo "mail.$domainName" >> /etc/opendkim/TrustedHosts

# Installation of OpenDMARC
apt-get -y install opendmarc

# Configuration of OpenDMARC		
echo "AutoRestart             Yes" > /etc/opendmarc.conf
echo "AutoRestartRate         10/1h" >> /etc/opendmarc.conf
echo "UMask                   0002" >> /etc/opendmarc.conf
echo "Syslog                  true" >> /etc/opendmarc.conf
echo "" > /etc/opendmarc.conf
echo "AuthservID              $domainName" >> /etc/opendmarc.conf
echo "TrustedAuthservIDs      $domainName" >> /etc/opendmarc.conf
echo "IgnoreHosts             /etc/opendmarc/TrustedHosts" >> /etc/opendmarc.conf
echo "" > /etc/opendmarc.conf
echo "RejectFailures          false" >> /etc/opendmarc.conf
echo "" > /etc/opendmarc.conf
echo "UserID                  opendmarc:opendmarc" >> /etc/opendmarc.conf
echo "PidFile                 /var/run/opendmarc.pid" >> /etc/opendmarc.conf

mkdir /etc/opendmarc

echo "127.0.0.1" > /etc/opendmarc/TrustedHosts
echo "localhost" >> /etc/opendmarc/TrustedHosts
echo "::1" >> /etc/opendmarc/TrustedHosts
echo "*@domain.tld" >> /etc/opendmarc/TrustedHosts

echo "# Command-line options specified here will override the contents of" > /etc/default/opendmarc
echo "# /etc/opendmarc.conf. See opendmarc(8) for a complete list of options." >> /etc/default/opendmarc
echo "#DAEMON_OPTS=\"\"" >> /etc/default/opendmarc
echo "#" >> /etc/default/opendmarc
echo "# Uncomment to specify an alternate socket" >> /etc/default/opendmarc
echo "# Note that setting this will override any Socket value in opendkim.conf" >> /etc/default/opendmarc
echo "#SOCKET=\"local:/var/run/opendmarc/opendmarc.sock\" # default" >> /etc/default/opendmarc
echo "#SOCKET=\"inet:54321\" # listen on all interfaces on port 54321" >> /etc/default/opendmarc
echo "#SOCKET=\"inet:12345@localhost\" # listen on loopback on port 12345" >> /etc/default/opendmarc
echo "#SOCKET=\"inet:12345@192.0.2.1\" # listen on 192.0.2.1 on port 12345" >> /etc/default/opendmarc
echo "SOCKET=\"inet:8892:localhost\"" >> /etc/default/opendmarc

# Installation of Rainloop
wget http://repository.rainloop.net/v2/webmail/rainloop-latest.zip
mkdir /var/www/rainloop
unzip rainloop-latest.zip -d /var/www/rainloop
rm -rf rainloop-latest.zip
mkdir /var/www/rainloop/logs/

cd /var/www/rainloop
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
chown -R www-data:www-data .
cd ~

# Apache2 configuration for Rainloop		
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/rainloop.conf
echo "ServerAdmin postmaster@$domainName" >> /etc/apache2/sites-available/rainloop.conf
echo "ServerName rainloop.$domainName" >> /etc/apache2/sites-available/rainloop.conf
echo "ServerAlias rainloop.$domainName" >> /etc/apache2/sites-available/rainloop.conf
echo "DocumentRoot /var/www/rainloop/" >> /etc/apache2/sites-available/rainloop.conf
echo "<Directory /var/www/rainloop/ >" >> /etc/apache2/sites-available/rainloop.conf
echo "AllowOverride All" >> /etc/apache2/sites-available/rainloop.conf
echo "</Directory>" >> /etc/apache2/sites-available/rainloop.conf
echo "ErrorLog /var/www/rainloop/logs/error.log" >> /etc/apache2/sites-available/rainloop.conf
echo "CustomLog /var/www/rainloop/logs/access.log combined" >> /etc/apache2/sites-available/rainloop.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/rainloop.conf

a2ensite rainloop.conf
systemctl restart apache2

# Installation of Postgrey
apt-get -y install postgrey

# Configuration of Postgrey
echo "# postgrey startup options, created for Debian" > /etc/default/postgrey
echo "# you may want to set" > /etc/default/postgrey
echo "#   --delay=N   how long to greylist, seconds (default: 300)" >> /etc/default/postgrey
echo "#   --max-age=N delete old entries after N days (default: 35)" >> /etc/default/postgrey
echo "# see also the postgrey(8) manpage" >> /etc/default/postgrey
echo "" >> /etc/default/postgrey
echo "POSTGREY_OPTS=\"--inet=10023\"" >> /etc/default/postgrey
echo "POSTGREY_TEXT=\"Server overload, try again later\"" >> /etc/default/postgrey
echo "" >> /etc/default/postgrey
echo "# the --greylist-text commandline argument can not be easily passed through" >> /etc/default/postgrey
echo "# POSTGREY_OPTS when it contains spaces.  So, insert your text here:" >> /etc/default/postgrey
echo "#POSTGREY_TEXT=\"Your customized rejection message here\"" >> /etc/default/postgrey

echo "# google" >> /etc/postgrey/whitelist_clients
echo "/^.*-out-.*\.google\.com$/" >> /etc/postgrey/whitelist_clients
echo "/^mail.*\.google\.com$/" >> /etc/postgrey/whitelist_clients
echo "/^smtpd\d+\.orange\.fr$/" >> /etc/postgrey/whitelist_clients


# Restart services
systemctl restart apache2

# Install Kanboard
# Dependency
apt-get -y install php7.0-sqlite3

# Download and extract kanboard
wget https://kanboard.net/kanboard-1.0.34.zip
unzip kanboard-1.0.34.zip -d /var/www/CairnGit/
rm kanboard-1.0.34.zip


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
sed -i 's/"DataSource": "mmuser:mostest@tcp(dockerhost:3306)\/mattermost_test?charset=utf8mb4,utf8",/"DataSource": "mattermost:'$pass'@tcp(localhost:3306)\/mattermost?charset=utf8",/g' /var/www/mattermost/config/config.json

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

systemctl daemon-reload
systemctl enable mattermost.service
systemctl start mattermost.service

# Configuration Apache2 for Mattermost
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/mattermost.conf
echo "ServerAdmin postmaster@$domainName" >> /etc/apache2/sites-available/mattermost.conf
echo "ServerName  discuss.$domainName" >> /etc/apache2/sites-available/mattermost.conf
echo "ServerAlias  discuss.$domainName" >> /etc/apache2/sites-available/mattermost.conf
echo "LoadModule proxy_module modules/mod_proxy.so" >> /etc/apache2/sites-available/mattermost.conf
echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /etc/apache2/sites-available/mattermost.conf
echo "DocumentRoot /var/www/mattermost/" >> /etc/apache2/sites-available/mattermost.conf
echo "ProxyPass / http://localhost:8065/" >> /etc/apache2/sites-available/mattermost.conf
echo "ProxyPassReverse / http://localhost:8065/" >> /etc/apache2/sites-available/mattermost.conf
echo "ErrorLog /var/www/mattermost/logs/error.log" >> /etc/apache2/sites-available/mattermost.conf
echo "CustomLog /var/www/mattermost/logs/access.log combined" >> /etc/apache2/sites-available/mattermost.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/mattermost.conf

a2ensite mattermost.conf
systemctl restart apache2

# Install framadate
# Install dependency
apt-get -y install php7.0-intl

#Create user framadate
USER="framadate"
echo "Creation of framadate user"
useradd -p $pass  -U -m $USER
echo "Creation of ".${USER}." user" OK

# Install framadate
cd /var/www/
git clone https://git.framasoft.org/framasoft/framadate.git
cd /var/www/framadate/
mkdir /var/www/framadate/logs
chown framadate:framadate -R /var/www/framadate
su -c "git checkout 0.9.6" framadate

#Install composer
cd /var/www/framadate/
su -c "php -r \"readfile('https://getcomposer.org/installer');\" | php" framadate
chmod +x /var/www/framadate/composer.phar
su -c "/var/www/framadate/composer.phar install" framadate
su -c "/var/www/framadate/composer.phar update" framadate
cd ~

# Create MySQL database for framadate
mysql -u root -p${pass} -e "CREATE DATABASE framadate;"
mysql -u root -p${pass} -e "CREATE USER 'framadate'@'localhost' IDENTIFIED BY '$pass';"
mysql -u root -p${pass} -e "GRANT USAGE ON *.* TO 'framadate'@'localhost';"
mysql -u root -p${pass} -e "GRANT ALL PRIVILEGES ON framadate.* TO framadate@localhost IDENTIFIED BY '$pass';"
mysql -u root -p${pass} -e "SELECT @@SESSION.sql_mode session"
echo "Auth ZERO_DATE"
mysql -u root -p${pass} -e "SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';"
mysql -u root -p${pass} -e "SELECT @@SESSION.sql_mode session"

# Configuration Apache2
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/framadate.conf
echo "ServerAdmin postmaster@$domainName" >> /etc/apache2/sites-available/framadate.conf
echo "ServerName framadate.$domainName" >> /etc/apache2/sites-available/framadate.conf
echo "ServerAlias framadate.$domainName" >> /etc/apache2/sites-available/framadate.conf
echo "DocumentRoot /var/www/framadate/" >> /etc/apache2/sites-available/framadate.conf
echo "<Directory /var/www/framadate/ >" >> /etc/apache2/sites-available/framadate.conf
echo "AllowOverride All" >> /etc/apache2/sites-available/framadate.conf
echo "</Directory>" >> /etc/apache2/sites-available/framadate.conf
echo "ErrorLog /var/www/framadate/logs/error.log" >> /etc/apache2/sites-available/framadate.conf
echo "CustomLog /var/www/framadate/logs/access.log combined" >> /etc/apache2/sites-available/framadate.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/framadate.conf

a2ensite framadate.conf
systemctl restart apache2

# Configuration framadate
echo "<?php" >> /var/www/framadate/app/inc/config.php
echo "/**" >> /var/www/framadate/app/inc/config.php
echo " * This software is governed by the CeCILL-B license. If a copy of this license" >> /var/www/framadate/app/inc/config.php
echo " * is not distributed with this file, you can obtain one at" >> /var/www/framadate/app/inc/config.php
echo " * http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt" >> /var/www/framadate/app/inc/config.php
echo " *" >> /var/www/framadate/app/inc/config.php
echo " * Authors of STUdS (initial project): Guilhem BORGHESI (borghesi@unistra.fr) and Raphaël DROZ" >> /var/www/framadate/app/inc/config.php
echo " * Authors of Framadate/OpenSondate: Framasoft (https://github.com/framasoft)" >> /var/www/framadate/app/inc/config.php
echo " *" >> /var/www/framadate/app/inc/config.php
echo " * =============================" >> /var/www/framadate/app/inc/config.php
echo " *" >> /var/www/framadate/app/inc/config.php
echo " * Ce logiciel est régi par la licence CeCILL-B. Si une copie de cette licence" >> /var/www/framadate/app/inc/config.php
echo " * ne se trouve pas avec ce fichier vous pouvez l'obtenir sur" >> /var/www/framadate/app/inc/config.php
echo " * http://www.cecill.info/licences/Licence_CeCILL-B_V1-fr.txt" >> /var/www/framadate/app/inc/config.php
echo " *" >> /var/www/framadate/app/inc/config.php
echo " * Auteurs de STUdS (projet initial) : Guilhem BORGHESI (borghesi@unistra.fr) et Raphaël DROZ" >> /var/www/framadate/app/inc/config.php
echo " * Auteurs de Framadate/OpenSondage : Framasoft (https://github.com/framasoft)" >> /var/www/framadate/app/inc/config.php
echo " */" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Fully qualified domain name of your webserver." >> /var/www/framadate/app/inc/config.php
echo "// If this is unset or empty, the servername is determined automatically." >> /var/www/framadate/app/inc/config.php
echo "// You *have to set this* if you are running Framedate behind a reverse proxy." >> /var/www/framadate/app/inc/config.php
echo "// const APP_URL = '<www.mydomain.fr>';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Application name" >> /var/www/framadate/app/inc/config.php
echo "const NOMAPPLICATION = 'Framadate';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Database administrator email" >> /var/www/framadate/app/inc/config.php
echo "const ADRESSEMAILADMIN = 'framadate@$domainName';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Email for automatic responses (you should set it to \"no-reply\")" >> /var/www/framadate/app/inc/config.php
echo "const ADRESSEMAILREPONSEAUTO = 'no-reply@$domainName';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Database server name, leave empty to use a socket" >> /var/www/framadate/app/inc/config.php
echo "const DB_CONNECTION_STRING = 'mysql:host=localhost;dbname=framadate;port=3306';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Database user" >> /var/www/framadate/app/inc/config.php
echo "const DB_USER= 'framadate';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Database password" >> /var/www/framadate/app/inc/config.php
echo "const DB_PASSWORD = '$pass';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Table name prefix" >> /var/www/framadate/app/inc/config.php
echo "const TABLENAME_PREFIX = 'fd_';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Name of the table that store migration script already executed" >> /var/www/framadate/app/inc/config.php
echo "const MIGRATION_TABLE = 'framadate_migration';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Default Language" >> /var/www/framadate/app/inc/config.php
echo "const DEFAULT_LANGUAGE = 'en';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// List of supported languages, fake constant as arrays can be used as constants only in PHP >=5.6" >> /var/www/framadate/app/inc/config.php
echo "\$ALLOWED_LANGUAGES = [" >> /var/www/framadate/app/inc/config.php
echo "    'fr' => 'Français'," >> /var/www/framadate/app/inc/config.php
echo "    'en' => 'English'," >> /var/www/framadate/app/inc/config.php
echo "    'es' => 'Español'," >> /var/www/framadate/app/inc/config.php
echo "    'de' => 'Deutsch'," >> /var/www/framadate/app/inc/config.php
echo "    'it' => 'Italiano'," >> /var/www/framadate/app/inc/config.php
echo "];" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Nom et emplacement du fichier image contenant le titre" >> /var/www/framadate/app/inc/config.php
echo "const IMAGE_TITRE = 'images/logo-framadate.png';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Clean URLs, boolean" >> /var/www/framadate/app/inc/config.php
echo "const URL_PROPRE = true;" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Use REMOTE_USER data provided by web server" >> /var/www/framadate/app/inc/config.php
echo "const USE_REMOTE_USER =  true;" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Path to the log file" >> /var/www/framadate/app/inc/config.php
echo "const LOG_FILE = 'admin/stdout.log';" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Days (after expiration date) before purge a poll" >> /var/www/framadate/app/inc/config.php
echo "const PURGE_DELAY = 60;" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php
echo "// Config" >> /var/www/framadate/app/inc/config.php
echo "\$config = [" >> /var/www/framadate/app/inc/config.php
echo "    /* general config */" >> /var/www/framadate/app/inc/config.php
echo "    'use_smtp' => true,                     // use email for polls creation/modification/responses notification" >> /var/www/framadate/app/inc/config.php
echo "    /* home */" >> /var/www/framadate/app/inc/config.php
echo "    'show_what_is_that' => true,            // display \"how to use\" section" >> /var/www/framadate/app/inc/config.php
echo "    'show_the_software' => true,            // display technical information about the software" >> /var/www/framadate/app/inc/config.php
echo "    'show_cultivate_your_garden' => true,   // display \"developpement and administration\" information" >> /var/www/framadate/app/inc/config.php
echo "    /* create_classic_poll.php / create_date_poll.php */" >> /var/www/framadate/app/inc/config.php
echo "    'default_poll_duration' => 180,         // default values for the new poll duration (number of days)." >> /var/www/framadate/app/inc/config.php
echo "    /* create_classic_poll.php */" >> /var/www/framadate/app/inc/config.php
echo "    'user_can_add_img_or_link' => true,     // user can add link or URL when creating his poll." >> /var/www/framadate/app/inc/config.php
echo "];" >> /var/www/framadate/app/inc/config.php
echo "" >> /var/www/framadate/app/inc/config.php		

cd  /var/www/framadate/

sed -i "1 s/<?php/<?php\n\$_SERVER[\'SERVER_NAME\']=\'framadate.$domainName\';\n\$_SERVER[\'SERVER_PORT\']=\'80\';/g" /var/www/framadate/admin/migration.php
php -f /var/www/framadate/admin/migration.php
sed -i "2,3d " /var/www/framadate/admin/migration.php
cd ~

mv /var/www/framadate/htaccess.txt /var/www/framadate/.htaccess
chown www-data -R /var/www/framadate

# Install Jitsi Meet
# Install dependency
apt-get -y  install apt-transport-https	

# Add repository
echo 'deb https://download.jitsi.org stable/' >> /etc/apt/sources.list.d/jitsi-stable.list
wget -qO -  https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -
apt update

# Install Jitsi Meet
apt-get -y  install jitsi-meet

# Start service prosody 
systemctl restart prosody

# Configuration of Jitsi Meet
echo "disableThirdPartyRequests: true," >> /etc/jitsi/meet/*-config.js

# Configuration Apache2
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/meet.conf
echo "    ServerName meet.$domainName" >> /etc/apache2/sites-available/meet.conf
echo "    DocumentRoot "/etc/jitsi/meet/"" >> /etc/apache2/sites-available/meet.conf
echo "" >> /etc/apache2/sites-available/meet.conf
echo "    SSLProxyEngine On" >> /etc/apache2/sites-available/meet.conf
echo "    RewriteEngine On" >> /etc/apache2/sites-available/meet.conf
echo "    RewriteCond %{REQUEST_URI} ^/[a-zA-Z0-9]+$" >> /etc/apache2/sites-available/meet.conf
echo "    RewriteRule ^/(.*)$ / [PT]" >> /etc/apache2/sites-available/meet.conf
echo "    RewriteRule ^/http-bind$ https://meet.$domainName:5281/http-bind [P,L]" >> /etc/apache2/sites-available/meet.conf
echo "" >> /etc/apache2/sites-available/meet.conf
echo "</Virtualhost>" >> /etc/apache2/sites-available/meet.conf

a2ensite meet
systemctl restart apache2

# Install Wisemapping
# Install dependency
apt-get -y install openjdk-9-jdk

# Create wisemapping user
useradd wisemapping
mkdir /var/www/wisemapping
chown wisemapping:wisemapping -R /var/www/wisemapping

# Download Wisemapping
cd /var/www/wisemapping
wget https://bitbucket.org/wisemapping/wisemapping-open-source/downloads/wisemapping-v4.0.3.zip
unzip wisemapping-v4.0.3.zip
mv wisemapping-v4.0.3/* . && rmdir wisemapping-v4.0.3 && rm wisemapping-v4.0.3.zip
cd ~

# Configuration MySQL
mysql -u root -p${pass} -e "CREATE DATABASE wisemapping;"
mysql -u root -p${pass} -e "CREATE USER 'wisemapping'@'localhost' IDENTIFIED BY '$pass';"
mysql -u root -p${pass} -e "GRANT USAGE ON *.* TO 'wisemapping'@'localhost';"
mysql -u root -p${pass} -e "GRANT ALL PRIVILEGES ON wisemapping.* TO 'wisemapping'@'localhost' IDENTIFIED BY '$pass';"

# Configuration Wisemapping
sed -i '6,12 s/^.//g' /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties
sed -i '26,32 s/^./#d/g' /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties		
sed -i "10 s/password=password/password=$pass/g" /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties
sed -i '95 s/^.//g' /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties
sed -i "95 s/example.com:8080/$domainName.8082/g" /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties
sed -i "44 s/mail.password=/mail.password=$pass/g" /var/www/wisemapping/webapps/wisemapping/WEB-INF/app.properties

# Configuration Apache2
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/wisemapping.conf
echo "ServerAdmin postmaster@$domainName" >> /etc/apache2/sites-available/wisemapping.conf
echo "ServerName  mindmap.$domainName" >> /etc/apache2/sites-available/wisemapping.conf
echo "ServerAlias  mindmap.$domainName" >> /etc/apache2/sites-available/wisemapping.conf
echo "LoadModule proxy_module modules/mod_proxy.so" >> /etc/apache2/sites-available/wisemapping.conf
echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /etc/apache2/sites-available/wisemapping.conf
echo "DocumentRoot /var/www/wisemapping/" >> /etc/apache2/sites-available/wisemapping.conf
echo "ProxyPass / http://localhost:8082/" >> /etc/apache2/sites-available/wisemapping.conf
echo "ProxyPassReverse / http://localhost:8082/" >> /etc/apache2/sites-available/wisemapping.conf
echo "ErrorLog /var/www/wisemapping/logs/error.log" >> /etc/apache2/sites-available/wisemapping.conf
echo "CustomLog /var/www/wisemapping/logs/access.log combined" >> /etc/apache2/sites-available/wisemapping.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/wisemapping.conf

a2ensite wisemapping.conf
systemctl restart apache2


# Launch Wisemapping
cd /var/www/wisemapping/
/var/www/wisemapping/start.sh &
cd ~

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

systemctl daemon-reload
systemctl enable wisemapping.service
systemctl start wisemapping.service

# Install Scrumblr
# Install dependency
apt-get -y install nodejs npm redis-server

# Create scrumblr user
useradd scrumblr		

# Install Scrumblr
cd /var/www/
git clone https://github.com/aliasaria/scrumblr.git
mkdir /var/www/scrumblr/logs/
chown scrumblr:scrumblr -R /var/www/scrumblr

# Install dependency
cd /var/www/scrumblr/
npm install
cd ~

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
echo "ExecStart=/usr/bin/nodejs server.js --port 4242" >> /etc/systemd/system/scrumblr.service

echo "[Install]" >> /etc/systemd/system/scrumblr.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/scrumblr.service

systemctl daemon-reload
systemctl enable scrumblr.service
systemctl start scrumblr.service

# Configuration Apache
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/scrumblr.conf
echo "ServerAdmin postmaster@$domainName" >> /etc/apache2/sites-available/scrumblr.conf
echo "ServerName  brainstorming.$domainName" >> /etc/apache2/sites-available/scrumblr.conf
echo "ServerAlias  brainstorming.$domainName" >> /etc/apache2/sites-available/scrumblr.conf
echo "LoadModule proxy_module modules/mod_proxy.so" >> /etc/apache2/sites-available/scrumblr.conf
echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /etc/apache2/sites-available/scrumblr.conf
echo "DocumentRoot /var/www/scrumblr/" >> /etc/apache2/sites-available/scrumblr.conf
echo "ProxyPass / http://localhost:4242/" >> /etc/apache2/sites-available/scrumblr.conf
echo "ProxyPassReverse / http://localhost:4242/" >> /etc/apache2/sites-available/scrumblr.conf
echo "ErrorLog /var/www/scrumblr/logs/error.log" >> /etc/apache2/sites-available/scrumblr.conf
echo "CustomLog /var/www/scrumblr/logs/access.log combined" >> /etc/apache2/sites-available/scrumblr.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/scrumblr.conf

a2ensite scrumblr
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
echo "ServerAdmin postmaster@$domainName" >> /etc/apache2/sites-available/CairnGit.conf
echo "ServerName  $domainName" >> /etc/apache2/sites-available/CairnGit.conf
echo "ServerAlias  $domainName" >> /etc/apache2/sites-available/CairnGit.conf
echo "DocumentRoot /var/www/CairnGit/" >> /etc/apache2/sites-available/CairnGit.conf
echo "<Directory /var/www/CairnGit/>" >> /etc/apache2/sites-available/CairnGit.conf
echo "Options Indexes FollowSymLinks" >> /etc/apache2/sites-available/CairnGit.conf
echo "AllowOverride all" >> /etc/apache2/sites-available/CairnGit.conf
echo "Order allow,deny" >> /etc/apache2/sites-available/CairnGit.conf
echo "allow from all" >> /etc/apache2/sites-available/CairnGit.conf
echo "</Directory>" >> /etc/apache2/sites-available/CairnGit.conf
echo "ErrorLog /var/www/CairnGit/logs/error.log" >> /etc/apache2/sites-available/CairnGit.conf
echo "CustomLog /var/www/CairnGit/logs/access.log combined" >> /etc/apache2/sites-available/CairnGit.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/CairnGit.conf

a2ensite CairnGit
systemctl restart apache2
echo -e "Configuration d'apache2.......\033[32mFait\033[00m"


# Cheat cert
echo "<VirtualHost *:80>" > /etc/apache2/sites-available/aCERT.conf
echo "ServerAdmin postmaster@$domainName" >> /etc/apache2/sites-available/aCERT.conf
echo "ServerName  acert.$domainName" >> /etc/apache2/sites-available/aCERT.conf
echo "ServerAlias  $domainName" >> /etc/apache2/sites-available/aCERT.conf
echo "DocumentRoot /var/www/CairnGit/" >> /etc/apache2/sites-available/aCERT.conf
echo "<Directory /var/www/CairnGit/>" >> /etc/apache2/sites-available/aCERT.conf
echo "Options Indexes FollowSymLinks" >> /etc/apache2/sites-available/aCERT.conf
echo "AllowOverride all" >> /etc/apache2/sites-available/aCERT.conf
echo "Order allow,deny" >> /etc/apache2/sites-available/aCERT.conf
echo "allow from all" >> /etc/apache2/sites-available/aCERT.conf
echo "</Directory>" >> /etc/apache2/sites-available/aCERT.conf
echo "ErrorLog /var/www/CairnGit/logs/error.log" >> /etc/apache2/sites-available/aCERT.conf
echo "CustomLog /var/www/CairnGit/logs/access.log combined" >> /etc/apache2/sites-available/aCERT.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/aCERT.conf

a2ensite aCERT
systemctl restart apache2

# Configuration letsencrypt cerbot
apt-get -y install python-letsencrypt-apache
letsencrypt --apache
#letsencrypt --apache -d $domainName -d rainloop.$domainName -d brainstorming.$domainName -d framadate.$domainName -d brainstorming.$domainName -d mindmap.$domainName -d postfixadmin.$domainName
echo -e "Installation de let's encrypt.......\033[32mFait\033[00m"

# Redirect all http
sed -i "s/<\/Directory>/<\/Directory>\nRedirect permanent \/ https:\/\/$domainName\//g" /etc/apache2/sites-available/CairnGit.conf
sed -i "s/<\/Directory>/<\/Directory>\nRedirect permanent \/ https:\/\/postfixadmin.$domainName\//g" /etc/apache2/sites-available/postfixadmin.conf
sed -i "s/DocumentRoot \/var\/www\/scrumblr\//DocumentRoot \/var\/www\/scrumblr\/\nRedirect permanent \/ https:\/\/brainstorming.$domainName\//g" /etc/apache2/sites-available/scrumblr.conf
sed -i "s/DocumentRoot \/var\/www\/wisemapping\//DocumentRoot \/var\/www\/wisemapping\/\nRedirect permanent \/ https:\/\/mindmap.$domainName\//g" /etc/apache2/sites-available/wisemapping.conf
sed -i "s/<\/Directory>/<\/Directory>\nRedirect permanent \/ https:\/\/framadate.$domainName\//g" /etc/apache2/sites-available/framadate.conf
sed -i "s/DocumentRoot \/var\/www\/mattermost\//DocumentRoot \/var\/www\/mattermost\/\nRedirect permanent \/ https:\/\/discuss.$domainName\//g" /etc/apache2/sites-available/mattermost.conf
sed -i "s/<\/Directory>/<\/Directory>\nRedirect permanent \/ https:\/\/rainloop.$domainName\//g" /etc/apache2/sites-available/rainloop.conf

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

# Cleanning
apt-get -y autoremove
echo -e "Cleaning .............\033[32mDone\033[00m"

# Restart services
systemctl restart apache2
systemctl restart postfix
systemctl restart dovecot
systemctl restart opendkim
systemctl restart opendmarc
systemctl restart postgrey

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
