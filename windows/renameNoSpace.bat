:renameNoSpace  [/R]  [FolderPath]
@echo off
setlocal disableDelayedExpansion
if /i "%~1"=="/R" (
  set "forOption=%~1 %2"
  set "inPath="
) else (
  set "forOption="
  if "%~1" neq "" (set "inPath=%~1\") else set "inPath="
)
for %forOption% %%F in ("%inPath%* *") do (
  if /i "%~f0" neq "%%~fF" (
    set "folder=%%~dpF"
    set "file=%%~nxF"
    setlocal enableDelayedExpansion
    echo ren "!folder!!file!" "!file: =!"
    ren "!folder!!file!" "!file: =!"
    endlocal
  )
)

REM usage:
REM renameNoSpace		: (no arguments) Renames files in the current directory
REM renameNoSpace /R 		: Renames files in the folder tree rooted at the current directory
REM renameNoSpace myFolder 	: Renames files in the "myFolder" directory found in the current directory.
REM renameNoSpace "c:\my dir\"	: Renames files in the specified path. Quotes are used because path contains a space.
REM renameNoSpace /R c:\ 	: Renames all files on the C: drive.
