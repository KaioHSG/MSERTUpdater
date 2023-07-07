@echo off
title Microsoft Safety Scanner Updater
if not exist "C:\Temp\Microsoft Safety Scanner" (mkdir "C:\Temp\Microsoft Safety Scanner")
bitsadmin /transfer "Update Microsoft Safety Scanner" /priority foreground "https://go.microsoft.com/fwlink/?LinkId=212732" "C:\Temp\Microsoft Safety Scanner\MSERT.exe"
start "" "C:\Temp\Microsoft Safety Scanner\MSERT.exe"
