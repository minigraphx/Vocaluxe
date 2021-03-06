@echo off
SET version=v0.3.0
SET status=Beta
SET buildnum=0081
SET buildname=Vocaluxe %version% %status% (%buildnum%).rar

REM compile x64
call "%VS110COMNTOOLS%\..\..\VC\vcvarsall.bat" x64
devenv.com ..\Vocaluxe.sln /Rebuild "ReleaseWin|x64"
 
REM remove old x64 executables if found and rename
if exist "..\Output\Vocaluxe_x64.exe" del "..\Output\Vocaluxe_x64.exe"
ren "..\Output\Vocaluxe.exe" "Vocaluxe_x64.exe"
 
REM compile x86
call "%VS110COMNTOOLS%\..\..\VC\vcvarsall.bat" x86
devenv.com ..\Vocaluxe.sln /Rebuild "ReleaseWin|x86"
 
REM package
rar a -r -ep1 -x..\Output\CoverDB.sqlite -x..\Output\HighscoreDB.sqlite -x..\Output\*.log -x..\Output\*.pdb -x..\Output\Config.xml -x..\Output\Vocaluxe.vshost* -x..\Output\Songs -x..\Output\Screenshots -x..\Output\Playlists "%buildname%" "..\Output\*"