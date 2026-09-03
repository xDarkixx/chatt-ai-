@echo off
setlocal
cd /d "%~dp0"

echo ========================================
echo MY-PRIVATE-AI - Windows EXE Builder
echo ========================================

if not exist ".venv\Scripts\python.exe" (
    py -3 -m venv .venv
    if errorlevel 1 (
        echo Fehler: Python 3 wurde nicht gefunden.
        pause
        exit /b 1
    )
)

call ".venv\Scripts\python.exe" -m pip install --upgrade pip
call ".venv\Scripts\python.exe" -m pip install -r requirements.txt pyinstaller
if errorlevel 1 (
    echo Fehler beim Installieren der Abhaengigkeiten.
    pause
    exit /b 1
)

if exist build rmdir /s /q build
if exist dist rmdir /s /q dist

call ".venv\Scripts\python.exe" -m PyInstaller --noconfirm --clean --onedir --name MY-PRIVATE-AI --add-data "frontend;frontend" windows_launcher.py
if errorlevel 1 (
    echo Fehler beim Erstellen der EXE.
    pause
    exit /b 1
)

echo.
echo Fertig: dist\MY-PRIVATE-AI\MY-PRIVATE-AI.exe
echo Zum Starten die EXE im dist-Ordner ausfuehren.
pause
