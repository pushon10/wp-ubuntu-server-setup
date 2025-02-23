#!/bin/bash

# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Try: sudo $0"
   exit 1
fi

# Variables (Change these if needed)
DB_NAME="wordpress"
DB_USER="wpuser"
DB_PASS="StrongPassword123!"
APACHE_CONF="/etc/apache2/sites-available/wordpress.conf"
WP_PATH="/var/www/html/wordpress"

echo "Updating system packages..."
apt update && apt upgrade -y

echo "Installing Apache, MySQL, PHP, and dependencies..."
apt install -y apache2 mysql-server php php-mysql libapache2-mod-php unzip wget tar

echo "Starting and enabling Apache..."
systemctl start apache2
systemctl enable apache2

echo "Configuring UFW firewall..."
ufw allow 'Apache Full'
ufw enable

echo "Securing MySQL installation and automating appropriate responses to MySQL prompts..."
mysql_secure_installation <<EOF

Y
$DB_PASS
$DB_PASS
Y
Y
Y
Y
EOF

echo "Setting up MySQL database and user..."
mysql -u root -p$DB_PASS <<EOF
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EXIT;
EOF

echo "Downloading and setting up WordPress..."
cd /var/www/html
rm -rf wordpress
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
rm latest.tar.gz
chown -R www-data:www-data $WP_PATH
chmod -R 755 $WP_PATH

echo "Configuring WordPress..."
cp $WP_PATH/wp-config-sample.php $WP_PATH/wp-config.php
sed -i "s/database_name_here/$DB_NAME/" $WP_PATH/wp-config.php
sed -i "s/username_here/$DB_USER/" $WP_PATH/wp-config.php
sed -i "s/password_here/$DB_PASS/" $WP_PATH/wp-config.php

echo "Setting up Apache for WordPress..."
cat <<EOF > $APACHE_CONF
<VirtualHost *:80>
    ServerAdmin admin@yourdomain.com
    DocumentRoot /var/www/html/wordpress
    <Directory /var/www/html/wordpress>
        AllowOverride All
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

echo "Enabling Apache site and mod_rewrite..."
a2ensite wordpress
a2enmod rewrite
systemctl restart apache2

echo "✅ WordPress installation completed!"
echo "👉 Visit http://your-server-ip/wordpress in your browser to finish setup."
