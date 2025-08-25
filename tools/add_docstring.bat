@echo off
REM Script per aggiungere docstring ai file Python
REM Riceve il percorso del file come parametro %1

REM Controlla se il file è un file Python
echo %1 | findstr /i "\.py$" > nul
if %errorlevel% neq 0 (
    exit /b 0
)

REM Esegui lo script Python per aggiungere docstring
python "%~dp0\..\tools\add_docstring.py" %1
