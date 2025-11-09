# Práctica LAMP 1 (en local y en AWS)

## Descripción
En esta tarea aprendemos a automatizar la instalación y despliegue de una pila LAMP junto a una aplicación web.

## Despliegue en local

1. Clonar los archivos del [proyecto][1]

## Despliegue en AWS EC2

### Configuración de la instancia:
- **AMI:** Debian 12
- **Tipo:** t2.micro
- **Security Group:** Puertos 22 (SSH), 80 (HTTP), 443 (HTTPS) abiertos
- **IP Elástica:** [Tu IP aquí]

### Pasos ejecutados:
1. Crear instancia EC2 con Debian
2. Configurar Security Group
3. Asignar IP Elástica
4. Conectar por SSH
5. Clonar repositorio con scripts
6. Ejecutar `install-lamp.sh`
7. Ejecutar `deploy.sh`
8. Verificar funcionamiento en navegador# Práctica LAMP 1 (local y en AWS)



- Instalo mariadb-server porque en Debian moderno, mysql-server ha sido reemplazado por el primero.

- Al instalar mariadb-server, automáticamente instala mariadb-server y mariadb-cliente. Crea un enlace simbólico (mysql ---> mariadb)

- La instalación de MariaDB en Debian ya es segura, por lo que no hace falta usar mariadb-secure-installation.

- El comando "2>/dev/null || true" sirve para que no muestre error en caso de darlo (que sería en segundas instalaciones porque root ya tendría contraseña)

- No hace falta usar "a2enmod" con php en versiones modernas, ya que el módulo se habilita automáticamente al instalar "libapache2-mod-php"

- No hace falta usar "a2ensite" ya que el archivo "000-default.conf" ya viene habilitado por defecto.

- Hay que dar permisos de ejecución (dentro de la carpeta "scripts", ejecutar el comando "chmod +x install_lamp.sh deploy.sh")

- Luego se ejecuta: sudo ./install_lamp.sh + sudo ./deploy.sh


(BUSCAR lo de "sudo chown -R www-data:www-data /var/www/html" y "sudo chmod -R 755 /var/www/html")


[1]: https://github.com/MilesAway88/Despliegue-de-una-LAMP-sencilla
