@echo off
setlocal
set "GRADLE_VERSION=8.14.3"
set "ROOT=%~dp0"
set "CACHE=%ROOT%.gradle-dist"
set "GRADLE_HOME_LOCAL=%CACHE%\gradle-%GRADLE_VERSION%"
set "ZIP=%CACHE%\gradle-%GRADLE_VERSION%-bin.zip"

if not exist "%GRADLE_HOME_LOCAL%\bin\gradle.bat" (
  echo [semillero-cicd] Descargando Gradle %GRADLE_VERSION% por primera vez...
  if not exist "%CACHE%" mkdir "%CACHE%"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-bin.zip' -OutFile $env:ZIP; Expand-Archive -Path $env:ZIP -DestinationPath $env:CACHE -Force; Remove-Item $env:ZIP -Force"
  if errorlevel 1 exit /b 1
)

call "%GRADLE_HOME_LOCAL%\bin\gradle.bat" %*
