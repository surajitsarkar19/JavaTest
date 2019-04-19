::@echo off

set BUILD_PATH=classes
set CLASSES="Lion.java TestInstrumentation.java"
set AGENT_JAR=agent.jar
set MAIN_CLASS=TestInstrumentation

if not exist %BUILD_PATH% (
	mkdir %BUILD_PATH%
) else (
	rmdir %BUILD_PATH%
	mkdir %BUILD_PATH%
)

if not exist %AGENT_JAR% (
	echo %AGENT_JAR% not found............
	goto :eof
)

echo Compiling classes................
::javac -d classes -cp .;./classes;./lib/javassist-3.12.1.GA.jar Lion.java
::javac -d classes -cp .;./classes;./lib/javassist-3.12.1.GA.jar TestInstrumentation.java

for /f "delims= " %%f in ("%CLASSES%") do (
	javac -d classes -cp .;./classes;./lib/javassist-3.12.1.GA.jar %%f
)

echo Running program............
java -cp .;./lib/javassist-3.12.1.GA.jar -javaagent:./%AGENT_JAR% %MAIN_CLASS%