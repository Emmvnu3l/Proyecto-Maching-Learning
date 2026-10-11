@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title Proyecto ML - Setup y JupyterLab

echo ============================================
echo   Proyecto Machine Learning - Inicio
echo ============================================
echo.

REM ---------- 1. Servidor ya corriendo? Reusarlo ----------
curl -s -o nul --max-time 3 http://localhost:8888/lab
if not errorlevel 1 (
    echo [OK] Ya hay un servidor Jupyter corriendo.
    echo      Abriendo el navegador en la carpeta raiz...
    start "" "http://localhost:8888/lab/tree/"
    exit /b 0
)

REM ---------- 2. Buscar Python ----------
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

REM ---------- 3. Crear entorno virtual si no existe ----------
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

REM ---------- 4. Verificar e instalar dependencias ----------
if not exist "requirements.txt" (
    echo [ERROR] No se encontro requirements.txt en esta carpeta.
    pause
    exit /b 1
)
echo [..] Verificando dependencias (se instalara solo lo que falte) ...
".venv\Scripts\python.exe" -m pip install -q -r requirements.txt
if errorlevel 1 (
    echo [ERROR] Fallo la instalacion de dependencias.
    pause
    exit /b 1
)
echo [OK] Dependencias listas.

REM ---------- 5. Configuracion de Jupyter sin token ----------
if not exist ".venv\etc\jupyter" mkdir ".venv\etc\jupyter"
> ".venv\etc\jupyter\jupyter_server_config.py" (
    echo c.IdentityProvider.token = ""
    echo c.ServerApp.password = ""
)

REM ---------- 6. Limpiar estado guardado de JupyterLab ----------
REM (para que el explorador de archivos abra siempre en la raiz)
if exist ".venv\share\jupyter\lab\workspaces" (
    del /q ".venv\share\jupyter\lab\workspaces\*.jupyterlab-workspace" >nul 2>&1
)
if exist "%APPDATA%\jupyter\lab\workspaces" (
    del /q "%APPDATA%\jupyter\lab\workspaces\*.jupyterlab-workspace" >nul 2>&1
)

REM ---------- 7. Levantar JupyterLab ----------
echo.
echo [OK] Todo listo. Levantando JupyterLab...
echo.

start "JupyterLab Server" /min ".venv\Scripts\jupyter.exe" lab --no-browser --ServerApp.root_dir="%~dp0."

:wait_server
curl -s -o nul --max-time 2 http://localhost:8888/lab
if errorlevel 1 (
    timeout /t 1 /nobreak >nul
    goto wait_server
)

start "" "http://localhost:8888/lab/tree/"

echo [OK] JupyterLab abierto en el navegador.
echo.
echo      El servidor sigue corriendo en la ventana "JupyterLab Server"
echo      (minimizada en la barra de tareas). Para detenerlo,
echo      cierra esa ventana o presiona Ctrl+C en ella.
echo.
pause
