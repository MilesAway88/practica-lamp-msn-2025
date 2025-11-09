#!/bin/bash

echo "--------------------------"
echo "Iniciando la aplicación..."
echo "--------------------------"

export GIT_TERMINAL_PROMPT=0
sudo git config --system credential.helper ""

source .env

echo "-------------------------------"
echo "Copiando archivos necesarios..."
echo "-------------------------------"
sudo rm -rf practica-lamp
sudo GIT_TERMINAL_PROMPT=0 git clone --depth 1 $APP_REPO practica-lamp
sudo cp -r practica-lamp/src/* $WEB_ROOT/
sudo cp -r practica-lamp/db/ $WEB_ROOT/
sudo cp ../conf/000-default.conf /etc/apache2/sites-available/
cd $WEB_ROOT

echo "----------------------------"
echo "Configurando los permisos..."
echo "----------------------------"
sudo chown -R www-data:www-data $WEB_ROOT
sudo chmod -R 755 $WEB_ROOT

echo "--------------------------------"
echo "Configurando la base de datos..."
echo "--------------------------------"
sudo sed -i "s/'database_name_here'/'$DB_NAME'/g" $WEB_ROOT/config.php
sudo sed -i "s/'username_here'/'$DB_USER'/g" $WEB_ROOT/config.php
sudo sed -i "s/'password_here'/'$DB_PASSWORD'/g" $WEB_ROOT/config.php

sudo mysql -u root -p$DB_ROOT_PASSWORD $DB_NAME < db/database.sql
sudo systemctl restart apache2

echo "----------------------------------------------"
echo "¡La aplicación se ha desplegado correctamente!"
echo "----------------------------------------------"