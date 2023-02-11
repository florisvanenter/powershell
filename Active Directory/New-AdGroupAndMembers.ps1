<#
    .SYNOPSIS
        Create a group and add users in an OU
    .DESCRIPTION
        Create a group and check users in an OU and add them to a group
    .PARAMETER Ou
        The OU where the users are located
    .PARAMETER GroupName
        The name of the group to be created
    .PARAMETER GroupOu
        The Ou where to put the newly created group
#>

param (
    
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $Ou,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $GroupName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $GroupOu

)

process {

    New-ADGroup -Name $GroupName -SamAccountName $GroupName -GroupCategory Security -GroupScope Global -Path $GroupOu
    Get-Aduser -filter * -property Name, Department, DistinguishedName -SearchBase $Ou | ForEach-Object { Add-ADGroupMember -Identity $GroupName -Members $_.SamAccountName }

}
