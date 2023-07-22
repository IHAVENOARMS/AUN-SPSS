@REM /***********************************************************************
@REM * Licensed Materials - Property of IBM 
@REM *
@REM * IBM SPSS Products: Statistics Common
@REM *
@REM * (C) Copyright IBM Corp. 1989, 2014
@REM *
@REM * US Government Users Restricted Rights - Use, duplication or disclosure
@REM * restricted by GSA ADP Schedule Contract with IBM Corp. 
@REM ************************************************************************/

@setlocal & @pushd & set /a RET=0

@echo off

set PATH=%PATH%;..
..\statisticsuser.exe %*

popd & endlocal & set RET=%RET%
