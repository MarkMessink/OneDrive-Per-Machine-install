<#
.SYNOPSIS
    Installation OneDrive Per-Machine install
	Mark Messink 13-10-2020
	Info: https://docs.microsoft.com/en-us/onedrive/per-machine-installation

.DESCRIPTION
 
.INPUTS
  None

.OUTPUTS
  Log file: ilog_OneDrive-per-machine.txt
  
.NOTES
  
.EXAMPLE
  .\OneDrive-per-machine-installer.ps1

#>

# Create logpath (if not exist)
$logpath = "C:\IntuneLogs"
If(!(test-path $logpath))
{
      New-Item -ItemType Directory -Force -Path $logpath
}

$logFile = "$logpath\ilog_OneDrive_per-machine.txt"

#Start logging
Start-Transcript $logFile -Append -Force

	Write-Output "-------------------------------------------------------------------"
    Write-Output "Download OneDrive from Microsoft"
    $downloadLocation = "https://go.microsoft.com/fwlink/?linkid=844652"
	$downloadDestination = "$($env:TEMP)\OneDriveSetup.exe"
	$webClient = New-Object System.Net.WebClient
	$webClient.DownloadFile($downloadLocation, $downloadDestination)
	Write-Output "-------------------------------------------------------------------"
	Write-Output "Install OneDrive per-machine"
	$installProcess = Start-Process $downloadDestination -ArgumentList "/allusers" -WindowStyle Hidden -PassThru
	$installProcess.WaitForExit()
	Write-Output "-------------------------------------------------------------------"
	Write-Output "OneDrive version information:"
	(Get-Item "${Env:ProgramFiles(x86)}\Microsoft OneDrive\OneDrive.exe").VersionInfo | FL Productname, FileName, Productversion
	Write-Output "-------------------------------------------------------------------"

#Stop Logging
Stop-Transcript
