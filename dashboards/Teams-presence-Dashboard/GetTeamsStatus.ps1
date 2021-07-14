
$myguid = "Randomguid"
$HomeIP = "myhomeip"
$WorkIP = "myworkip" 
$externaliP = (Invoke-WebRequest ipconfig.me).content
$Name = "mynamehere"
$ProfilePicture = "profileurl-in-png"
$JsonPath = "x:\sharedpresence\"

function DetectLocation {
    param (
        $DetectediP
    )
   switch ($DetectediP) {
    $homeip {"at home"}  
    $WorkIP {"at the Office"}
    Default {"Unknown Location"}
   }
}


function TranslateStatus {
    param (
        $TeamsStatus
    )
    switch ($TeamsStatus) {
        "Busy"{ "Critical" }
        "DoNotDisturb"{ "Critical" }
        "BeRightBack"{ "Unhealthy" }
        "Away"{ "Unhealthy" }
        "Offline" {"Unkown"}
        "Available"{ "Healthy" }
        "OnThePhone"{ "Critical" }
        Default {"Unkown"}
    }
}
Get-Content $env:APPDATA\Microsoft\Teams\logs.txt -Wait -Tail 0 | where-object { $_ -match "(?<=StatusIndicatorStateService: Added )(\w+)" } | foreach { if($matches[0] -ne "NewActivity") {

    $Status = [PSCustomObject]@{
        name = $name
        Department = $Department
        guid = $myguid
        Clientlocation = DetectLocation($externaliP)
        Teamsstatus = $matches[0]
        State = TranslateStatus($matches[0])
        ProfilePicture = $ProfilePicture

    }

$status|ConvertTo-Json|out-file $JsonPath\$myguid.json
$status
}}
