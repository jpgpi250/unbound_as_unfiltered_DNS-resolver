@echo off
echo Admin permissions required. Detecting permissions...

NET SESSION >nul 2>&1
IF %ERRORLEVEL% == 0 (
	echo.
  echo Success: Admin permissions confirmed.
  goto admin
) ELSE (
	echo.
	echo ################ ERROR: ADMINISTRATOR PRIVILEGES REQUIRED ################
	echo Failure: Current permissions inadequate.
	echo This script needs to be run as admin. -- Right click - Run as Admin --
	echo ##########################################################################
	echo.
	pause
	goto end
)

:admin
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1

netsh interface ipv4 show dnsserver "Ethernet" | %windir%\system32\find.exe "DHCP"
if errorlevel 1 goto setDHCP

setlocal enableextensions enabledelayedexpansion

SET /A INDEX=1
set DNSopen=192.168.2.47
netsh interface ipv4 add dnsserver "Ethernet" address=%DNSopen% index=%INDEX%

endlocal

netsh interface ipv4 show dnsserver "Ethernet"
ipconfig /flushdns

timeout /T 10 /NOBREAK

:setDHCP
netsh interface ipv4 set dnsserver "Ethernet" "dhcp"
netsh interface ipv4 show dnsserver "Ethernet"
ipconfig /flushdns
goto done

:done
exit
:end

