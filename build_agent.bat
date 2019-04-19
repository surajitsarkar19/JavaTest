@echo off

set BUILD_PATH=classes
set PACKAGE_NAME=com.surajit.agent
set JAR_NAME=agent.jar

if not exist %BUILD_PATH% (
	mkdir %BUILD_PATH%
) else (
	rmdir %BUILD_PATH%
	mkdir %BUILD_PATH%
)

if exist %JAR_NAME% del %JAR_NAME%

echo Compiling classes................

javac -d classes -cp .;./classes;./lib/javassist-3.12.1.GA.jar ./%PACKAGE_NAME%/*.java

setlocal
set PACKAGE_NAME=%PACKAGE_NAME:.=/%
::Following line is using lazy delayed expansion feature using call command
::call set PACKAGE_NAME=%%PACKAGE_NAME:.=/%%
echo Creating jar............. %PACKAGE_NAME%
jar -cvfm %JAR_NAME% agent.manifest.mf -C classes/ .
endlocal