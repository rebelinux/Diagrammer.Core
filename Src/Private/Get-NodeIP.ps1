function Get-NodeIP {
    <#
    .SYNOPSIS
        Used by Diagrammer to translate node name to an network ip address type object.
    .DESCRIPTION
    .NOTES
        Version:        0.1.1
        Author:         Jonathan Colon
    .EXAMPLE
    .LINK
    #>
    param(
        [string]$Hostname
    )
    process {
        try {
            try {
                if ("InterNetwork" -in [System.Net.Dns]::GetHostAddresses($Hostname).AddressFamily) {
                    $IPADDR = ([System.Net.Dns]::GetHostAddresses($Hostname) | Where-Object { $_.AddressFamily -eq 'InterNetwork' }).IPAddressToString
                } elseif ("InterNetworkV6" -in [System.Net.Dns]::GetHostAddresses($Hostname).AddressFamily) {
                    $IPADDR = ([System.Net.Dns]::GetHostAddresses($Hostname) | Where-Object { $_.AddressFamily -eq 'InterNetworkV6' }).IPAddressToString
                } else {
                    $IPADDR = 127.0.0.1
                }
            } catch { $null }
            $NodeIP = Switch ([string]::IsNullOrEmpty($IPADDR)) {
                $true { 'Unknown' }
                $false { $IPADDR }
                default { $Hostname }
            }
        } catch {
            $_
        }

        return $NodeIP
    }
}