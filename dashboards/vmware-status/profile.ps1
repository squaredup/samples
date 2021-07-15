###############################################################################
# Load up our Custom Profile
###############################################################################
$User = "RunAs Account UserName"
$Pass = "RunAs Account Password"

#The URL to our vCenter Server
$vCenter = "FQDN of your vCenter Server"


###############################################################################
# Before a connection to vCenter is initiated, check some specific settings
# We mostly care about ignoring invalid certificate warnings and depreciated warnings
# Wrap the settings change in a Try-Catch block to prevent any unhandled exception messages
# This prevents error messages when multiple tiles attempt (and fail) to write to the PowerCLI_Settings.xml file at the same time
###############################################################################
$lConfig = Get-PowerCLIConfiguration -Scope User
If ($lConfig.InvalidCertificateAction -ne 'Ignore') {
    try {
        Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false -ErrorAction SilentlyContinue
    }
    Catch {
        #$Error[0]
    }
}

If ($lConfig.DisplayDeprecationWarnings -ne 'False') {
    try {
        Set-PowerCLIConfiguration -DisplayDeprecationWarnings $false -Confirm:$false -ErrorAction SilentlyContinue | Out-Null
    }
    Catch {
        #Error[0]
    }
}

###############################################################################
# Conenct to vCenter
###############################################################################
$serverlist = $global:DefaultVIServer
while ($serverlist.IsConnected -ne "True") {
    try{
        Connect-VIServer -Server $vCenter -User $User -Password $Pass -ErrorAction SilentlyContinue
    }
    catch {        
    }
    $serverlist = $global:DefaultVIServer
}

###############################################################################
# Page Timeframe code
###############################################################################
$finish = [DateTime]::Now
switch ($timeFrame) {
    "last1Hour" { $start = $finish.Addhours(-1); $MaxSamples = 150; }
    "last12Hours" { $start = $finish.Addhours(-12); $MaxSamples = 300; }
    "last24Hours" { $start = $finish.Addhours(-24); $MaxSamples = 400; }
    "last7Days" { $start = $finish.AddDays(-7); $MaxSamples = 500; }
    "last30Days" { $start = $finish.AddDays(-30); $MaxSamples = 600; }
    "last3Months" { $start = $finish.AddMonths(-3); $MaxSamples = 700; }
    "last6Months" { $start = $finish.AddMonths(-6); $MaxSamples = 800; }
    "last12Months" { $start = $finish.AddMonths(-12); $MaxSamples = 900; }
}

###############################################################################
# Some variables to resuse
###############################################################################
$vm = "SYS-SCOM-MS02"
$vmHost = Get-VMHost -Name "int-vhost-esx01.int.squaredup.com"
