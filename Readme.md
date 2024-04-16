# Printer Installation Script

This PowerShell script facilitates the downloading, extracting, and installing of printer drivers and the addition of printer ports based on user inputs. It is designed to be versatile and user-friendly, suitable for various printer models and types.

## Features

- **Dynamic Driver Installation**: Supports multiple driver types (EXE, ZIP, MSI).
- **Interactive User Inputs**: Prompts users for necessary configuration.
- **Enhanced Logging**: Detailed logging with timestamp and color-coded messages.
- **Error Handling**: Robust error handling with clear, actionable messages.
- **Security Measures**: Checks the integrity of the download process.

## Requirements

- **PowerShell 5.0 or Higher**: The script is designed for Windows environments with PowerShell 5.0 or newer.
- **Administrative Privileges**: Due to the nature of the operations involved (installing drivers, modifying printer settings), administrative rights are required.

## Configuration

Before running the script, ensure you have the following information ready:
- **Printer Name**: The name you want to assign to your printer.
- **Printer Hostname**: The network hostname or IP address of the printer.
- **Driver URL**: The full URL from where the printer driver can be downloaded.
- **Driver Type**: The type of the driver file (EXE, ZIP, MSI).

## Usage

To use the script, follow these steps:

1. **Open PowerShell**: Right-click on PowerShell and select "Run as Administrator" to open a PowerShell session with administrative privileges.

2. **Enable Script Execution**: Run the following command to allow the execution of scripts if it's not already enabled:

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

3. **Navigate to the Script**: Use the `cd` command to change to the directory where the script is located.

4. **Run the Script**: Execute the script by typing:

   ```powershell
   .\PrinterInstallationScript.ps1
   ```

5. **Follow Prompts**: Input the required details as prompted:
   - Printer name
   - Hostname or IP address
   - Driver download URL
   - Type of the driver file

The script will handle the rest, logging all actions and any errors encountered.

## Troubleshooting

If you encounter issues during the installation, refer to the following troubleshooting steps:

- **Check Execution Policy**: Ensure that the script execution policy allows running scripts.
- **Verify Admin Rights**: Confirm that PowerShell is running with administrative privileges.
- **Review Log Messages**: Carefully read the error messages provided in the logs. They are designed to offer specific guidance on what might have gone wrong.
- **Internet Connectivity**: Ensure that the system has active internet connectivity to download the driver.

## Additional Notes

- **Security Caution**: Only download drivers from trusted and secure sources to avoid security risks.
- **Custom Modifications**: The script can be modified to include more sophisticated error handling or to integrate with larger deployment workflows.

