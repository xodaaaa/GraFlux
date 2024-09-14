# GraFlux

GraFlux es un script de instalación automatizada para configurar un entorno de monitoreo con InfluxDB y Grafana utilizando Docker.

## Requisitos previos

- Sistema operativo basado en Debian (por ejemplo, Ubuntu)
- Acceso de superusuario (sudo)
- Conexión a Internet

## Instalación

1. Descarga el script de instalación:

   ```bash
   wget https://raw.githubusercontent.com/xodaaaa/GraFlux/main/install.sh
   ```

2. Dale permisos de ejecución al script:

   ```bash
   chmod +x install.sh
   ```

3. Ejecuta el script:

   ```bash
   ./install.sh
   ```

## Funcionalidades

El script realiza las siguientes acciones:

- Actualiza el sistema
- Instala las dependencias necesarias (Docker, Docker Compose, etc.)
- Clona el repositorio GraFlux
- Crea volúmenes de Docker para InfluxDB y Grafana
- Solicita credenciales para InfluxDB y Grafana
- Configura las variables de entorno
- Inicia los contenedores de InfluxDB y Grafana
- Verifica el estado de los contenedores

## Estructura del proyecto

```
GraFlux/
├── docker-compose.yml
├── .env
└── install.sh
```

## Uso

Una vez que la instalación se haya completado con éxito, puedes acceder a:

- Grafana: `http://localhost:3000`
- InfluxDB: `http://localhost:8086`

Utiliza las credenciales que proporcionaste durante la instalación para iniciar sesión.

## Solución de problemas

Si encuentras algún problema durante la instalación, el script mostrará mensajes de error específicos. Algunos problemas comunes pueden ser:

- Falta de permisos: Asegúrate de ejecutar el script con privilegios de sudo.
- Puertos en uso: Verifica que los puertos 3000 y 8086 no estén siendo utilizados por otros servicios.
- Problemas de red: Asegúrate de tener una conexión a Internet estable.

Para obtener más información sobre los errores, puedes revisar los logs de Docker:

```bash
sudo docker logs influxdb
sudo docker logs grafana
```

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o un pull request en el repositorio de GitHub.
