
[System.Collections.ArrayList]$myList = @()

# $BTEUServer is a variable that is setup in the Powershell profile - replace by your printer server or computer name 
$PrintersQueues = Invoke-Command -Computer $BTEUServer  -ScriptBlock {Get-Printer -CimSession localhost} 

ForEach ($Printer in $PrintersQueues ) {
     $myobj = New-Object PSObject
     
            Add-Member -InputObject $myobj -NotePropertyName PrinterName -NotePropertyValue $Printer.Name
            Switch ($Printer.PrinterStatus)
            {
                0 {$PrintStatus="Printer ready"
                    $PrintState="Healthy"}
                1  {$PrintStatus="Printer paused"
                    $PrintState="Warning"}
                2  {$PrintStatus="Printer error"
                $PrintState="Critical"}
                4  {$PrintStatus="Printer pending deletion"
                                        $PrintState="Warning"}
                8  {$PrintStatus="Paper jam"
                
                    $PrintState="Warning"}
                16  {$PrintStatus="Out of paper"
                    $PrintState="Warning"}
                32  {$PrintStatus="Manual feed"
                    $PrintState="Warning"}
                64  {$PrintStatus="Paper problem"
                    $PrintState="Critical"}
                128  {$PrintStatus="Printer offline"
                    $PrintState="Warning"}
                256  {$PrintStatus="IO active"
                    $PrintState="Warning"}
                512  {$PrintStatus="Printer busy"
                    $PrintState="Warning"}
                1024  {$PrintStatus="Printing"                
                    $PrintState="Healthy"}
                2048  {$PrintStatus="Printer output bin full"
                    $PrintState="Warning"}
                4096  {$PrintStatus="Printer Not available"
                    $PrintState="Critical"}
                8192  {$PrintStatus="Waiting"
                    $PrintState="Healthy"}
                16384  {$PrintStatus="Processing"
                    $PrintState="Healthy"}
                32768  {$PrintStatus="Initializing"
                
                    $PrintState="Healthy"}
                65536  {$PrintStatus="Warming up"                
                    $PrintState="Healthy"}
                131072  {$PrintStatus="Toner low"
                    $PrintState="Warning"}
                262144  {$PrintStatus="No toner"}
                524288  {$PrintStatus="Page punt"}
                1048576  {$PrintStatus="User intervention"}
                2097152  {$PrintStatus="Out of memory"}
                4194304  {$PrintStatus="Door open"}
                8388608  {$PrintStatus="Server unknown"}
                6777216  {$PrintStatus="Power save"}
  
            }
            Add-Member -InputObject $myobj -NotePropertyName StatusCode -NotePropertyValue $Printer.PrinterStatus    
             Add-Member -InputObject $myobj -NotePropertyName Status -NotePropertyValue $PrintStatus
            Add-Member -InputObject $myobj -NotePropertyName State -NotePropertyValue $PrintState
            Add-Member -InputObject $myobj -NotePropertyName JobCount -NotePropertyValue $Printer.JobCount
            Add-Member -InputObject $myobj -NotePropertyName Driver -NotePropertyValue $Printer.DriverName
            Add-Member -InputObject $myobj -NotePropertyName Error -NotePropertyValue $Printer.ErrorInformation
            [void]$mylist.add($myobj)
                           
        
}$mylist | Select PrinterName,StatusCode, State,Status, JobCount, Driver, Error