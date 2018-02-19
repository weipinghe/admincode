@echo off
rem record usage
echo/|set /p =%date%_%TIME%_%USERNAME% >> "C:\tmp\usage.log"
echo. >> "C:\tmp\usage.log"
start calc
