@echo off
rem backup TiddlyWiki html notebooks when your browser does not support save
rem click save to download it at default location C:\Users\weiping\Downloads
set mydate1=%date:/=%
set mydate2=%mydate1: =%

set mytime1=%time:~0,5%
set mytime2=%mytime1::=%
rem echo filename_%mydate2%_%mytime2%.html

copy C:\weiping\mynotes\tech_notes.html C:\weiping\mynotes\backup\tech_notes_%mydate2%_%mytime2%.html 

copy /Y /A /D /Z C:\Users\weiping\Downloads\tech_notes.html C:\weiping\mynotes\tech_notes.html

del C:\Users\weiping\Downloads\tech_notes.html

@echo on
