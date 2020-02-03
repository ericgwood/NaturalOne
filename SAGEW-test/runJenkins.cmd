@ECHO OFF
SETLOCAL

:: Natural Unit test launching script
:: The following environment variables will be used. If the environment variables are not set they will be set by this script.
:: eclipsehome -> Home directory for eclipse Example:c:\project files\Eclipse
:: java -> Absolute path the java.exe
:: eclipseworkspace -> Absolute path the the workspace to use within Eclipse
:: buildfile -> Ant build file to run

 
IF "%eclipsehome%"=="" (
 set eclipsehome=C:/SoftwareAGONE912/Designer/eclipse/
)
:: Find  Eclipse launcher based upon: http://wiki.eclipse.org/Starting_Eclipse_Commandline_With_Equinox_Launcher
for /f "delims= tokens=1" %%c in ('dir /B /S /OD "%eclipsehome%\plugins\org.eclipse.*.launcher_*.jar"') do set startup=%%c
:: echo startup jar: %startup% 

IF "%java%"=="" (
  set java=C:\SoftwareAGONE912\jvm\jvm\jre\bin\java.exe
)

IF "%eclipseworkspace%"=="" (
  set eclipseworkspace=C:/Users/sagew/EricWorkspace03
)

IF "%buildfile%"=="" (
  set buildfile=C:\Program Files (x86)\Jenkins\workspace\SAGEW_UNIT_TEST\SAGEW-test\buildJenkins.xml
)

:: The Ant listener can be used when a Junit-like report format of the Testing output is required.
:: The file name of the listener output can be specified via the "NaturalTestingJunitLogger.file"
:: property in the build.xml file. Default is "log.xml". Uncomment if required.
set listener=
:: set listener=-listener com.softwareag.naturalone.gen.nbs.eclipse.ant.NaturalTestingJunitLogger

:: parameters needed for debugging. This is copied from process explorer and the debug version on Eclipse.
set additional=

"%java%" -Xms128m -Xmx1024m -XX:MaxPermSize=256m -jar "%startup%" -data "%eclipseworkspace%" -noupdate -application org.eclipse.ant.core.antRunner %listener% -file "%buildfile%" %additional%

ENDLOCAL

