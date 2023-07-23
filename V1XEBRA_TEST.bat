@echo off



set "script=%temp%\sendkeys.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%script%"
echo WScript.Sleep 1000 >> "%script%"
echo WshShell.SendKeys "arp -a {ENTER}" >> "%script%"
echo Set WshShell = Nothing >> "%script%"

cscript //nologo "%script%"
del "%script%"


for /f "delims= " %%i in ('arp -a') do if not "%%i"=="(Interface)" (set DeviceIP=%%i)

start firefox -new-tab "about:blank"
ping 127.0.0.1 -n 6 >nul

echo Set WshShell = WScript.CreateObject("WScript.Shell") > tmp.vbs
echo WshShell.AppActivate ("Mozilla Firefox") >> tmp.vbs
echo WshShell.SendKeys ("{TAB}{TAB}") >> tmp.vbs
echo WshShell.SendKeys ("%DeviceIP%") >> tmp.vbs
echo WshShell.SendKeys ("{ENTER}") >> tmp.vbs

cscript tmp.vbs
del tmp.vbs


exit /b