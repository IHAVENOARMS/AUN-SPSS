@REM ************************************************************************
@REM Licensed Materials - Property of IBM 
@REM
@REM IBM SPSS Products: Statistics Common
@REM
@REM (C) Copyright IBM Corp. 1989, 2016
@REM
@REM US Government Users Restricted Rights - Use, duplication or disclosure
@REM restricted by GSA ADP Schedule Contract with IBM Corp. 
@REM ************************************************************************

@SETLOCAL & SET RET=

@ECHO OFF

@REM the installation directory
SET INSTALLDIR=%~sdp0

@REM set the PATH to include the common directory
SET COMMONDIR=%INSTALLDIR%common\
SET PATH=%COMMONDIR%ext\bin\spss.common\;%COMMONDIR%thirdparty\;%PATH%

@REM set the PATH to include the installation directory
SET PATH=%INSTALLDIR%;%PATH%

@REM set the Analytic Server version
SET AEVERSION=2.1.0.1

PUSHD %INSTALLDIR%

%INSTALLDIR%JRE\bin\java.exe -ea -Dsun.java2d.d3d=false -Xshareclasses:name=statistics_%u -Xshareclasses:nonfatal -Xscmx32M -Xdisableexplicitgc -Xms32M -Xmx768M -Dcom.sun.media.jai.disableMediaLib=true -Dswing.aatext=false -Djava.library.path=%INSTALLDIR%;%INSTALLDIR%JRE\bin -Dapplication.home=%INSTALLDIR% -Dcom.ibm.jsse2.disableSSLv3=false -Djava.security.properties=%INSTALLDIR%\java.security -Dstatistics.home=%INSTALLDIR% -Dstd_deployment.home=%INSTALLDIR% -DsaveXml=true -classpath "%INSTALLDIR%*;%INSTALLDIR%common\ext\lib\spss.common\*;%INSTALLDIR%as-%AEVERSION%\lib\*;%INSTALLDIR%as-%AEVERSION%\3rdparty\*;%INSTALLDIR%as-%AEVERSION%\af\components\OutputComponent\*" com.spss.java_client.core.common.Driver %*

:end

@POPD & ENDLOCAL & SET RET=%RET%
