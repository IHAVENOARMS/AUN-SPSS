@REM ************************************************************************
@REM Licensed Materials - Property of IBM 
@REM
@REM IBM SPSS Products: Statistics Common
@REM
@REM (C) Copyright IBM Corp. 1989, 2015
@REM
@REM US Government Users Restricted Rights - Use, duplication or disclosure
@REM restricted by GSA ADP Schedule Contract with IBM Corp. 
@REM ************************************************************************
@SETLOCAL & PUSHD & SET RET=
@set SPSS_HOME=%~sdp0
@call "%SPSS_HOME%\pythonenv.bat" 3 %1
@POPD & ENDLOCAL & SET RET=%RET%
