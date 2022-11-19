# README

## Requisitos:
 - Docker
 - Docker Compose
 
## Para Ejecutar:

 ```bash
docker-compose build --no-cache
```
 ```bash
docker-compose up
```
```bash
docker-compose exec web rake:migrate
```
```bash
docker-compose exec web bundle exec rake assets:precompile
```
- Entrar a localhost:3000 en el navegador


El MVP asegura solo el correcto funcionamiento del siguiente "Happy Path":

- Crear a todos los ingenieros desde la ruta "/engineers"
- Crear la compañía e incluir a todos los ingenieros de prueba (directo desde la creación) desde la ruta "/companies", además en el mismo formulario de creación agregar la hora de inicio de los turnos para todos los días en formato 24hrs y horas exactas (sin minutos).
- Luego volver al index de compañias en '/companies' y apretar en "Show Company" y dentro presionar "Company Schedule" para desplegar las vistas requeridas del MVP.

## Consideraciones:
- El proyecto es Full-Stack en RoR con TailwindCss
- No se realizó el cambio de colores dinamicos según ingeniero debido a la limitaciones de TailwindCss.
- Se cambió el formato de los mockups para hacer más fácil la visualización de todos los turnos en una tabla.
- No se probó la actualización de los campos, por lo que no se garantiza el perfecto funcionamiento de las ediciones. En caso de un error en las creaciones se recomienda empezar el flujo de nuevo.
