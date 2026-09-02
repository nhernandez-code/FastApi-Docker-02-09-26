# Servicio FastAPI: /obtenercedula

Este pequeño servicio FastAPI expone un endpoint que devuelve un número entero aleatorio de 10 dígitos.

## Instalación (local)

```bash
pip install -r requirements.txt
```

Ejecutar localmente:

```bash
uvicorn main:app --reload
```

## Endpoint

- `GET /obtenercedula` — devuelve un JSON con un número entero aleatorio de 10 dígitos.

Respuesta de ejemplo:

```json
1234567890
```

Ejemplo de cURL:

```bash
curl http://localhost:8000/obtenercedula
```

## Docker

Se provee un `Dockerfile` y `docker-compose.yml` para ejecutar la aplicación en un contenedor.

Construir imagen manualmente:

```bash
docker build -t taller-fastapi .
```

Levantar con Docker Compose:

```bash
docker compose up --build
```

Si tu instalación usa `docker-compose` (v1):

```bash
docker-compose up --build
```

El servicio quedará escuchando en el puerto `8000` del host y se podrá acceder en `http://localhost:8000`.

## Swagger (OpenAPI)

FastAPI expone la documentación automática en las siguientes rutas (cuando el servidor está corriendo):

- Interfaz Swagger: `http://localhost:8000/docs`
- Interfaz ReDoc: `http://localhost:8000/redoc`

Usa Swagger para probar `GET /obtenercedula` desde el navegador sin herramientas adicionales.

## Postman

Importar la petición usando cURL:

1. Abre Postman → Import → Raw Text
2. Pega:

```bash
curl http://localhost:8000/obtenercedula
```

3. Importa y ejecuta la petición GET.

O crea manualmente una nueva petición:

- Method: `GET`
- URL: `http://localhost:8000/obtenercedula`

## Notas

- El endpoint devuelve directamente un número entero en el cuerpo de la respuesta (JSON). Si prefieres un objeto con clave, puedo cambiar la respuesta a `{ "cedula": 1234567890 }`.
- Para producción, se recomienda ejecutar Uvicorn con múltiples workers (por ejemplo, usando `gunicorn` con `uvicorn.workers.UvicornWorker`) y ajustes de logging.

---

Archivos relevantes:

- [main.py](main.py)
- [Dockerfile](Dockerfile)
- [docker-compose.yml](docker-compose.yml)
