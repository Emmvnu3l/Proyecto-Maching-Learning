@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title Proyecto ML - Setup y JupyterLab

echo ============================================
echo   Proyecto Machine Learning - Inicio
echo ============================================
echo.

REM ---------- 1. Buscar Python ----------
set "PY="
py -3 --version >nul 2>&1 && set "PY=py -3"
if not defined PY (
    python --version >nul 2>&1 && set "PY=python"
)
if not defined PY (
    echo [ERROR] No se encontro Python en este PC.
    echo.
    echo Instala Python desde https://www.python.org/downloads/
    echo IMPORTANTE: marca la casilla "Add python.exe to PATH"
    echo durante la instalacion y vuelve a ejecutar este archivo.
    echo.
    pause
    exit /b 1
)
echo [OK] Python encontrado.

REM ---------- 2. Crear entorno virtual si no existe ----------
if exist ".venv\Scripts\python.exe" (
    echo [OK] Entorno virtual .venv ya existe.
) else (
    echo [..] Creando entorno virtual .venv ...
    %PY% -m venv .venv
    if errorlevel 1 (
        echo [ERROR] No se pudo crear el entorno virtual.
        pause
        exit /b 1
    )
)

if not exist ".venv\Scripts\pip.exe" (
    echo [..] Instalando pip en el entorno virtual ...
    ".venv\Scripts\python.exe" -m ensurepip --upgrade
)

REM ---------- 3. Verificar e instalar dependencias ----------
if not exist "requirements.txt" (
    echo [ERROR] No se encontro requirements.txt en esta carpeta.
    pause
    exit /b 1
)
echo [..] Verificando dependencias (se instalara solo lo que falte) ...
".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 (
    echo [ERROR] Fallo la instalacion de dependencias.
    pause
    exit /b 1
)
echo [OK] Dependencias listas.

REM ---------- 4. Configuracion de Jupyter sin token ----------
if not exist ".venv\etc\jupyter" mkdir ".venv\etc\jupyter"
> ".venv\etc\jupyter\jupyter_server_config.py" (
    echo c.IdentityProvider.token = ""
    echo c.ServerApp.password = ""
)

REM ---------- 5. Levantar JupyterLab ----------
echo.
echo [OK] Todo listo. Abriendo JupyterLab en el navegador...
echo      Para detener el servidor: Ctrl+C en esta ventana.
echo.
".venv\Scripts\jupyter.exe" lab

pause
