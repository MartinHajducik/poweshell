# Define the log file path in the default Temp directory
$logFilePath = "$env:TEMP\AdobeAcrobatDC_install.log"

# Function to write log messages
function Write-Log {
    param (
        [string]$message
    )
    # Append the current date and time to the message
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $logMessage = "$timestamp - $message"
    
    # Write to log file
    Add-Content -Path $logFilePath -Value $logMessage
    # Also display the message in the console
    Write-Host $logMessage
}

# Step 1: Download the Adobe Reader installer using WebClient
$downloadUrl = "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/2400320112/AcroRdrDCx642400320112_cs_CZ.exe"
$installerPath = "$env:TEMP\AcroRdrDCx642400320112_cs_CZ.exe"

Write-Log "Downloading Adobe Reader using WebClient..."
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($downloadUrl, $installerPath)

# Step 2: Install Adobe Reader silently
Write-Log "Installing Adobe Reader silently..."
Start-Process -FilePath $installerPath -ArgumentList "/sAll", "/rs", "/msi", "EULA_ACCEPT=YES" -Wait

# Step 3: Set Adobe Reader as the default app for PDF
Write-Log "Setting Adobe Reader as the default app for PDFs..."
$extension = ".pdf"
$progId = "AcroExch.Document"

# Alternative method using ftype and assoc
& cmd.exe /c "ftype $progId=`"%ProgramFiles%\Adobe\Acrobat DC\Acrobat\Acrobat.exe`" `%1"
& cmd.exe /c "assoc $extension=$progId"

Write-Log "Adobe Reader has been installed and set as the default PDF viewer."
