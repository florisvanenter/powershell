<#
    .SYNOPSIS
        Powershell module for MS Graph requests
    .DESCRIPTION
        Perform requests to the MS Graph API to prevent repetition of code
    .LINK
        https://github.com/florisvanenter/powershell.git
    .NOTES
        Be aware of the path of the module because in this folder it is called within the repository instead of standard module paths
#>

<#
    .SYNOPSIS
        Execute a GET request to an URI and refactor the response
    .DESCRIPTION
        Invoke a webrequest to an URI as GET and rework the JSON response to a collection
    .PARAMETER Uri
        The URL needed to get the specific resource in MS Graph
    .PARAMETER Headers
        The headers needed to at least authenticate and perhaps more
#>
Function Get-MSGraphGetResponse {

    param (
        $Uri,
        $Headers
    )

    process {
        $Response = @()
        $Response += Invoke-RestMethod -Uri $Uri -Method 'Get' -Headers $Headers
        $i = 0
    
        While ($i -lt 3) {
    
            If ($Response[$i].'@odata.nextLink') {
                $Uri = $Response[$i].'@odata.nextLink'
                $Response += Invoke-RestMethod -Uri $Uri -Method 'Get' -Headers $Headers
                $i++
            } Else {
                Break
            }
    
        }
    
        $Result = @()
        $Response | ForEach-Object -Process { $Result += $_.Value }
    
        Return $Result
    }

}

<#
    .SYNOPSIS
        Retrieve token for MS Graph activities
    .DESCRIPTION
        Retrieves a token for MS Graph in string or header if necessairy.
    .PARAMETER Id
        The client id of the application registered in Azure AD
    .PARAMETER Secret
        The client secret of the application registered in Azure AD
    .PARAMETER AsHeader
        A switch which converts the output to an header formatted response
    .NOTES
        https://docs.microsoft.com/en-us/graph/auth-v2-user
#>
Function Get-MSGraphToken {

    param (
        [String] $Id,
        [String] $Secret,
        [Switch] $AsHeader
    )

    process {
        
        $TokenUri = 'https://login.microsoftonline.com/d36c9c62-fd69-4ae5-a898-77fd7c8b840c/oauth2/v2.0/token'
        $HeadersForToken = @{
            'Accept'       = 'application/json'
            'Host'         = 'login.microsoftonline.com'
            'Content-Type' = 'application/x-www-form-urlencoded'
        }
        $Token = Invoke-RestMethod -Uri $TokenUri -Method 'POST' -Headers $HeadersForToken -Body "client_id=$Id&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&client_secret=$Secret&grant_type=client_credentials"
    
        If ($AsHeader) {
    
            Return @{
                'Authorization' = $Token.access_token
                'Content-Type'  = 'application/json'
            }
    
        } Else {
            Return $Token.access_token
        }

    }

}