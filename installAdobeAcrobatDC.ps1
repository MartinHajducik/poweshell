# Step 1: Download the Adobe Reader installer using WebClient
$downloadUrl = "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/2400320112/AcroRdrDCx642400320112_cs_CZ.exe"
$installerPath = "$env:TEMP\AcroRdrDCx642400320112_cs_CZ.exe"

Write-Host "Downloading Adobe Reader using WebClient..."
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($downloadUrl, $installerPath)

# Step 2: Install Adobe Reader silently
Write-Host "Installing Adobe Reader silently..."
Start-Process -FilePath $installerPath -ArgumentList "/sAll", "/rs", "/msi", "EULA_ACCEPT=YES" -Wait

# Step 3: Set Adobe Reader as the default app for PDF
Write-Host "Setting Adobe Reader as the default app for PDFs..."
$extension = ".pdf"
$progId = "AcroExch.Document.DC"

# Use the "ftype" command to associate the file extension with the ProgID
& cmd.exe /c "ftype $progId=`"%ProgramFiles%\Adobe\Acrobat DC\Acrobat\AcroRd32.exe`" `%1"

# Use "assoc" to associate .pdf with the program
& cmd.exe /c "assoc $extension=$progId"

Write-Host "Adobe Reader has been installed and set as the default PDF viewer."
