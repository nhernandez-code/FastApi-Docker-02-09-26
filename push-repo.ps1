#!/usr/bin/env pwsh
Set-Location -Path "$PSScriptRoot"

# Encuentra git.exe en ubicaciones comunes
$possible = @("C:\Program Files\Git\cmd\git.exe", "C:\Program Files\Git\bin\git.exe", "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe")
$gitExe = $possible | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $gitExe) {
    Write-Error "No se encontró git.exe en rutas comunes. Asegúrate de que Git esté instalado y en PATH."
    exit 1
}

Write-Host "Usando git: $gitExe"

# Parámetros
$remoteUrl = 'https://github.com/nhernandez-code/FastApi-Docker-02-09-26.git'
$branch = 'main'

function Run-Git {
    param([string[]]$Args)
    & $gitExe @Args
    if ($LASTEXITCODE -ne 0) {
        throw "Comando git falló: $($Args -join ' ')"
    }
}

try {
    # Asegurarse de estar en un repo
    $isRepo = (& $gitExe rev-parse --is-inside-work-tree) 2>$null
    if (-not $isRepo) {
        Write-Error "Este directorio no es un repositorio Git. Inicializa o ejecuta en la carpeta del repo."
        exit 1
    }

    # Configurar remoto si hace falta
    $remotes = & $gitExe remote
    if ($remotes -notmatch 'origin') {
        Write-Host "Agregando remoto origin -> $remoteUrl"
        Run-Git remote add origin $remoteUrl
    } else {
        # comprobar URL existente
        $current = (& $gitExe remote get-url origin) -join ""
        if ($current -ne $remoteUrl) {
            Write-Host "Remoto origin existe con URL diferente. Actualizando a $remoteUrl"
            Run-Git remote set-url origin $remoteUrl
        } else {
            Write-Host "Remoto origin ya configurado correctamente."
        }
    }

    # Asegurar branch main
    Run-Git branch -M $branch

    # Push
    Write-Host "Haciendo push a origin/$branch..."
    & $gitExe push -u origin $branch
    if ($LASTEXITCODE -ne 0) {
        throw "Push falló. Revisa credenciales o configura autenticación (PAT/SSH)."
    }

    Write-Host "Push completado."
} catch {
    Write-Error $_.Exception.Message
    exit 1
}
