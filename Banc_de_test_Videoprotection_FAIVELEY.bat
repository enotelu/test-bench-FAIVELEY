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
rem change l'interface IP permettant de se connecter au XEBRA
netsh interface ip set address "Connexion au r‚seau local" static 10.0.0.2 255.252.0.0 10.0.255.253 1  
netsh interface ip set address "Connexion r‚seau sans fil" static 10.0.0.3 255.252.0.0 10.0.255.253 1  

rem ouvre XTrack puis le referme (bug commande arp -a)
cd C:\Programmes Files (x86)\Faiveley
start /min xtrack.exe
ping 127.0.0.1 -n 4 >nul
taskkill /im xtrack.exe
cd C:\

rem execute la commande arp -a
set "script=%temp%\sendkeys.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%script%"
echo WScript.Sleep 1000 >> "%script%"
echo WshShell.SendKeys "arp -a {ENTER}" >> "%script%"
echo Set WshShell = Nothing >> "%script%"
cscript //nologo "%script%"
del "%script%"

rem Cette boucle for parcourt la sortie de la commande arp -a.
rem La commande arp -a affiche la liste des adresses IP et des cartes réseau associées à un ordinateur.
rem La boucle for extrait l'adresse IP de chaque carte réseau et la stocke dans la variable ip.
rem Si l'adresse IP commence par 10.0, la boucle stocke l'adresse IP de la carte réseau dans la variable DeviceIP.
rem La variable DeviceIP contient l'adresse IP de la carte réseau par défaut.
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

rem Ouvre Firefox
start firefox -new-tab "about:blank"
rem lance un ping et attend 4s (laisse le temps a Firefox de s'ouvrir)
ping 127.0.0.1 -n 4 >nul

rem on vient copier l'IP trouvee precedement
echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.AppActivate ("Mozilla Firefox") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("%DeviceIP%") >> tmp.vbs
echo WshShell.SendKeys ("{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

rem lance un ping et attend 6s (permet aux pages de charger)
ping 127.0.0.1 -n 6 >nul

rem on se deplace sur la page web afin d'inscrire le MDP
echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.AppActivate ("Mozilla Firefox") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

rem on rempli les champs pour le MDP
echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.SendKeys ("xebra") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

rem ouvre XTrack
ping 127.0.0.1 -n 4 >nul
cd C:\Programmes Files (x86)\Faiveley
start /min xtrack.exe
ping 127.0.0.1 -n 4 >nul

goto eof
rem ------------o


rem COMMANDE XEBRA3
rem ------------o
:xebra3
ECHO Attendre...
rem change l'interface IP permettant de se connecter au XEBRA
netsh interface ip set address "Connexion au r‚seau local" static 192.168.0.100 255.255.255.0  192.168.0.100 1
netsh interface ip set address "Connexion r‚seau sans fil" dhcp  

rem ouvre Firefox et on ecrit l'IP 192.168.0.1 (adresse IP du XEBRA3)
start firefox -new-tab "about:blank"
rem lance un ping et attend 4s (laisse le temps a Firefox de s'ouvrir)
ping 127.0.0.1 -n 4 >nul

rem Cette ligne crée une nouvelle instance de l'objet WScript.Shell.
echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
rem Cette ligne active l'application Mozilla Firefox.
echo WshShell.AppActivate ("Mozilla Firefox") >> tmp.vbs
rem Cette ligne envoie la touche TAB deux fois à l'application Mozilla Firefox.
echo WshShell.SendKeys ("{TAB}{TAB}") >> tmp.vbs
rem Cette ligne envoie l'adresse IP 192.168.0.1 à l'application Mozilla Firefox.
echo WshShell.SendKeys ("192.168.0.1") >> tmp.vbs
rem Cette ligne envoie la touche Entrée à l'application Mozilla Firefox.
echo WshShell.SendKeys ("{ENTER}") >> tmp.vbs
rem Cette ligne exécute le fichier tmp.vbs, qui contient le code des lignes précédentes.
cscript tmp.vbs
rem Cette ligne supprime le fichier tmp.vbs.
del tmp.vbs

rem lance un ping et attend 2s (permet aux pages de charger)
ping 127.0.0.1 -n 2 >nul

rem on se deplace sur la page web afin d'inscrire le MDP
echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.SendKeys ("{TAB}{ENTER}") >> tmp.vbs
cscript tmp.vbs
del tmp.vbs

rem on ecrit le MDP pour le XEBRA3
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

rem ouvre XTrack
ping 127.0.0.1 -n 4 >nul
cd C:\Programmes Files (x86)\Faiveley
start /min xtrack.exe
ping 127.0.0.1 -n 4 >nul

goto eof
rem ------------o


rem COMMANDE Configuration Cam IP
rem ------------o
:camip
ECHO Attendre...
netsh interface ip set address "Connexion au r‚seau local" static 192.168.1.100 255.255.255.0  192.168.1.100 1
netsh interface ip set address "Connexion r‚seau sans fil" dhcp  

rem ouvre Firefox et on ecrit l'IP 192.168.1.108
rem l'IP permet de se connecté sur les cameras sortant d'usine ou revenant de SAV
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
rem ------------o


rem ------------o
:exit
ECHO Attendre...
goto eof   
rem ------------o
   
:eof
