<#
    .SYNOPSIS
        Start a remote Azure Ad Sync
    .DESCRIPTION
        This script connects to the remote server where the Azure AD Sync is running
    .PARAMETER ComputerName
        The name or ip-adress of the server where AzureADSync is installed
    .NOTES
        You need to be able to connect via WinRM
#>

param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $ComputerName = 'ADServer.domain.local'
)

process {
    Invoke-Command -ComputerName $ComputerName -ScriptBlock {
        Start-ADSyncSyncCycle -PolicyType Delta
    }
}