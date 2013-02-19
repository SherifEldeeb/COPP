::	COPP - `COFEE` of Poor People
::	v0.001 - 18/02/2013
::	By Sherif Eldeeb - http://eldeeb.net
::	====================================
::	_WIKIPEDIA_
::	"...Computer Online Forensic Evidence Extractor (COFEE) is a tool kit, developed by Microsoft, to help computer forensic investigators extract evidence from a Windows computer. Installed on a USB flash drive or other external disk drive, it acts as an automated forensic tool during a live analysis. Microsoft provides COFEE devices and online technical support free to law enforcement agencies.
::	====================================
::	- A Dos batch script to gather simple information from potentially compromised machine, it's just like a crippled COFEE.
::	- It will create a folder with the name of computer with date & time stamp, then iterate through a list of commands and redirecting the output to a text file.
::	- Gathered data includes running processes, loaded modules, autostart entries ... etc.
::
::	- I needed to do this on a couple of machines, so, instead of running same commands on different machines over and over again, I wrote this simple script.
::	- Will add to it whenever I have time :)


::	Script start...
::	@echo off
::	Change Directory to the script's one, since Stupid windows will execute at "\windows\system32" when chosen to run as administrator...
cd /d "%~d0%~p0"

::Get Date and Time
For /F "tokens=1,2,3,4 delims=/ " %%A in ('Date /t') do @( 
Set FullDate="%%D-%%C-%%B"
)

For /F "tokens=1,2,3 delims=: " %%A in ('time /t') do @( 
Set FullTime="%%A-%%B"
)

set dirname="%computername%_%FullDate%_%FullTime%"
mkdir "%dirname%"
cd "%dirname%"
set var=%computername%.txt

type ..\commands.txt >> %var%

for /f "tokens=*" %%a in (..\commands.txt) do @(
echo. >> %var%
echo. >> %var%
echo ======================================== >> %var%
echo ======================================== >> %var%
echo %%a >> %var%
echo ======================================== >> %var%
echo ======================================== >> %var%
cmd /c "%%a" >> %var%
)
cd ..
cd _Tools
autorunsc.exe -a -f -c >> ..\%dirname%\autoruns.csv
handle.exe -a -u >> ..\%dirname%\handles.txt
HiJackThis.EXE /silentautolog
move hijackthis.log ..\%dirname%\
listdlls.exe >> ..\%dirname%\dlls.txt
psinfo -s -h -d >> ..\%dirname%\psinfo.txt
pslist -t >> ..\%dirname%\pslist.txt
psgetsid >> ..\%dirname%\psgetsid.txt
psloggedon.exe >> ..\%dirname%\psloggedon.txt
Tcpvcon.exe -a -c -n >> ..\%dirname%\tcpvcon.txt
