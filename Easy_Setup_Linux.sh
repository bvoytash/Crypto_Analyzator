#!/bin/bash

# Check if Python is installed
python3 --version > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Python is not installed. Please download and install Python 3.10 from:"
    echo "https://www.python.org/downloads/release/python-3100/"
    echo "Make sure to check 'Add Python to PATH' during installation."
    read -p "Press enter to exit..."
    exit 1
fi

# Proceed with cloning the repository and setting up the environment
git clone https://github.com/bvoytash/Crypto_Analyzator.git
cd Crypto_Analyzator || exit
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
pip install -r requirements.txt

# Ask the user if they want to run the application
read -p "Setup complete. Do you want to run the application? (y/n): " runApp

if [[ "$runApp" == "y" || "$runApp" == "Y" ]]; then
    python main.py &
    echo "Server has been started on http://127.0.0.1:8080"
else
    echo "Exiting without running the application."
fi

read -p "Press enter to exit..."
