Set-Location -Path "$PSScriptRoot"

# Inicializa repo, crea branch main, agrega remoto, commit y push
git init
git branch -M main
git remote add origin https://github.com/nhernandez-code/FastApi-Docker-02-09-26.git
git add .
git commit -m "Initial commit: FastAPI service with Docker and docs"
git push -u origin main
