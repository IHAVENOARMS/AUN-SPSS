
@REM VERSION_INFO is a product version type for OnPrem, Subscription, NewUI, will insert into media.bat process
@REM ************************************************************************
@REM Licensed Materials - Property of IBM 
@REM
@REM IBM SPSS Products: Statistics Common
@REM
@REM (C) Copyright IBM Corp. 1989, 2019
@REM
@REM US Government Users Restricted Rights - Use, duplication or disclosure
@REM restricted by GSA ADP Schedule Contract with IBM Corp. 
@REM ************************************************************************

@set SPSS_HOME=%~sdp0
@set PATH=%SPSS_HOME%\JRE\bin;%PATH%
@echo off
@if "%1" equ "2" goto python2
@if "%1" equ "3" goto python3

:python2
@set FOLDER_NAME=Python
@set PARAMETER_VALUE=showpython
@goto setenv

:python3
@set FOLDER_NAME=Python3
@set PARAMETER_VALUE=showpython3
@goto setenv

:setenv
@for /f "tokens=* delims=" %%i in ('java %VERSION_INFO% -jar "%SPSS_HOME%\"pythoncfg.jar %PARAMETER_VALUE%') do set PYTHON_HOME=%%i
@set PYTHONPATH=%SPSS_HOME%\%FOLDER_NAME%\Lib\site-packages;%PYTHONPATH%
@set PATH="%PYTHON_HOME%";%PATH%
@echo on

@if "%2" equ "/i" goto idle
@if "%2" equ "/m" goto moduledocs
@if "%2" equ "/o" goto onlinedocs
@if "%2" equ "/e" goto end

@goto usage

:idle
@start pythonw.exe "%PYTHON_HOME%\Lib\idlelib\idle.pyw"
@goto end

:moduledocs
@start pythonw.exe "%PYTHON_HOME%\Tools\Scripts\pydocgui.pyw"
@goto end

:onlinedocs
@start python.exe "%PYTHON_HOME%\Tools\Scripts\pydoc3.py" -b
@goto end


:usage
@ECHO Run Python IDLE and Python doc.
@ECHO.
@ECHO Usage: statisticspythonw.bat [ ^/i ^/m ]
@ECHO.
@ECHO where options include
@ECHO   /i	Run Python IDLE
@ECHO   /m	Run Python doc
@ECHO   /o  Run Python 3 Docs server
@ECHO.
@GOTO end

:end
