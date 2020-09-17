@echo off
rem Backup myflies using xcopy for incremental backup only

rem How to use: xcopy/?
rem xcopy <Source> [<Destination>] 
rem /y	Suppresses prompting to confirm that you want to overwrite an existing destination file.
rem /q	Suppresses the display of xcopy messages. not display file names.
rem /s	Copies directories and subdirectories, unless they are empty. If you omit /s, xcopy works within a single directory.
rem /d  Copies source files changed on or after the specified date only. If you do not include a MM-DD-YYYY value, xcopy copies all Source files that are newer than existing Destination files. This command-line option allows you to update files that have changed.
rem /c Ignores errors.
rem /r	Copies read-only files.

echo "Start backup..."

xcopy D:\myfiles F:\backups\asuslaptop7\   /Y /S /D /C /R

echo "Finished backup"
@echo on