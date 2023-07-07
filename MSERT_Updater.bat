@echo off
title Microsoft Safety Scanner Updater
set MsertFolder=C:\Temp\Microsoft Safety Scanner
set MsertServer=https://go.microsoft.com/fwlink/?LinkId=212732
set MsertServerTest=go.microsoft.com
tasklist /nh /fi "imagename eq MSERT.exe" | findstr /l /i "MSERT.exe" > nul
if %ErrorLevel% equ 0 (
   echo Microsoft Safety Scanner Updater is running. Exiting...
   timeout /t 5 > nul
   exit
) else (
   goto :ServerTest
)

:ServerTest
ping /n 1 %MsertServerTest% > nul
if %ErrorLevel% equ 0 (
   if not exist "%MsertFolder%" (
      mkdir "%MsertFolder%"
   )
   echo Updating Microsoft Safety Scanner...
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
