<#
    .SYNOPSIS
        Copy a user to a new user
    .DESCRIPTION
        Connect to Active Directory, and copy a user with all group memberhips
    .PARAMETER CopyFrom
        SamAccountName of the user to be copied
    .PARAMETER CopyTo
        PSCustomObject with details of the new user, with Name,UserPrincipalName,GivenName,Surname,DisplayName,SamAccountName
    .PARAMETER Password
        The password of the to be created user
    .PARAMETER Server
        The DNS name of the AD to resolve the domain controller
    .NOTES
        An parameter for server is used to be sure to connect to the right AD domain in case of UAT,PROD,etc
#>

Param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $CopyFrom,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $CopyTo,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $Password,

    [ValidateNotNullOrEmpty()]
    [string] $Server
)

Process {

    $Template = Get-ADUser -Identity $CopyFrom -Properties StreetAddress, City, Title, PostalCode, Office, Department, Manager

    New-ADUser -Name $CopyTo.Name -UserPrincipalName $CopyTo.UserPrincipalName -GivenName $CopyTo.GivenName -Surname $CopyTo.Surname -SamAccountName $CopyTo.SamAccountName -Instance $Template -DisplayName $CopyTo.DisplayName -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -ChangePasswordAtLogon $False -Enabled $True -Server $Server
    Get-ADPrincipalGroupMembership $Template.SAMAccountName -Server $Server | ForEach-Object { Add-AdGroupMember -Identity $_.Name -Members $CopyTo.SamAccountName -Server $Server }
}