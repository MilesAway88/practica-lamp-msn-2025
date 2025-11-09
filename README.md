# Práctica LAMP 1 (en local y en AWS)

## Descripción
En esta tarea aprendemos a automatizar la instalación y despliegue de una pila LAMP junto a una aplicación web.

## Despliegue en local

1. Clonar los archivos del [proyecto][1]
2. Añadir permisos de ejecución a los scripts:<br>
    `chmod +x install-lamp.sh deploy.sh`
3. (Opcional) Modificar archivo .env con datos personalizados
4. Ejecutar archivo de instalación:<br>
    `sudo ./install-lamp.sh`
5. Ejecutar archivo de despliegue:<br>
    `sudo ./deploy.sh`
6. Comprobar funcionamiento en el navegador:<br>
    Ir a `http://localhost:80`

## Despliegue en AWS EC2

### Configuración de la instancia:
- **AMI:** Debian 13
- **Tipo:** t3.micro
- **Security Group:** Puertos 22 (SSH), 80 (HTTP), 443 (HTTPS) abiertos
- **IP Elástica:** [Tu IP elástica]

### Pasos a seguir:
1. Crear instancia EC2 con Debian
2. Configurar los grupos de seguridad
3. Asignar una IP Elástica
4. Conectar por SSH
5. Clonar repositorio con scripts
6. Ejecutar archivo de instalación:<br>
    `sudo ./install-lamp.sh`
7. Ejecutar archivo de despliegue:<br>
    `sudo ./deploy.sh`
8. Comprobar funcionamiento en el navegador:<br>
    Ir a `http://localhost:80`


>**~Notas sobre la práctica~**

>- Se instala *mariadb-server* porque en Debian moderno, *mysql-server* ha sido reemplazado por el primero.

>- Al instalar *mariadb-server*, automáticamente instala también *mariadb-cliente*, y crea un enlace simbólico entre `mysql` y `mariadb`.

>- La instalación de MariaDB en Debian ya es segura, por lo que no hace falta usar `mariadb-secure-installation`.

>- El comando `2>/dev/null || true` sirve para que no muestre un error, en caso de darlo, que sería en segundas instalaciones ya que *root* ya tendría contraseña.

>- No hace falta usar `a2enmod` con PHP en versiones modernas, ya que el módulo se habilita automáticamente al instalar `libapache2-mod-php`.

>- No hace falta usar `a2ensite` ya que el archivo `000-default.conf` ya viene habilitado por defecto.

>- Hay que cambiar propietario y dar permisos a Apache para que pueda ejecutar los scripts (usuario *www-data*)


[1]: https://github.com/MilesAway88/practica-lamp-msn-2025
[2]: https://github.com/CarlesCanals/practica-lamp
