@echo off
setlocal

REM Check for Python 3.10.0
python --version 2>nul | find "Python 3.10.0" >nul
if %errorlevel% neq 0 (
    echo Python 3.10.0 is not installed. Installing...

    REM Download the Python 3.10.0 installer
    set "PYTHON_INSTALLER=https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe"
    set "INSTALLER_NAME=python-3.10.0-amd64.exe"

    REM Download the installer
    powershell -Command "Invoke-WebRequest -Uri %PYTHON_INSTALLER% -OutFile %INSTALLER_NAME%"

    REM Install Python silently and add to PATH
    start /wait msiexec /i %INSTALLER_NAME% /quiet InstallAllUsers=1 PrependPath=1

    REM Clean up the installer file
    del %INSTALLER_NAME%
) else (
    echo Python 3.10.0 is already installed.
)

REM Clone the repository
git clone https://github.com/bvoytash/Crypto_Analyzator.git
cd Crypto_Analyzator

REM Create a virtual environment
python -m venv .venv

REM Activate the virtual environment
call .venv\Scripts\activate.bat

REM Upgrade pip
python -m pip install --upgrade pip

REM Install dependencies
pip install -r requirements.txt

REM Ask to run the app
set /p runApp="Setup complete. Do you want to run the app? (y/n): "
if /i "%runApp%"=="y" (
    start cmd /k "python main.py"
    echo Server has been started on http://127.0.0.1:8080
) else (
    echo Exiting without running the application.
)

pause

endlocal
