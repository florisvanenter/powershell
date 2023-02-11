<#
    .SYNOPSIS
        Update an UPN with a new one
    .DESCRIPTION
        Fliter on an OU with the old UPN and update with a new one
    .PARAMETER SearchBase
        The Ou to search objects in, empty or null means in complete AD
    .PARAMETER OldUpn
        The UPN to replace
    .PARAMETER NewUpn
        The UPN to replace it with
#>

param (

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $SearchBase,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $OldUpn,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $NewUpn

)

process {

    If (SearchBase) {
        $Targets = Get-ADUser -Filter { UserPrincipalName -like "*$OldUpn" } -SearchBase $SearchBase -Properties UserPrincipalName
    } Else {
        $Targets = Get-ADUser -Filter { UserPrincipalName -like "*$OldUpn" } -Properties UserPrincipalName
    }

    $Targets | ForEach-Object { Set-ADUser -Identity $_.SamAccountName -UserPrincipalName ( $_.UserPrincipalName.Replace(('@' + $OldUpn), ('@' + $NewUpn)) ) }

}
