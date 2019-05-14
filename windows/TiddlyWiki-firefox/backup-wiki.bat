@echo off
rem This script is used to backup the TiddlyWiki where the browser plugin cannot be installed.
rem When creating a new tiddler using the new tiddler  button in the sidebar. Type some content for the tiddler, and click the  ok button
rem Save changes by clicking the  save changes button in the sidebar
rem The browser will download a new copy of the wiki incorporating your changes

set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%

COPY C:\mynotes\tech-notes.html C:\mynotes\backups\tech-notes-%CUR_YYYY%%CUR_MM%%CUR_DD%.html 

COPY /Y /A /D /Z C:\Users\weiping\Downloads\tech-notes.html C:\mynotes\tech-notes.html 

DEL C:\Users\weiping\Downloads\tech-notes.html
@echo on
