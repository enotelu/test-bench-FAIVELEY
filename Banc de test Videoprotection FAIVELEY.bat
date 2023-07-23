@ECHO OFF

TITLE Banc de test Videoprotection FAIVELEY

ECHO.  
ECHO Choix de l'adressage IP :
ECHO.
ECHO.
ECHO 1) XEBRA1
ECHO.
ECHO 2) XEBRA3 / Camera IP PARAMETREE
ECHO.
ECHO 3) Camera IP USINE
ECHO.
ECHO 4) EXIT
ECHO.
ECHO (Choisir puis appuyez sur ENTREE)
ECHO.

set /p optionMenu="Choix : "
if "%optionMenu%"=="1" goto xebra1
if "%optionMenu%"=="2" goto xebra3
if "%optionMenu%"=="3" goto camip
if "%optionMenu%"=="4" goto exit

rem COMMANDE XEBRA1
rem ------------o
:xebra1
ECHO Attendre...
netsh interface ip set address "Connexion au r�seau local" static 10.0.0.2 255.252.0.0 10.0.255.253 1  
netsh interface ip set address "Connexion r�seau sans fil" static 10.0.0.3 255.252.0.0 10.0.255.253 1  

rem Recuperation de l'adresse IP du xebra1 avec la commande arp
rem ------------o
set "script=%temp%\sendkeys.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%script%"
echo WScript.Sleep 1000 >> "%script%"
echo WshShell.SendKeys "arp -a {ENTER}" >> "%script%"
echo Set WshShell = Nothing >> "%script%"
cscript //nologo "%script%"
del "%script%"

rem Recherche d'une IP comman�ant par 10.0 (permet de ne pas confondre avec 192.168.)
rem ------------o
for /f "delims= " %%i in ('arp -a') do (
    if not "%%i"=="(Interface)" (
        setlocal enabledelayedexpansion
        set ip=%%i
        if "!ip:~0,4!"=="10.0" (
            endlocal
            set DeviceIP=%%i
            goto :continue
        )
        endlocal
    )
)

:continue

rem Ouvre Firefox et on copie l'IP trouve precedement
rem ------------o
start firefox -new-tab "about:blank"

ping 127.0.0.1 -n 4 >nul

echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.AppActivate ("Mozilla Firefox") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("%DeviceIP%") >> tmp.vbs
echo WshShell.SendKeys ("{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

rem Attend que la page charge puis on vient ecrire le MDP
rem ------------o
ping 127.0.0.1 -n 6 >nul

echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.AppActivate ("Mozilla Firefox") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.SendKeys ("xebra") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

goto eof


rem COMMANDE XEBRA3
rem ------------o
:xebra3
ECHO Attendre...
netsh interface ip set address "Connexion au r�seau local" static 192.168.0.100 255.255.255.0  192.168.0.100 1
netsh interface ip set address "Connexion r�seau sans fil" dhcp  

rem ouvre Firefox et on ecrit l'IP 192.168.0.1
rem ------------o
start firefox -new-tab "about:blank"

ping 127.0.0.1 -n 4 >nul

echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.AppActivate ("Mozilla Firefox") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("192.168.0.1") >> tmp.vbs
echo WshShell.SendKeys ("{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

ping 127.0.0.1 -n 2 >nul

echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.SendKeys ("{TAB}{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

rem on ecrit le MDP pour le XEBRA3
rem ------------o
echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.SendKeys ("{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("maint") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("xebra3") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}{ENTER}") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

ping 127.0.0.1 -n 2 >nul
echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.SendKeys ("{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

goto eof

:camip
ECHO Attendre...
netsh interface ip set address "Connexion au r�seau local" static 192.168.1.100 255.255.255.0  192.168.1.100 1
netsh interface ip set address "Connexion r�seau sans fil" dhcp  

rem ouvre Firefox et on ecrit l'IP 192.168.1.108
rem ------------o
start firefox -new-tab "about:blank"

ping 127.0.0.1 -n 4 >nul

echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.AppActivate ("Mozilla Firefox") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("192.168.1.108") >> tmp.vbs
echo WshShell.SendKeys ("{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

goto eof

:exit
ECHO Attendre...
goto eof   
   
:eof