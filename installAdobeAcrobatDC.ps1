# Step 1: Download the Adobe Reader installer using WebClient
$downloadUrl = "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/2400320112/AcroRdrDCx642400320112_cs_CZ.exe"
$installerPath = "$env:TEMP\AcroRdrDCx642400320112_cs_CZ.exe"

Write-Host "Downloading Adobe Reader using WebClient..."
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($downloadUrl, $installerPath)

# Step 2: Install Adobe Reader silently
Write-Host "Installing Adobe Reader silently..."
Start-Process -FilePath $installerPath -ArgumentList "/sAll", "/rs", "/msi", "EULA_ACCEPT=YES" -Wait

# Step 3: Set Adobe Reader as the default app for PDF using ADelRCP.exe
Write-Host "Setting Adobe Reader as the default app for PDFs..."
$adelrcpPath = "$ProgramFiles\Adobe\Acrobat DC\Acrobat\ADelRCP.exe"

# Run ADelRCP.exe in elevated mode to set Adobe Reader as the default PDF handler
Start-Process -FilePath $adelrcpPath -Verb RunAs

Write-Host "Adobe Reader has been installed and set as the default PDF viewer."
