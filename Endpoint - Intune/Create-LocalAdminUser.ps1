<#
    .SYNOPSIS
    Create a local admin on an Intune laptop
    .DESCRIPTION
    This script creates a local admin on an Intune device
    .INPUTS
    Nothing, this script does not have any kind of input
    .OUTPUTS
    Nothing, it writes a script log to 'C:\ProgramData\PSH_Transcripts\scriptname'
    .EXAMPLE
    C:\PS> checkBiosMail.ps1
#>

param (

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    $User,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    $Password
    
)

begin {
    $TranscriptPath = 'C:\ProgramData\PSH_Transcripts'
    If (-Not (Test-Path -Path $TranscriptPath)) {
        New-Item $TranscriptPath -ItemType Directory
    }
    Start-Transcript -Path "$TranscriptPath\Create-LocalAdminUser.ps1.txt" -Append
}

process {
    Install-Module -Name localaccount -Force -ErrorAction SilentlyContinue
    Import-Module -Name localaccount -Force -ErrorAction SilentlyContinue
    
    $Password = ConvertTo-SecureString -String $Password -AsPlainText -Force
    
    Get-LocalUser | Where-Object Description -EQ 'Local Admin created by script' -ErrorAction SilentlyContinue | Remove-LocalUser -ErrorAction SilentlyContinue
    New-LocalUser -AccountNeverExpires -Description 'Local Admin created by script' -Name $User -Password $Password
    Add-LocalGroupMember -Group 'Administrators' -Member $User
}

end {
    Stop-Transcript
}
