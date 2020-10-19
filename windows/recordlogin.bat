@echo off
rem record usage
rem https://stackoverflow.com/questions/5664761/how-to-count-no-of-lines-in-text-file-and-store-the-value-into-a-variable-using

for /F "tokens=1" %%i in ('date /t') do set mydate=%%i
echo/|set /p =%mydate%	%TIME%	%USERNAME% >> "C:\tmp\usage.log"
echo. >> "C:\tmp\usage.log"

setlocal EnableDelayedExpansion
set "cmd=findstr %mydate% C:\tmp\usage.log | find /c ":""
for /F %%a in ('!cmd!') do set number=%%a 
rem echo %number%

msg %username% "Login %number% times. Do NOT spend too much time on computer!"

IF %number%==1 ECHO start shutdown /s /t 7260
IF %number%==2 ECHO start shutdown /s /t 3660
IF %number%==3 ECHO start shutdown /s /t 600
IF %number%==4 ECHO start shutdown /s /t 300

@echo on
