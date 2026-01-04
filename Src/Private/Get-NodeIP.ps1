function Get-NodeIP {
    <#
    .SYNOPSIS
        Used by Diagrammer to translate node name to an network ip address type object.
    .DESCRIPTION
    .NOTES
        Version:        0.2.27
        Author:         Jonathan Colon
    .EXAMPLE
    .LINK
    #>
    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [string]$Hostname
    )
    process {
        try {
            try {
                if ('InterNetwork' -in [System.Net.Dns]::GetHostAddresses($Hostname).AddressFamily) {
                    $IPADDR = ([System.Net.Dns]::GetHostAddresses($Hostname) | Where-Object { $_.AddressFamily -eq 'InterNetwork' })[0].IPAddressToString
                } elseif ('InterNetworkV6' -in [System.Net.Dns]::GetHostAddresses($Hostname).AddressFamily) {
                    $IPADDR = ([System.Net.Dns]::GetHostAddresses($Hostname) | Where-Object { $_.AddressFamily -eq 'InterNetworkV6' })[0].IPAddressToString
                } else {
                    $IPADDR = $Null
                }
            } catch {
                Write-Verbose -Message "Unable to resolve Hostname Address: $Hostname"
                $IPADDR = $Null
            }
            $NodeIP = switch ([string]::IsNullOrEmpty($IPADDR)) {
                $true { 'Unknown' }
                $false { $IPADDR }
                default { $Hostname }
            }
        } catch {
            Write-Verbose -Message $_.Exception.Message
        }

        return $NodeIP
    }
}