<#
    .SYNOPSIS
        Copy a user to a new user
    .DESCRIPTION
        Connect to Active Directory, and copy a user with all group memberships
    .PARAMETER CopyFrom
        SamAccountName of the user to be copied
    .PARAMETER Firstname
        Firstname of the
    .PARAMETER Password
        The password of the to be created user
    .PARAMETER Server
        The DNS name of the AD to resolve the domain controller
    .NOTES
        An parameter for server is used to be sure to connect to the right AD domain in case of UAT,PROD,etc
        Module ActiveDirectory needs to be installed
#>

param 
(

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $CopyFrom,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [String] $Firstname,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [String] $Lastname,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $Password,

    [ValidateNotNullOrEmpty()]
    [string] $Server

)

process {

    $Template = Get-ADUser -Identity $CopyFrom -Properties StreetAddress, City, Title, PostalCode, Office, Department, Manager

    $Options = @{
        Name                  = "$Firstname $Lastname"
        UserPrincipalName     = $("$Firstname $Lastname").replace(' ', '') + '@hessing.eu'
        GivenName             = $Firstname
        Surname               = $Lastname
        SamAccountName        = $("$Firstname $Lastname").replace(' ', '')
        Instance              = $Template
        DisplayName           = "$Firstname $Lastname"
        AccountPassword       = ConvertTo-SecureString $Password -AsPlainText -Force
        ChangePasswordAtLogon = $False
        Server                = $Server
        Enabled               = $True
    }

    New-ADUser @Options
    Get-ADPrincipalGroupMembership $Template.SAMAccountName -Server $Server | ForEach-Object { Add-AdGroupMember -Identity $_.Name -Members $CopyTo.SamAccountName -Server $Server }
}