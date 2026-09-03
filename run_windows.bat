@echo off
setlocal
cd /d "%~dp0"

echo ========================================
echo MY-PRIVATE-AI - Windows Starter
echo ========================================

if not exist ".venv\Scripts\python.exe" (
    echo [1/2] Erstelle Python-Umgebung...
    py -3 -m venv .venv
    if errorlevel 1 (
        echo Fehler: Python 3 wurde nicht gefunden.
        echo Installiere Python 3 und aktiviere "Add Python to PATH".
        pause
        exit /b 1
    )
)

echo [2/2] Installiere/aktualisiere Abhaengigkeiten...
call ".venv\Scripts\python.exe" -m pip install --upgrade pip
call ".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 (
    echo Fehler beim Installieren der Abhaengigkeiten.
    pause
    exit /b 1
)

echo.
echo Starte MY-PRIVATE-AI...
echo Browser: http://127.0.0.1:8000
start "MY-PRIVATE-AI" http://127.0.0.1:8000
".venv\Scripts\python.exe" -m uvicorn backend.main:app --host 127.0.0.1 --port 8000
pause
