@echo off
cls
:menu
	echo.
	echo Select shell command to execute:
	echo.
	echo 1. Compile python file using exefilename.spec
	echo 2. Create Virtual Environment
	echo 3. Activate virtual enviroment
	echo 4. Deactivate virtual enviroment
	echo 5. Git init, sync and first commit to a existing repository with the same name as this folder
	echo 6. Pip install project's requirements.txt
	echo 7. Exit
	echo.
	set /p choice=Type the number and press Enter: 
	if not '%choice%'=='' set choice=%choice:~0,1%
	if '%choice%'=='1' goto pyinstaller
	if '%choice%'=='2' goto createvenv
	if '%choice%'=='3' goto venvactivate
	if '%choice%'=='4' goto venvdeactivate
	if '%choice%'=='5' goto gitinit
	if '%choice%'=='6' goto requirements
	if '%choice%'=='7' goto end
	echo.
	echo "%choice%" is not valid, try again!
	echo.
	goto menu

:pyinstaller
	del /F/Q/S build
	rmdir /Q/S build
	del /F/Q/S dist
	rmdir /Q/S dist
	pyinstaller --clean exefilename.spec
	for /D /r %%G in (./dist/*) do "%~dp0"7zip a ./dist/%%~nxG.zip ./dist/*
	del /F/Q/S build
	rmdir /Q/S build
	goto end

:venvactivate
	cd venv
	cd Scripts
	activate.bat
	goto end

:venvdeactivate
	cd venv
	cd Scripts
	deactivate.bat
	goto end

:createvenv
	virtualenv venv

:gitinit
	git init
	git add .
	git config --global user.email "gilsonmneto@yahoo.com.br"
	git config --global user.name "gilsonmneto"
	git commit -m "first commit"
	for %%I in (.) do set CurrDirName=%%~nxI
	git remote add origin https://github.com/gilsonmneto/%CurrDirName%
	git push -u origin master
	goto end

:requirements
	pip install -r requeriments.txt
	goto end

:end
