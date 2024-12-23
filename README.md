# Crypto_Analyzator
Flask, Pandas, Matplotlib

Import a content from Telegram chat group in .JSON format and get the most influenced crypto coins.

<img width="1426" alt="example_01" src="https://github.com/user-attachments/assets/914439f9-e438-4a54-a71d-29c7c96f756c">

# Live at: [crypto-analyzator.onrender.com](https://crypto-analyzator.onrender.com/)

# Steps to Clone and Run the Project

## Requirements
- **Python 3.10**: [Download Python 3.10](https://www.python.org/downloads/release/python-3100/)

## 0. Easy Setup
- **Easy Setup for Windows - Download and Run the File**: [Download Easy_Setup_Windows](https://github.com/bvoytash/Crypto_Analyzator/blob/cosmetic_improvements/Easy_Setup_Windows.bat)
- **Easy Setup for Linux - Download and Run the File**: [Download Easy_Setup_Linux](https://github.com/bvoytash/Crypto_Analyzator/blob/cosmetic_improvements/Easy_Setup_Linux.sh)

## 1. Clone the Repository and Navigate to the Folder
```
git clone https://github.com/bvoytash/Crypto_Analyzator.git && cd ./Crypto_Analyzator/
```

## 2. Create a Virtual Environment
- **Linux and macOS**:
    ```
    python3 -m venv .venv
    ```
- **Windows**:
    ```
    python -m venv .venv
    ```

## 3. Activate the Virtual Environment
**Assuming you are using Bash:**
- **Linux and macOS**:
    ```
    source .venv/bin/activate
    ```
- **Windows**:
    ```
    source venv/Scripts/activate
    ```

## 4. Install Dependencies
```
pip install -r requirements.txt
```

## 5. Run the Project
```
python main.py
```

## 6. Run the Tests
```
python -m unittest test_main.py
```