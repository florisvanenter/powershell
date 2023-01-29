<#
    .SYNOPSIS
        Search for locked user events
    .DESCRIPTION
        This script searches in all Domain Controllers which accounts has been locked out.
    .PARAMETER Server
        The DNS name of the AD to resolve the domain controller
    .PARAMETER ExcludeDc
        PSCustomObject with details of the new user, with Name,UserPrincipalName,GivenName,Surname,DisplayName,SamAccountName
    .PARAMETER MaxEvents
        The number of events to look for, more takes more time,
    .PARAMETER Path
        Path to write the output to (Folder\filename.ext)
    .NOTES

#>

Param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $Server,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string[]] $ExcludeDc = @(),

    [ValidateNotNullOrEmpty()]
    [integer] $MaxEvents = 39
)

Process {
    $ComputerNames = (Get-ADDomain -Server $Server).ReplicaDirectoryServers | Where-Object { $_ -notin $ExcludedDc}
    $Events = Invoke-Command -ComputerName $ComputerNames -ScriptBlock {
        Get-WinEvent -LogName Security | Where-Object Id -eq 4740 | Select-Object -first $MaxEvents
    }

    $Events | Select-Object -ExcludeProperty RunspaceId | Select-Object MachineName, TimeCreated, Message


}
