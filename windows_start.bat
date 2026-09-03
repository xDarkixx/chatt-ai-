@echo off
setlocal
cd /d "%~dp0"

if not exist ".venv\Scripts\python.exe" (
    echo Python-Umgebung wird eingerichtet...
    py -3 -m venv .venv || goto :error
)

call ".venv\Scripts\python.exe" -m pip install -r requirements.txt || goto :error

start "MY-PRIVATE-AI" http://127.0.0.1:8000
".venv\Scripts\python.exe" windows_launcher.py
exit /b 0

:error
echo.
echo Start fehlgeschlagen. Bitte Python 3 installieren und erneut versuchen.
pause
exit /b 1
