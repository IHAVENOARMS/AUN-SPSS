@REM /***********************************************************************
@REM * Licensed Materials - Property of IBM 
@REM *
@REM * IBM SPSS Products: Statistics Common
@REM *
@REM * (C) Copyright IBM Corp. 1989, 2019
@REM *
@REM * US Government Users Restricted Rights - Use, duplication or disclosure
@REM * restricted by GSA ADP Schedule Contract with IBM Corp. 
@REM ************************************************************************/

@setlocal & @pushd & set /a RET=0

@echo off

rem the installation directory with a trailing backslash
set INSTALLDIR=%~sdp0

rem This command
set THIS=%~n0

rem Set the service base name
set SERVICENAME=IBM SPSS Statistics Server 26.0

rem Set the group name
if "%1" equ "" echo Group name not defined. & goto :usage
set GROUP=%1
shift

rem Set the port
if "%1" equ "" echo Server port number not defined. & goto :usage
set /a PORT=%1
shift

rem Ignore extra parameters
if "%1" neq "" echo Extra parameters are ignored: %*

rem Check for the new configuration folder
if exist %INSTALLDIR%config_%GROUP% echo Configuration folder for group '%GROUP%' already exists: & echo %INSTALLDIR%config_%GROUP% & set /a RET=1 & goto :end

rem Copy the configuration files from the executable folder
robocopy %INSTALLDIR% %INSTALLDIR%config_%GROUP% sort-options.master statisticsd.master UserSettings.master /a-:r /np /njh /njs /nfl /ndl /r:3 /w:3 /tbd
if %ERRORLEVEL% gtr 8 ( set /a RET=1 ) else ( set /a RET=0 )
robocopy %INSTALLDIR% %INSTALLDIR%config_%GROUP% statisticsuser.master /np /njh /njs /nfl /ndl /r:3 /w:3 /tbd
if %ERRORLEVEL% gtr 8 ( set /a RET=1 ) else ( set /a RET=0 )
pushd %INSTALLDIR%config_%GROUP%
ren sort-options.master sort-options.conf
ren statisticsd.master statisticsd.conf
ren UserSettings.master UserSettings.xml
ren statisticsuser.master statisticsuser.bat
popd
if %ERRORLEVEL% neq 0 ( set /a RET=1 ) else ( set /a RET=0 )

if %RET% neq 0 goto :end

@pushd config_%GROUP%

rem Edit configuration files
where /q powershell
if %ERRORLEVEL% neq 0 echo Edit by hand the configuration files in: & echo %INSTALLDIR%config_%GROUP% & goto :service

rem Edit 
call :edit-file sort-options.conf
if %RET% neq 0 popd & echo Edit of 'sort-options.conf' failed. & goto :end
call :edit-file statisticsd.conf
if %RET% neq 0 popd & echo Edit of 'statisticsd.conf' failed. & goto :end
call :edit-file UserSettings.xml
if %RET% neq 0 popd & echo Edit of 'UserSettings.xml' failed. & goto :end

popd

:service
rem Create, describe and start the service
sc create "%SERVICENAME% %GROUP%" binPath= "%INSTALLDIR%statisticssrvr.exe" > nul 2>&1
if %ERRORLEVEL% neq 0 set /a RET=1 & echo Creating the service '%SERVICENAME% %GROUP%' failed. & goto :end
sc description "%SERVICENAME% %GROUP%" "%SERVICENAME% for group %GROUP% Service" > nul 2>&1
if %ERRORLEVEL% neq 0 set /a RET=1 & echo Describing the service '%SERVICENAME% %GROUP%' failed. & goto :end
REM sc start "%SERVICENAME% %GROUP%" > nul 2>&1
REM if %ERRORLEVEL% neq 0 set /a RET=1 & echo Starting the service '%SERVICENAME% %GROUP%' failed. & goto :end

echo The folder 'config_%GROUP%' has been created
echo and is configured for port %PORT%.
echo The service '%SERVICENAME% %GROUP%' & echo has been created, but has not been started.
goto :end

rem Edit file subroutine
:edit-file
set NAME=%~n1
set EXT=%~x1
powershell -command "get-content %NAME%%EXT% | %%{$_ -replace \"config\\\\\",\"config_%GROUP%\\\" -replace \"3026\",\"%PORT%\"} | set-content %NAME%.tmp"
if %ERRORLEVEL% neq 0 set /a RET=1 & goto :eof
powershell -command "remove-item %NAME%%EXT%"
if %ERRORLEVEL% neq 0 set /a RET=1 & goto :eof
powershell -command "rename-item %NAME%.tmp %NAME%%EXT%"
if %ERRORLEVEL% neq 0 set /a RET=1 & goto :eof
goto :eof

:usage
set /a RET=1
echo.
echo Usage: %THIS% ^<groupname^> ^<port number^>
echo  ^<groupname^>    unique group name, cannot contain whitespace
echo  ^<port number^>  unique port number for Server communication
goto :end

:end

if %RET% neq 0 echo. & echo %THIS% failed.

popd & endlocal & set RET=%RET%
