# Pressure Test Drop Calculator - 2 Input Windows Version

Inputs:
1. Test Pressure (psi)
2. Test Duration (minutes)

The application interpolates seconds per psi (linear in 1/psi, since sec/psi = 120,000 / psi) from the reference pressure table.

Reference:
500 psi = 240 sec/psi
1,000 psi = 120 sec/psi
3,000 psi = 40 sec/psi
5,000 psi = 24 sec/psi
10,000 psi = 12 sec/psi
15,000 psi = 8 sec/psi

The allowable-drop percentage is calculated at 0.05% per minute, consistent with the supplied table:
3 min = 0.15%
5 min = 0.25%
10 min = 0.50%
15 min = 0.75%
60 min = 3.00%

Build:
dotnet publish -c Release -r win-x64 --self-contained true /p:PublishSingleFile=true

Install (Windows): double-click Install.bat. It installs the .NET 8 SDK if missing (via winget),
builds the app, installs it to %LocalAppData%\PressureTestCalculator and adds Desktop/Start menu shortcuts.
Run Uninstall.bat to remove it.

Cloud build (no install needed): put these files in a GitHub repository (the .github folder must be at the repo root).
Go to Actions > "Build Windows EXE" > Run workflow. When it finishes, download PressureTestCalculator-win-x64
from the run's Artifacts. Unzip it to get PressureTestCalculator.exe (double-click to run, no .NET needed).
