# GraFlux Setup Script

Este script automatiza la instalación y configuración de **InfluxDB** y **Grafana** mediante Docker y `docker-compose`. Además, permite al usuario definir credenciales personalizadas para ambos servicios. 

## Requisitos previos

Antes de ejecutar el script, asegúrate de cumplir con los siguientes requisitos:

- Ubuntu/Debian como sistema operativo.
- Tener `git` instalado para clonar el repositorio GraFlux.
- Acceso a `sudo` para instalar paquetes y levantar contenedores Docker.

## Pasos realizados por el script

1. **Actualización del sistema:** Actualiza la lista de paquetes e instala actualizaciones.
2. **Instalación de dependencias:** Instala `apt-transport-https`, `ca-certificates`, `software-properties-common`, `docker-compose` y `docker.io`.
3. **Eliminación del directorio GraFlux existente:** Si existe el directorio GraFlux, lo elimina.
4. **Clonación del repositorio GraFlux:** Descarga el código fuente desde GitHub.
5. **Creación de volúmenes Docker:** Crea volúmenes persistentes para almacenar datos de InfluxDB y Grafana.
6. **Solicita credenciales del usuario:** Solicita al usuario las credenciales para InfluxDB y Grafana.
7. **Actualización del archivo `.env`:** Actualiza el archivo `.env` con las credenciales proporcionadas.
8. **Levantamiento de contenedores:** Usa `docker-compose` para levantar los servicios de InfluxDB y Grafana.
9. **Verificación del estado de los contenedores:** Comprueba si ambos contenedores se han iniciado correctamente.

## Instrucciones de uso

1. Clona este repositorio:

    ```bash
    git clone https://github.com/xodaaaa/GraFlux.git
    ```

2. Ejecuta el script:

    ```bash
    chmod +x setup_graflux.sh
    ./setup_graflux.sh
    ```

3. Sigue las instrucciones en pantalla para introducir las credenciales de InfluxDB y Grafana.

## Personalización

Si deseas cambiar las credenciales de InfluxDB y Grafana después de ejecutar el script, simplemente edita el archivo `.env` que se encuentra en el directorio GraFlux.

```bash
nano GraFlux/.env
