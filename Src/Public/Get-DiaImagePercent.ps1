function Get-DiaImagePercent {
    <#
    .SYNOPSIS
        Used by As Built Report to get base64 image percentage calculated from image width.
    .DESCRIPTION
        This allow the diagram image to fit the report page margins
    .NOTES
        Version:        0.1.7
        Author:         Jonathan Colon
    .EXAMPLE
    .LINK
    #>
    [CmdletBinding()]
    [OutputType([Hashtable])]
    Param
    (
        [Parameter (
            Position = 0,
            Mandatory)]
        [string]
        $GraphObj
    )
    $ImagePrty = @{}
    $Image_FromStream = [System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(, [convert]::FromBase64String($GraphObj))))

    $ImagePrty = @{
        'Width' = $Image_FromStream.Width
        'Height' = $Image_FromStream.Height
    }

    return $ImagePrty

} # end