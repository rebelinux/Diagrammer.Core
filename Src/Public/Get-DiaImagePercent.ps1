function Get-DiaImagePercent {
    <#
    .SYNOPSIS
        Used by As Built Report to get base64 image percentage calculated from image width.
    .DESCRIPTION
        This allow the diagram image to fit the report page margins
    .NOTES
        Version:        0.1.5
        Author:         Jonathan Colon
    .EXAMPLE
    .LINK
    #>
    [CmdletBinding()]
    [OutputType([System.Int32])]
    Param
    (
        [Parameter (
            Position = 0,
            Mandatory)]
        [string]
        $Graph
    )
    $Image_FromStream = [System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(, [convert]::FromBase64String($Graph))))
    If ($Image_FromStream.Width -gt 1500) {
        return 10
    } else {
        return 30
    }
} # end