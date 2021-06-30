<#
.SYNOPSIS
    Version: 0.0.0.1
    Convert SquaredUp dashboard JSON from one product to another.

.DESCRIPTION
    The script gathers diagnostic information to a temporary directory,

    Requirements:
    -PowerShell 3.0+
    -A SquaredUp product like SquaredUp for SCOM, SquaredUp for Azure, or Dashboard Server

.PARAMETER Source
    Required.  The name of the file that contains the source dashboard JSON.

.PARAMETER TileList
    Optional.  If supplied, the name of the file that contains the lookup table for dashboard tile conversion.
    If not supplied, the script will pull the lookup table from Github.

.PARAMETER Target
    The name of the target dashboard product.  Possible options are SCOM, Azure, and DS.

.PARAMETER Path
    The path where all of the files are located.

.EXAMPLE
    PS> .\Convert-SqupDashboard.ps1 -Source "squaredup-for-scom.json" -TileList "converting-dashboards.csv" -Target Azure -Path "C:\users\user\desktop\"

.NOTES  
    Copyright (c) 2018 SquaredUp Ltd, All Rights Reserved.
#>
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "")]
[CmdletBinding(
    SupportsShouldProcess = $false,
    ConfirmImpact = "Low"
)]
Param(
    [Parameter(Mandatory = $true)]  [string] $Source, 
    [Parameter(Mandatory = $false)] [string] $TileList, 
    [Parameter(Mandatory = $true)]  [ValidateSet("SCOM","Azure","DS")][string] $Target,
    [Parameter(Mandatory = $true)]  [string] $Path,
    [Parameter(Mandatory = $true)]  [string] $OutFile
)

#Requires -Version 3.0
Set-StrictMode -Version 2.0
$ErrorActionPreference = "stop"

# Set debug prompts to continue rather than inquire and *constantly* bother you with confirmation prompts
If ($PSBoundParameters['Debug']) {
    $DebugPreference = [System.Management.Automation.ActionPreference]::Continue
}

<#############################################################################
 # Support functions
 ############################################################################>

<#
.SYNOPSIS
    Read in a CSV lookup table to convert between products
#>
Function Get-SqupTileNames {
    param (
        [Parameter(Mandatory=$true)][string]$CSVFile
    )

    #Validate that $CSVFile is a file
    if (Test-Path -LiteralPath $CSVFile) { 
        Write-Host "INFO: CSV input file exists" -ForegroundColor Green
    } 
    else {
        Write-Host "ERR: CSV input file does not exist" -ForegroundColor Red
    }
    
    $TileList = Import-Csv -LiteralPath $CSVFile
    Return $TileList
}

<#
.SYNOPSIS
    Read in the JSON from the source dashboard
#>
Function Get-SqupSourceJSON {
    param (
        [Parameter(Mandatory = $true)][string]$JSONFile
    )

    #Validate that $JSONFile is a file
    if (Test-Path -LiteralPath $JSONFile) { 
        Write-Host "INFO: Dashboard JSON input file exists" -ForegroundColor Green
    } 
    else {
        Write-Host "ERR: Dashboard JSON input file does not exist" -ForegroundColor Red
    }
    
    $JSON = Get-Content -LiteralPath $JSONFile
    Return $JSON
}

<#
.SYNOPSIS
    Determine the product of the source dashboard
#>
Function Test-SqupJSON {
    #Evaluate the Dashboard JSON to determine which product the dashboard belongs to
    param (
        [Parameter(Mandatory = $true)] $JSON, 
        [Parameter(Mandatory = $true)] $TileList
    )

    #Regular Expression to test against three dashboard types
    #Only keep Tile like "_type": "tile/web-content"
    [regex]$regexTest = '(?<=\42_type\42: \42tile\57).*(?=\42)'
    $temp = @( $JSON | Select-String -Pattern $regexTest -AllMatches | ForEach-Object { $_.Matches } )

    $pCnt = @()
    #What kind of dashboard was passed in?
    foreach($line in $temp){
        foreach($tile in $TileList){
            #Score the dashboard based on how many tiles are in the JSON
            switch ($line) {
                $tile.SCOM { $pCnt += 'SCOM' }
                $tile.DS { $pCnt += 'DS' }
                $tile.Azure { $pCnt += 'Azure' }
            }
        }
    }

    #If the dashboard is generic, set to Generic
    if ($pCnt.count -eq 0) {
        #$Product = Select-Object $pCnt.count, 'Generic'
        $Product = $pcnt.count | Select-Object @{N = 'Count'; E = { 0 } }, @{N = 'Name'; E = { 'Generic' } }
    }
    else {
        #Return the highest rated dashboard
        $Product = $pCnt | Group-Object | Select-Object count, name -First 1
    }

    Return $Product
}

<#
.SYNOPSIS
    Convert the source JSON to the target product dashboard type
#>
Function ConvertTo-SqupDashboard {
    param(
        [Parameter(Mandatory = $true)]  $Source, 
        [Parameter(Mandatory = $false)] $TileList, 
        [Parameter(Mandatory = $true)]  [ValidateSet("SCOM", "Azure", "DS")][string] $Target, 
        [Parameter(Mandatory = $true)]  [string] $Path,
        [Parameter(Mandatory = $true)]  [string] $OutFile
    )
    
    #Check to see if the Tile List is loaded
    #if (!$TileList){
    #    Get-SqupTileNames
    #}

    #Retreive the dashboard JSON
    $JSON = Get-SqupSourceJSON -JSONFile (Join-Path -Path $Path -ChildPath $Source)

    #Identify what the type of Dashboard we were just given
    $DashType = Test-SqupJSON -JSON $JSON -TileList $TileList

    If ($DashType.Name -eq 'Generic'){
        Write-Host "INFO: Generic Dashboard Detected - Conversion is not required." -ForegroundColor Yellow
        Return
    }

    If ($DashType.Name -eq $Target) {
        Write-Host "INFO: Source and Target are Identical - Conversion is not required." -ForegroundColor Yellow
        Return
    }

    #Loop through each line and convert
    Write-Host "Converting" $DashType.Name "to $Target" -ForegroundColor Green
    foreach($line in $TileList){
        $JSON = $JSON -replace $line.($DashType.Name), $line.($Target)
    }
    $JSON | Set-Content -Path (Join-Path -Path $Path -ChildPath $OutFile) -Force
}

<#############################################################################
 # Entry Point
 ############################################################################>

Write-Host "Convert-SqupDashboard.ps1" -ForegroundColor White
Write-Host "Copyright 2018 Squared Up Limited, All Rights Reserved." -ForegroundColor DarkGray
Write-Host

if ([string]::IsNullOrEmpty($Target)) { 
    $Target = Read-Host -Prompt 'Please enter the target product type: SCOM, Azure, or DS. Hit enter to continue'
}

Write-Host "NOTE: Setting up conversion table" -ForegroundColor White
$TileTable = Get-SqupTileNames -CSVFile (Join-Path -Path $Path -ChildPath $TileList)

Write-Host "NOTE: Converting dashboard" -ForegroundColor White
ConvertTo-SqupDashboard -Source $Source -TileList $TileTable -Target $Target -Path $Path -OutFile $OutFile