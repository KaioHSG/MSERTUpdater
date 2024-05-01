@echo off

set MsertFolder=C:\Temp\Microsoft Safety Scanner
set MsertServerTest=go.microsoft.com
set Msert64Server=https://go.microsoft.com/fwlink/?LinkId=212732
set Msert86Server=https://go.microsoft.com/fwlink/?LinkId=212733

title Microsoft Safety Scanner Updater
tasklist /nh /fi "imagename eq MSERT.exe" | findstr /l /i "MSERT.exe" > nul
if %ErrorLevel% equ 0 (
   echo Microsoft Safety Scanner is running. Exiting...
   timeout /t 5 > nul
   exit
)
wmic os get osarchitecture | findstr /l /c:"64" > nul
if %ErrorLevel% equ 0 (
   set MsertServer=%Msert64Server%
) else (
   set MsertServer=%Msert86Server%
)
ping /n 1 %MsertServerTest% > nul
if %ErrorLevel% equ 0 (
   if not exist "%MsertFolder%" (
      mkdir "%MsertFolder%"
   )
   bitsadmin /transfer "Update Microsoft Safety Scanner" /priority foreground "%MsertServer%" "%MsertFolder%\MSERT.exe"
) else (
   echo No server connection. Starting Microsoft Safety Scanner...
   timeout /t 3 > nul
)
if exist "%MsertFolder%\MSERT.exe" (
   start "" "%MsertFolder%\MSERT.exe"
   exit
) else (
   echo There is no "MSERT.exe" in "%MsertFolder%". Please check your internet connection and try again.
   pause > nul
   exit
)
