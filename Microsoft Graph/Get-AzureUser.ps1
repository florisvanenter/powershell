<#
    .SYNOPSIS
        Get the Users in AzureAD
    .DESCRIPTION
        Connect to MS Graph and retrieve users we have in Azure AD
    .PARAMETER Secret
        Secret needed to connect to Azure, belonging to registered app
    .PARAMETER Id
        Id of the registered app connecting to Azure
    .PARAMETER Version
        Beta or production. Beta is richer in functionality, v1.0 is more stable.
    .NOTES
        To keep the code clean, a module is used for repeated code.
#>

Param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $Secret,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $Id,

    [Parameter(Mandatory)]
    [ValidateSet('beta', 'v1.0')]
    [string] $Version = 'beta'
)

Begin {

    Import-Module .\Modules\MSGraph.psm1
    $Headers = Get-MSGraphToken -Secret $Secret -Id $Id -AsHeader

}

Process {

    $Users = Get-MSGraphGetResponse -Uri "https://graph.microsoft.com/$Version/users" -Header $Headers
    $Users

}
