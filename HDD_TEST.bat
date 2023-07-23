@echo off

set "appPath=C:\Documents and Settings\Administrateur\Bureau\HDDLLF.4.25.exe"
set "serialNumber=52353257564c4339202020202020202020202"
set "modelNumer=ST380815AS"

if not exist "%appPath%" (
	echo Le fichier HDDLLF4.25.exe est introuvable.
	pause
	exit /b
)

:: Partie à tester
:: ------------o

echo Vérification du nombre de disques durs connectés...

for /f "delims=" %%i in ('wmic diskdrive get caption') do (
	echo %%i
)

set "nbDisks=0"

for /f "delims=" %%i in ('wmic diskdrive get caption') do (
	set "nbDisks=!nbDisks! + 1"
)

echo Il y a !nbDisks! disques durs connectés.

if !nbDisks! equ 1 (
	echo Il n'y a qu'un disque dur connecté.
	pause
	exit /b
)

:: ------------o

start "" "%appPath%"

timeout /t 5 >nul

set "script=%temp%\sendkeys.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%script%"
echo WScript.Sleep 1000 >> "%script%"
echo WshShell.SendKeys "{DOWN}{DOWN}{ENTER}" >> "%script%"
echo Set WshShell = Nothing >> "%script%"

cscript //nologo "%script%"

del "%script%"


echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%script%"
echo WScript.Sleep 1000 >> "%script%"
echo WshShell.SendKeys "{ENTER}" >> "%script%"
echo Set WshShell = Nothing >> "%script%"

cscript //nologo "%script%"

del "%script%"

echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%script%"
echo WScript.Sleep 1000 >> "%script%"
echo WshShell.SendKeys "{RIGHT}{ENTER}{ENTER}" >> "%script%"
echo Set WshShell = Nothing >> "%script%"

cscript //nologo "%script%"

del "%script%"

exit /b