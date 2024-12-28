#!/bin/bash

# Check updates
sudo apt-get update

# Check for Python 3
python3Version=$(python3 --version 2>&1)
if [[ ! $python3Version =~ ^Python\ 3\. ]]; then
    echo "Python 3 is not installed. Installing..."
    sudo apt install -y python3.10
else
    echo "Python 3 is already installed."
fi

# Install / Updates essentials
sudo apt-get install -y build-essential libssl-dev libffi-dev python3.10-dev python3.10-venv python3-pip

# Clone the repository
git clone https://github.com/bvoytash/Crypto_Analyzator.git
cd Crypto_Analyzator

# Create a virtual environment
python3 -m venv .venv

# Activate the virtual environment
source .venv/bin/activate

# Upgrade pip
python3 -m pip install --upgrade pip

# Install dependencies
pip3 install -r requirements.txt

# Ask to run the app
read -p "Setup complete. Do you want to run the app? (y/n): " runApp
if [[ $runApp == 'y' ]]; then
    gnome-terminal -- bash -c "source .venv/bin/activate; python3 main.py; exec bash"
    echo "Server has been started on http://127.0.0.1:8080"
else
    echo "Exiting without running the application."
fi

read -p "Press any key to continue..."

