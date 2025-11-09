#!/bin/bash

# Instalación de LAMP en Debian
echo -e "\n-----------------------------------"
echo "Iniciando la instalación de LAMP..."
echo "-----------------------------------"
source .env
sudo apt update && sudo apt upgrade -y

sudo apt install -y git
sudo apt install -y apache2 apache2-utils
sudo apt install -y mariadb-server
sudo apt install -y php libapache2-mod-php php-mysql php-cli

# Iniciar los servicios
echo -e "\n--------------------------"
echo "Iniciando los servicios..."
echo "--------------------------"
sudo systemctl start apache2
sudo systemctl start mariadb
sudo systemctl enable apache2
sudo systemctl enable mariadb

# Configuración de la base de datos
echo -e "\n--------------------------------"
echo "Configurando la base de datos..."
echo "--------------------------------"
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('${DB_ROOT_PASSWORD}');" 2>/dev/null || true
sudo mysql -e "FLUSH PRIVILEGES;" 2>/dev/null || true

sudo mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
sudo mysql -u root -p${DB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
sudo mysql -u root -p${DB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'localhost';"
sudo mysql -u root -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Instalación automática de phpMyAdmin
echo -e "\n------------------------"
echo "Instalando phpMyAdmin..."
echo "------------------------"

echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password ${DB_ROOT_PASSWORD}" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password ${DB_ROOT_PASSWORD}" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password ${DB_ROOT_PASSWORD}" | sudo debconf-set-selections

sudo apt install -y phpmyadmin php-mbstring php-zip php-curl
sudo phpenmod mbstring

# Reinicio del servidor
#sudo a2enmod php
sudo systemctl restart apache2

# Probar que funciona
echo -e "\n---------------------"
echo "Realizando pruebas..."
echo "---------------------"
sudo mysql -u root -p${DB_ROOT_PASSWORD} -e "SHOW DATABASES;" && echo -e "\n¡La base de datos conecta correctamente!"

# Finalización de instalación
echo -e "\n------------------------------------"
echo "¡LAMP se ha instalado correctamente!"
echo -e "------------------------------------\n"
echo -e "** Versión de Apache: $(apache2 -v)\n"
echo -e "** Versión de MariaDB: $(mariadb --version)\n"
echo -e "** Versión de PHP: $(php --version)\n"

echo -e "\n--------------"
echo "¡HASTA PRONTO!"
echo -e "--------------\n"
