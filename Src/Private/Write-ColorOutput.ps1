function Write-ColorOutput {
    <#
    .SYNOPSIS
        Used by Diagrammer to output colored text.
    .DESCRIPTION
    .NOTES
        Version:        0.1.1
        Author:         Prateek Singh
    .EXAMPLE
    .LINK
    #>

    [CmdletBinding()]
    [OutputType([String])]

    param
    (
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Color,

        [Parameter(
            Position = 1,
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String] $String
    )
    process {
        # save the current color
        $ForegroundColor = $Host.UI.RawUI.ForegroundColor

        # set the new color
        $Host.UI.RawUI.ForegroundColor = $Color

        # output
        if ($String) {
            Write-Output $String
        }

        # restore the original color
        $host.UI.RawUI.ForegroundColor = $ForegroundColor
    }
}