<#
    .SYNOPSIS
    Replace the DNS Server settings with new ip-address
    .DESCRIPTION
    This script searches for all adapters with a specific DNS ip address and replaces all DNS ip addresses with the ones supplied
    .PARAMETER OldDns
    Find all adapters with a specific DNS ip-adress to be replaced
    .PARAMETER NewDns
    With which one/two ipaddresses does it need to be replaced with
    .NOTES
    This is a useful script for servers not set by DHCP
#>

Param (

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $OldDns,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string[]] $NewDns,

	[Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string[]] $ComputerName
    
)

Process {

	Invoke-Command -ComputerName $ComputerName -ArgumentList $OldDns, @(,$NewDns) -ScriptBlock {
		param ( $old, $new )
		Get-DnsClientServerAddress |
			Where-Object ServerAddresses -contains $old | 
			ForEach-Object { 
				Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses ($new) 
			}
	}
}
