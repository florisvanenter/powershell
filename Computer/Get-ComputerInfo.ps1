<#
    .SYNOPSIS
        Get information on computers
    .DESCRIPTION
        Use the CIM to retrieve information from specified computers
    .PARAMETER ComputerName
        Which computers, it can be an array
#>

param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string[]] $ComputerName

)

process {

    $Collection = @()

    ForEach ($Computer in $ComputerName) {

        if (Test-Connection -TargetName $Computer) {
            $Collection += [PSCustomObject]@{
                Name        = $Computer
                Online      = $true
                BIOS        = Invoke-Command -ComputerName $Computer -ScriptBlock { uGet-CimInstance -Query "SELECT * FROM Win32_BIOS" | Select-Object -ExpandProperty Name }
                OSName      = Invoke-Command -ComputerName $Computer -ScriptBlock { Get-CimInstance -Query 'SELECT * FROM Win32_OperatingSystem' | Select-Object -ExpandProperty Caption }
                OSVersion   = Invoke-Command -ComputerName $Computer -ScriptBlock { Get-CimInstance -Query 'SELECT * FROM Win32_OperatingSystem' | Select-Object -ExpandProperty Version }
                InstallDate = Invoke-Command -ComputerName $Computer -ScriptBlock { Get-CimInstance -Query 'SELECT * FROM Win32_OperatingSystem' | Select-Object -ExpandProperty InstallDate }
                IpAddresses = (Invoke-Command -ComputerName $Computer -ScriptBlock { Get-NetIpAddress | Where-Object IPv4Address -NE $Null } | Select-Object -ExpandProperty IPv4Address) -Join ','
                Memory      = Invoke-Command -ComputerName $Computer -ScriptBlock { (Get-CimInstance -Class 'CIM_PhysicalMemory' | Select-Object Capacity) / 1Gb }
            }

        } else {
            $Collection += [PSCustomObject]@{
                Name        = $Computer
                Online      = $false
                BIOS        = ''
                OSName      = ''
                OSVersion   = ''
                InstallDate = ''
                IpAddress   = ''
                Memory      = ''
            }
        }
    }

}