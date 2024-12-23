@echo off

REM Check if Python is installed
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python is not installed. Please download and install Python 3.10 from:
    echo https://www.python.org/downloads/release/python-3100/
    echo Make sure to check "Add Python to PATH" during installation.
    pause
    exit /b
)

REM Proceed with cloning the repository and setting up the environment
git clone https://github.com/bvoytash/Crypto_Analyzator.git
cd Crypto_Analyzator
python -m venv .venv
call .venv\Scripts\activate
python -m pip install --upgrade pip
pip install -r requirements.txt

REM Ask the user if they want to run the application
set /p runApp="Setup complete. Do you want to run the application? (y/n): "

IF /I "%runApp%"=="y" (
    start cmd /k python main.py
    echo Server has been started on http://127.0.0.1:8080
) ELSE (
    echo Exiting without running the application.
)

pause
