<#############################################################################
 # Install-SqupWebPageCapture Version: 0.0.0.1
 ############################################################################>
Write-Host "Install-SqupWebPageCapture.ps1" -ForegroundColor White
Write-Host "Copyright 2018 Squared Up Limited, All Rights Reserved." -ForegroundColor DarkGray
Write-Host

<#############################################################################
 # Constants
 ############################################################################>
$fPuppeteer = 'Puppeteer'  # The name of the directory where Puppeteer will be installed
$fImages = 'Images'        # Where Screen Captures will be stored
$pRoot = "C:\"             # The ROOT directory for this project
$nodejsVer = "14.17.1"     # The version of NodeJS to install
$ImageFile = "Capture-$(Get-Date -Format 'yyyyMMdd-HHmmss').png"

<#############################################################################
 # Set the Execution Policy so that we can install NodeJS
 ############################################################################>
Write-Host "INFO seting the ExecutionPolicy to Unrestricted for this package (critical or warning message is normal)" -ForegroundColor Yellow
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

<#############################################################################
 # Chocolately functions to refresh the System.Environment
 ############################################################################>
Write-Host "INFO Loading some Chocolately functions to refresh the System.Environment for this session only" -ForegroundColor White
$url = "https://raw.githubusercontent.com/chocolatey/choco/stable/src/chocolatey.resources/helpers/functions/"
$WriteFunctionCallLogMessage = "Write-FunctionCallLogMessage.ps1"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($url+$WriteFunctionCallLogMessage))
$GetEnvironmentVariableNames = 'Get-EnvironmentVariableNames.ps1'
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($url+$GetEnvironmentVariableNames))
$GetEnvironmentVariable = 'Get-EnvironmentVariable.ps1'
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($url+$GetEnvironmentVariable))
$UpdateSessionEnvironment = 'Update-SessionEnvironment.ps1'
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($url+$UpdateSessionEnvironment))

<#############################################################################
 # Support Functions
 ############################################################################>
# Create the Puppeteer directory
If (!(Test-Path "$pRoot$fPuppeteer")) {
    New-Item -itemType Directory -Path $pRoot -Name $fPuppeteer | Out-Null
    Write-Host "INFO Creating Puppeteer folder" -ForegroundColor Green
}
Else {
    Write-Host "WARN Puppeteer folder already exists" -ForegroundColor Yellow
}

# Create the Puppeteer image capture directory
If (!(Test-Path "$pRoot$fPuppeteer\$fImages")) {
    New-Item -itemType Directory -Path "$pRoot$fPuppeteer" -Name $fImages | Out-Null
    Write-Host "INFO Creating Images folder" -ForegroundColor Green
}
Else {
    Write-Host "INFO Images folder already exists" -ForegroundColor Yellow
}

#Check if the NodeJS MSI has already been downloaded
If (!(Test-Path "$pRoot$fPuppeteer\node-v$nodejsVer-x64.msi")) {
    Write-Host "INFO Downloading NodeJS" -ForegroundColor Green
    Invoke-WebRequest "https://nodejs.org/download/release/v$nodejsVer/node-v$nodejsVer-x64.msi" -OutFile "$pRoot$fPuppeteer\node-v$nodejsVer-x64.msi"
    Write-Host "INFO Finished downloading NodeJS" -ForegroundColor Green
    #Pause for 2 seconds, just in case
    Start-Sleep -Seconds 2
}
Else {
    Write-Host "WARN Puppeteer installation MSI already exists" -ForegroundColor Yellow
}

Write-Host "INFO Installing NodeJS" -ForegroundColor White
Start-Process "$pRoot$fPuppeteer\node-v$nodejsVer-x64.msi" -ArgumentList "/q /l* $pRoot$fPuppeteer\node-install.log" -Wait
# (Optional) Display the installation log
# Get-Content node-install.log
Write-Host "INFO Finished installing NodeJS" -ForegroundColor White

# At this point, we need to refresh the PowerShell environment.
# We're going to use some Chocolately functions that have been posted on GitHub.
# If these are not available, we need to restart the PowerShell session and start here.
Write-Host "WARN Refresh the PowerShell Environment" -ForegroundColor Yellow
Update-SessionEnvironment

Write-Host "INFO Begin installing Puppeteer" -ForegroundColor White
Set-Location -Path $pRoot$fPuppeteer
Write-Host "INFO Initialize NPM" -ForegroundColor White
Start-Process "C:\Program Files\nodejs\npm.cmd" -ArgumentList "init -y" -WorkingDirectory $pRoot$fPuppeteer -Wait

Set-Location -Path "C:\Program Files\nodejs\"
Write-Host "INFO NPM installing Puppeteer" -ForegroundColor White
Start-Process "C:\Program Files\nodejs\npm.cmd" -ArgumentList " install --prefix $pRoot$fPuppeteer\ puppeteer " -Wait
Write-Host "INFO Finished installing Puppeteer" -ForegroundColor White

<#############################################################################
 # Create the first screen capture
 ############################################################################>
#Create a sample index.js file to capture a web page
$IndexJS = @"
const puppeteer = require('puppeteer');

(async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.setViewport({
      width: 2560,
      height: 2560,
      deviceScaleFactor: 1,
    });

    await page.goto('https://squaredup.com');
    await page.waitForTimeout(6000);
    await page.screenshot({path: '$pRoot\$fPuppeteer\\$fImages\\$ImageFile'});
    await browser.close();
})();
"@

Write-Host "INFO Create a sample index.js file" -ForegroundColor White
Set-Content -Path $pRoot$fPuppeteer\index.js -Value ($IndexJS)

#Call NodeJS and pass it our (sample) Puppeteer script
Write-Host "INFO Capture a dashboard and save it to the Image folder to validate installation" -ForegroundColor White
node $pRoot$fPuppeteer\index.js
Remove-Item -Path $pRoot$fPuppeteer\index.js

<#############################################################################
 # Finish line
 ############################################################################>
Write-Host "INFO Finished installing Puppeteer" -ForegroundColor White
