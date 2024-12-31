# Check for Python 3
$pythonVersion = & python --version 2>&1
if ($pythonVersion -notmatch "Python 3\.") {
    Write-Host "Python 3 is not installed. Installing..."

    # Install Python
    winget install -e --id Python.Python.3.10 --scope machine

    # Refresh PATH variable in current session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")  

    Write-Host "Python 3.10 is installed."
} else {
    Write-Host "Python 3 is already installed."
}

# Clone the repository
git clone https://github.com/bvoytash/Crypto_Analyzator.git
Set-Location -Path "Crypto_Analyzator"

# Create a virtual environment
python -m venv .venv

# Activate the virtual environment
& .\.venv\Scripts\Activate.ps1

# Upgrade pip
python -m pip install --upgrade pip

# Install dependencies
pip install -r requirements.txt

# Ask to run the app
$runApp = Read-Host "Setup complete. Do you want to run the app? (y/n)"
if ($runApp -eq 'y') {
    Start-Process -FilePath "python" -ArgumentList "main.py"
    Write-Host "Server has been started on http://127.0.0.1:8080"
} else {
    Write-Host "Exiting without running the application."
}

Pause
