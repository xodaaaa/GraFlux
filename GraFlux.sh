#!/bin/bash

# Función para verificar si un comando se ejecutó con éxito
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo apt update && sudo apt upgrade -y
check_command "No se pudo actualizar el sistema"

# Instalar dependencias
echo "Instalando dependencias..."
sudo apt install -y apt-transport-https ca-certificates software-properties-common docker-compose docker.io
check_command "No se pudieron instalar las dependencias"

# Verificar si existe la carpeta GraFlux y eliminarla si es necesario
if [ -d "GraFlux" ]; then
    echo "Se ha detectado una carpeta GraFlux existente. Eliminando..."
    sudo rm -rf GraFlux
    check_command "No se pudo eliminar la carpeta GraFlux existente"
fi

# Clonar el repositorio GraFlux
echo "Clonando el repositorio GraFlux..."
git clone https://github.com/xodaaaa/GraFlux.git
check_command "No se pudo clonar el repositorio"

# Cambiar al directorio GraFlux
cd GraFlux
check_command "No se pudo cambiar al directorio GraFlux"

# Crear volúmenes de Docker para InfluxDB y Grafana
echo "Creando volúmenes de Docker..."
sudo docker volume create influxdb_data
check_command "No se pudo crear el volumen para InfluxDB"
sudo docker volume create grafana_data
check_command "No se pudo crear el volumen para Grafana"

# Solicitar credenciales al usuario
echo "Por favor, introduce las credenciales para InfluxDB y Grafana:"
read -p "Usuario de InfluxDB: " influx_user
read -sp "Contraseña de InfluxDB: " influx_password
echo
read -p "Usuario de Grafana: " grafana_user
read -sp "Contraseña de Grafana: " grafana_password
echo

# Actualizar el archivo .env con las credenciales proporcionadas
echo "Actualizando el archivo .env..."
cat > .env << EOF
INFLUXDB_ADMIN_USER=$influx_user
INFLUXDB_ADMIN_PASSWORD=$influx_password
GF_SECURITY_ADMIN_USER=$grafana_user
GF_SECURITY_ADMIN_PASSWORD=$grafana_password
EOF
check_command "No se pudo actualizar el archivo .env"

# Levantar los contenedores con docker-compose
echo "Levantando los contenedores..."
sudo docker-compose up -d
check_command "No se pudieron levantar los contenedores"

# Función para verificar el estado de un contenedor
check_container() {
    container_name=$1
    max_attempts=30
    attempt=1

    while [ $attempt -le $max_attempts ]; do
        if sudo docker ps | grep -q $container_name; then
            echo "$container_name está en funcionamiento."
            return 0
        fi
        echo "Esperando a que $container_name se inicie... (intento $attempt de $max_attempts)"
        sleep 5
        attempt=$((attempt+1))
    done

    echo "Error: $container_name no se pudo iniciar después de $max_attempts intentos."
    return 1
}

# Verificar el estado de los contenedores
echo "Verificando el estado de los contenedores..."
if check_container "influxdb" && check_container "grafana"; then
    echo "Todos los contenedores están en funcionamiento."
    echo "GraFlux se ha iniciado correctamente."
else
    echo "Hubo un problema al iniciar uno o más contenedores."
    echo "Por favor, revisa los logs de Docker para más información."
fi
