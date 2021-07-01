<#
.SYNOPSIS
    Version: 0.0.0.1
    Capture web pages via a PowerShell script using Puppeteer.

.DESCRIPTION
    This script requires NodeJS and Puppeteer to be installed before first use.
    Once NodeJS and Puppeteer are installed, this script captures an image of a given web page, in a specific size and saves it to a specific location.

    Requirements:
    -PowerShell 3.0+
    -Google Puppeteer: https://github.com/puppeteer/puppeteer
    -NodeJS: https://nodejs.org/en/

.PARAMETER URL
    Required.  The name of the web page that is to be captured to an image file.

.PARAMETER Wait
    Optional.  If supplied, the amount of time that the script will wait until it captures the image, which is important for web pages that take a few seconds to load.
    If not supplied, the script will supply a value of 6000 milliseconds.

.PARAMETER Height
    Optional.  If supplied, the height of the screen capture in pixels. 
    If not supplied, the script will supply a value of 2560 pixels.

.PARAMETER Width
    Optional.  If supplied, the width of the screen capture in pixels. 
    If not supplied, the script will supply a value of 2560 pixels.

.PARAMETER Path
    Optional. The path where the Puppeteer files are located.
    If not supplied, the script will supply a value of c:\puppeteer\ for the path.  
    The path will be checked for the existence of the Puppeteer installation files and if not found, will exit.

.PARAMETER FilePath
    Required. The target path where the screen capture will be saved.
    If the FilePath is invalid, the script will exit.

.EXAMPLE
    PS> .\New-SqupWebPageCapture.ps1 -URL "https://squaredup.com/" -Path "D:\apps\Puppeteer" -FilePath "c:\users\user\desktop\test_image.png" 
    PS> .\New-SqupWebPageCapture.ps1 -URL "https://squaredup.com/" -Wait 6000 -Height 2560 -Width 768 -FilePath "c:\users\user\desktop\test_image.png"

.NOTES  
    Copyright (c) 2018 SquaredUp Ltd, All Rights Reserved.
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "")]
[CmdletBinding(
    SupportsShouldProcess = $false,
    ConfirmImpact = "Low"
)]
Param(
    [Parameter(Mandatory = $true)]  [string] $URL,
    [Parameter(Mandatory = $false)] [Int32] $Wait,
    [Parameter(Mandatory = $false)] [Int32] $Height,
    [Parameter(Mandatory = $false)] [Int32] $Width,
    [Parameter(Mandatory = $false)] [string] $Path,
    [Parameter(Mandatory = $true)]  [string] $FilePath
)

#Requires -Version 3.0
Set-StrictMode -Version 5.0
$ErrorActionPreference = "stop"

# Set debug prompts to continue rather than inquire and *constantly* bother you with confirmation prompts
If ($PSBoundParameters['Debug']) {
    $DebugPreference = [System.Management.Automation.ActionPreference]::Continue
}

<#############################################################################
 # Support functions
 ############################################################################>
Write-Host "New-SqupWebPageCapture.ps1" -ForegroundColor White
Write-Host "Copyright 2018 Squared Up Limited, All Rights Reserved." -ForegroundColor DarkGray
Write-Host

# index.js framework
$IndexJS = @"
// index.js
const puppeteer = require('puppeteer');

(async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.setViewport({
      width: ##Width##,
      height: ##Height##,
      deviceScaleFactor: 1,
    });
    await page.goto('##URL##');
    await page.waitForTimeout(##WAIT##);
    await page.screenshot({path: '##OutFile##'});
    await browser.close();
})();
"@

#Default the Path varaible if not supplied
if ([string]::IsNullOrEmpty($Path)) {
    Write-Host "WARN: Defaulting to c:\Puppeteer\ directory" -ForegroundColor Yellow
    $Path = "C:\Puppeteer\"
}

#validate that Puppeteer is in the correct location
if (Test-Path -Path (join-path $Path -ChildPath "\node_modules\puppeteer\install.js")) { 
    Write-Host "NOTE: Puppeteer exists in this path" -ForegroundColor Green
} 
else {
    Write-Host "ERR: The Path to Puppeteer does not exist" -ForegroundColor Red
    Break
}

#Validate the FilePath
if (Test-Path -Path (Split-Path -Path $FilePath)) { 
    Write-Host "NOTE: FilePath exists" -ForegroundColor Green
    #Convert $FilePath into a destination that NodeJS can use
    #$OutFile = [regex]::escape($FilePath)
    $OutFile = $FilePath -replace '\\', '\\'
} 
else {
    Write-Host "ERR: FilePath does not exist" -ForegroundColor Red
    Break
}

#Make sure the value of wait is 1 millisecond or longer
if ($Wait -eq 0) {
    Write-Host "WARN: Wait needs to be 1 millisecond or longer, setting to 6000" -ForegroundColor Yellow
    [int32]$Wait = '6000'
}

#Check the value of Height
if ($Width -eq 0) {
    Write-Host "WARN: Width needs to be non-zero in lenth, setting to a default of 2560" -ForegroundColor Yellow
    [int32]$Width = '2560'
}

#Check the value of Width
if ($Height -eq 0) {
    Write-Host "WARN: Height needs to be non-zero in lenth, setting to a default of 2560" -ForegroundColor Yellow
    [int32]$Height = '2560'
}

#Create a temporary file for our NodeJS Capture
$NodeJSFileName = Join-Path -path $Path -ChildPath ([System.IO.Path]::GetRandomFileName())

$IndexJS = $IndexJS -replace "##URL##", $URL
$IndexJS = $IndexJS -replace "##WAIT##", $Wait
$IndexJS = $IndexJS -replace "##Height##", $Height
$IndexJS = $IndexJS -replace "##WIDTH##", $Width
$IndexJS = $IndexJS -replace "##OUTFILE##", $OutFile

Write-Host "INFO Create the index.js file" -ForegroundColor White
Set-Content -Path $NodeJSFileName -Value ($IndexJS)

#Call NodeJS and pass it our (sample) Puppeteer script
Write-Host "INFO Starting capture" -ForegroundColor White
node $NodeJSFileName
Write-Host "INFO Capture complete" -ForegroundColor White

Write-Host "INFO Remove the index.js file" -ForegroundColor White
Remove-Item -Path $NodeJSFileName