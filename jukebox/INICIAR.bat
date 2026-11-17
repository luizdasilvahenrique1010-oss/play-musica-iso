@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0atualizar.ps1" >nul 2>&1
set "URL=%~dp0index.html"
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" goto c1
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" goto c2
if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" goto c3
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" goto e1
goto padrao
:c1
start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" --start-fullscreen --autoplay-policy=no-user-gesture-required "%URL%"
goto fim
:c2
start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" --start-fullscreen --autoplay-policy=no-user-gesture-required "%URL%"
goto fim
:c3
start "" "%LocalAppData%\Google\Chrome\Application\chrome.exe" --start-fullscreen --autoplay-policy=no-user-gesture-required "%URL%"
goto fim
:e1
start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" --start-fullscreen --autoplay-policy=no-user-gesture-required "%URL%"
goto fim
:padrao
start "" "%URL%"
:fim
