function Test-Image {
    <#
    .SYNOPSIS
        Used by Diagrammer to validate supported logo image extension.
    .DESCRIPTION
    .NOTES
        Version:        0.1.1
        Author:         Doctor Scripto
    .EXAMPLE
        Test-Image -Path "C:\Users\jocolon\logo.png"
    .LINK
        https://devblogs.microsoft.com/scripting/psimaging-part-1-test-image/
    #>

    [CmdletBinding()]
    param(

        [parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('PSPath')]
        $Path
    )

    PROCESS {
        $knownImageExtensions = @( ".jpeg", ".jpg", ".png" )
        $extension = [System.IO.Path]::GetExtension($Path)
        return $knownImageExtensions -contains $extension.ToLower()
    }
}