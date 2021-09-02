
#Get AD Groups members 
$TeamADmin = Get-AdGroupMember -identity "Team1" | Select SamAccountName
$TeamDEV = Get-AdGroupMember -identity "Team2" | Select SamAccountName
$TeamERP = Get-AdGroupMember -identity "TeamERP" | Select SamAccountName

#This is whre you can define the users or AD groups which are authorized to have high privileges rights
$AuthorizedServerAdmins = @(
    "Domain\Account1"
    "Domain\Account2"
    "Domain\GroupName"
    "Domain\Domain Admins"
    "localAccount1"
    "localAccount2"
)
 
$AuthorizedDBAdmins = @(
    "Domain\DBAGroup"
    "Domain\Account2"
    "Domain\GroupName"
    "localSQLAccount1"
)

$AuthorizedAppsAdmins = @(
    "Domain\AppAdmins"
    "Domain\Account2"
    "ServiceAccount"
)

#Option1 - Define list of controls servers

$ScopeServers = @(
    "ComputerAppName1"
    "ComputerAppName2"
    "ComputerSQLName1"
)

#Option2 - Create a SCOM Group to be scope! - if you are using SquaredUp for SCOM