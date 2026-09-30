@echo off
del "%USERPROFILE%\Desktop\Pressure Test Calculator.lnk" 2>nul
del "%AppData%\Microsoft\Windows\Start Menu\Programs\Pressure Test Calculator.lnk" 2>nul
rmdir /s /q "%LocalAppData%\PressureTestCalculator"
echo Uninstalled.
pause
