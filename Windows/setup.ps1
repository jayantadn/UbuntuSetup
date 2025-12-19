# Install Python and Google Chrome using Winget
# Run this script in PowerShell with Administrator privileges

# Ensure Winget is available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not installed. Please update Windows 11 or install Winget manually."
    exit
}

### --- Python Installation ---
$pythonInstalled = Get-Command python -ErrorAction SilentlyContinue
if ($pythonInstalled) {
    Write-Host "✅ Python is already installed. Version:"
    python --version
} else {
    Write-Host "🚀 Installing Python via Winget..."
    winget install --id Python.Python.3.10 --source winget `
        --silent --accept-package-agreements --accept-source-agreements
    Write-Host "✅ Python installation complete. Version:"
    python --version
}

### --- Google Chrome Installation ---
$chromeInstalled = Get-Command chrome -ErrorAction SilentlyContinue
if ($chromeInstalled) {
    Write-Host "✅ Google Chrome is already installed."
} else {
    Write-Host "🚀 Installing Google Chrome via Winget..."
    winget install --id Google.Chrome --source winget `
        --silent --accept-package-agreements --accept-source-agreements
    Write-Host "✅ Google Chrome installation complete."
}
