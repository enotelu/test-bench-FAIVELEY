@ECHO OFF

TITLE Configuration AdresseIP FAIVELEY

:: ------------o
:: Version 1
:: Permet de modifié l'adressage IP du PC afin de se connecter au XEBRA
ECHO.  
ECHO Choix de l'adressage IP :
ECHO.
ECHO.
ECHO 1) XEBRA1
ECHO.
ECHO 2) XEBRA3
ECHO.
ECHO 3) Camera IP
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


:xebra1
ECHO Attendre...
netsh interface ip set address "Connexion au r�seau local" static 10.0.0.2 255.252.0.0 10.0.255.253 1  
netsh interface ip set address "Connexion r�seau sans fil" static 10.0.0.3 255.252.0.0 10.0.255.253 1  
goto eof

:xebra3
ECHO Attendre...
netsh interface ip set address "Connexion au r�seau local" static 192.168.0.100 255.255.255.0  192.168.0.100 1
netsh interface ip set address "Connexion r�seau sans fil" dhcp  
goto eof

:camip
ECHO Attendre...
netsh interface ip set address "Connexion au r�seau local" static 192.168.1.100 255.255.255.0  192.168.1.100 1
netsh interface ip set address "Connexion r�seau sans fil" dhcp  
goto eof

:exit
ECHO Attendre...
goto eof   
   
:eof