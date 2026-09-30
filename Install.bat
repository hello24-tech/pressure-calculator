@echo off
setlocal
cd /d "%~dp0"
title Pressure Test Calculator - Installer
echo Installing Pressure Test Drop Calculator...
echo.

set "DOTNET=dotnet"
where dotnet >nul 2>nul
if errorlevel 1 (
  if exist "%ProgramFiles%\dotnet\dotnet.exe" (
    set "DOTNET=%ProgramFiles%\dotnet\dotnet.exe"
  ) else (
    echo .NET 8 SDK not found. Installing it with winget...
    winget install --id Microsoft.DotNet.SDK.8 -e --accept-package-agreements --accept-source-agreements
    if exist "%ProgramFiles%\dotnet\dotnet.exe" (
      set "DOTNET=%ProgramFiles%\dotnet\dotnet.exe"
    ) else (
      echo.
      echo Could not install .NET automatically.
      echo Install the .NET 8 SDK from https://dotnet.microsoft.com/download/dotnet/8.0
      echo then run Install.bat again.
      pause
      exit /b 1
    )
  )
)

set "APPDIR=%LocalAppData%\PressureTestCalculator"
echo Building...
"%DOTNET%" publish -c Release -r win-x64 --self-contained true /p:PublishSingleFile=true -o "%APPDIR%"
if errorlevel 1 (
  echo.
  echo Build failed. See messages above.
  pause
  exit /b 1
)

echo Creating shortcuts...
powershell -NoProfile -Command "$w=New-Object -ComObject WScript.Shell; foreach($p in @([Environment]::GetFolderPath('Desktop'),[Environment]::GetFolderPath('Programs'))){ $s=$w.CreateShortcut((Join-Path $p 'Pressure Test Calculator.lnk')); $s.TargetPath='%APPDIR%\PressureTestCalculator.exe'; $s.WorkingDirectory='%APPDIR%'; $s.Save() }"

echo.
echo Done. Use the "Pressure Test Calculator" shortcut on your Desktop or Start menu.
start "" "%APPDIR%\PressureTestCalculator.exe"
pause
