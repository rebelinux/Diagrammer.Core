function ConvertTo-Pdf-WaterMark {
    <#
    .SYNOPSIS
        Function to export diagram to pdf format.
    .DESCRIPTION
        Export a diagram in PDF/PNG/SVG formats using PSgraph.
    .NOTES
        Version:        0.2.12
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>
    [CmdletBinding()]
    [OutputType([String])]
    Param
    (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            HelpMessage = 'Please provide image file path'
        )]
        [ValidateScript( {
                if (Test-Path -Path $_) {
                    $true
                } else {
                    throw "File $_ not found!"
                }
            })]
        [System.IO.FileInfo] $ImageInput,
        [Parameter(
            Position = 1,
            Mandatory = $true,
            HelpMessage = 'Please provide the file path to export the diagram'
        )]
        [string] $DestinationPath
    )
    process {
        try {
            Write-Verbose -Message "Trying to convert $($ImageInput.Name) object to PDF format. Destination Path: $DestinationPath."
            & $ImageMagickPath\magick.exe -quality 100 $ImageInput $DestinationPath
        } catch {
            Write-Verbose -Message "Unable to convert $($ImageInput.Name) object to PDF format."
            Write-Debug -Message $($_.Exception.Message)
        }
        if (Test-Path -Path $DestinationPath) {
            Write-Verbose -Message "Successfully converted $($ImageInput.Name) object to PDF format. Saved Path: $DestinationPath."
            Get-ChildItem -Path $DestinationPath
        }
    }
    end {}
}