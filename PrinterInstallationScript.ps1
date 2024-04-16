# User Configuration (You may prompt these or set them here)
$printerName = Read-Host "Enter Printer Name"
$hostname = Read-Host "Enter Printer Hostname"
$driverUrl = Read-Host "Enter Driver URL"
$driverType = Read-Host "Enter Driver Type (EXE, ZIP, MSI)"
$enableLogging = $true

# System Configuration
$tempFolder = "$env:TEMP\PrinterDriver"
$installerPath = "$tempFolder\installer.$driverType"

# Function to log messages
function LogMessage {
    param (
        [string]$Message,
        [string]$MessageType = "Info"  # Options are Info, Warning, Error
    )
    if ($enableLogging) {
        $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        switch ($MessageType) {
            "Info" { Write-Host "$timeStamp [INFO] $Message" }
            "Warning" { Write-Host "$timeStamp [WARNING] $Message" -ForegroundColor Yellow }
            "Error" { Write-Host "$timeStamp [ERROR] $Message" -ForegroundColor Red }
        }
    }
}

# Download and extract the printer driver
function DownloadAndExtractDriver {
    New-Item -Path $tempFolder -ItemType Directory -Force
    LogMessage "Downloading driver from: $driverUrl"

    try {
        $response = Invoke-WebRequest -Uri $driverUrl -OutFile $installerPath -UseBasicParsing
        if ($response.StatusCode -ne 200) {
            throw "Failed to download driver. HTTP Status: $($response.StatusCode)"
        }
        LogMessage "Driver downloaded successfully."
    } catch {
        LogMessage "Failed to download driver: $_" -MessageType "Error"
        return $false
    }

    try {
        switch ($driverType) {
            "EXE" { Start-Process $installerPath -ArgumentList "/s" -NoNewWindow -Wait }
            "ZIP" {
                Expand-Archive -Path $installerPath -DestinationPath $tempFolder -Force
                Start-Process "$tempFolder\setup.exe" -ArgumentList "/s" -NoNewWindow -Wait
            }
            "MSI" { Start-Process "msiexec.exe" -ArgumentList "/i `"$installerPath`" /qn" -NoNewWindow -Wait }
        }
        LogMessage "Driver installed successfully."
    } catch {
        LogMessage "Installation failed: $_" -MessageType "Error"
        return $false
    }
    return $true
}

# Install the printer
function InstallPrinter {
    if (Get-Printer -Name $printerName -ErrorAction SilentlyContinue) {
        LogMessage "Removing existing printer $printerName..."
        Remove-Printer -Name $printerName
    }
    if (Get-PrinterPort -Name $hostname -ErrorAction SilentlyContinue) {
        LogMessage "Removing existing printer port $hostname..."
        Remove-PrinterPort -Name $hostname
    }

    LogMessage "Adding printer port $hostname..."
    Add-PrinterPort -Name $hostname -PrinterHostAddress $hostname
    LogMessage "Adding printer $printerName..."
    Add-Printer -Name $printerName -DriverName $printerName -PortName $hostname
}

# Main execution block
try {
    if (DownloadAndExtractDriver) {
        InstallPrinter
        LogMessage "Printer installation completed successfully."
    } else {
        LogMessage "Aborting due to previous errors." -MessageType "Error"
    }
} catch {
    LogMessage "An unexpected error occurred: $_" -MessageType "Error"
}
