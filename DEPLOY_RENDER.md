# Despliegue continuo en Render (guía rápida)

Este repositorio incluye una acción de GitHub Actions (`.github/workflows/deploy.yml`) que ejecuta pruebas y, en caso de éxito, dispara un despliegue en Render mediante su API.

Pasos para habilitar despliegue continuo:

1. Crea una cuenta en Render (https://render.com) e inicia sesión.

2. Crea un nuevo *Web Service* en Render (opcional) o toma el `service id` de un servicio existente:
   - En el Dashboard selecciona tu servicio y abre **Settings** → **General**. El identificador del servicio aparece en la URL o en la sección de settings (ej. `srv-xxxxx`). Guarda ese `service id`.

3. Genera un API Key en Render:
   - En Render: Account → API Keys → Create API Key. Copia el valor del token.

4. Guarda las credenciales como *secrets* en GitHub:
   - Ve a tu repositorio en GitHub → Settings → Secrets and variables → Actions → New repository secret.
   - Crea dos secrets:
     - `RENDER_API_KEY` — pega el API Key de Render.
     - `RENDER_SERVICE_ID` — pega el `service id` del servicio que quieres desplegar.

5. Confirmar que la rama por defecto del workflow es `main`. Cada push a `main` ejecutará el workflow y, si pasa las pruebas, hará una petición a la API de Render para crear un deploy.

6. (Alternativa / más simple) — Conexión directa GitHub ↔ Render:
   - Si prefieres, en Render puedes conectar directamente el repo de GitHub al crear el Web Service. Render puede desplegar automáticamente cada push sin necesidad de GitHub Actions.

Notas y recomendaciones:
 - El workflow de ejemplo espera `requirements.txt` en la raíz y usa Python 3.11. Modifica el archivo si tu proyecto usa otra configuración.
 - Si prefieres que Render construya la imagen desde el Dockerfile del repo, configura el Web Service en Render como tipo "Docker" o "Web Service (Docker)" y deja que Render gestione el build.
 - Para debug: revisa la pestaña *Actions* en GitHub para ver los logs del job; la respuesta de la API de Render se mostrará en la salida del paso `Trigger Render deploy via API`.
