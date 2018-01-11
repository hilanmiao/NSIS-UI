del ".\SetupScripts\app.7z"

rem Éú³Éapp.7z
7z.exe a ".\SetupScripts\app.7z" ".\FilesToInstall\*.*"

@set DestPath=%cd%\FilesToInstall\
@echo off& setlocal EnableDelayedExpansion

for /f "delims=" %%a in ('dir /ad/b %DestPath%') do (
7z.exe a ".\SetupScripts\app.7z" ".\FilesToInstall\%%a"
@echo "compressing .\FilesToInstall\%%a"
)