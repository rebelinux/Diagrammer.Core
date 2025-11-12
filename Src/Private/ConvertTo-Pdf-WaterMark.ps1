function ConvertTo-Pdf-WaterMark {
    <#
    .SYNOPSIS
        Function to export diagram to pdf format.
    .DESCRIPTION
        Export a diagram in PDF/PNG/SVG formats using PSgraph.
    .NOTES
        Version:        0.2.34
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux
    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>
    [CmdletBinding()]
    [OutputType([String])]
    param
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
            HelpMessage = 'Please provide the path to the image output file'
        )]
        [ValidateScript({
                $parentPath = Split-Path -Path $_ -Parent
                if (-not ($parentPath | Test-Path) ) {
                    throw "Folder does not exist"
                }
                return $true
            })]
        [String]$DestinationPath
    )
    process {
        try {
            Write-Verbose -Message "Trying to convert $($ImageInput.Name) object to PDF format. Destination Path: $DestinationPath."
            switch ($PSVersionTable.PSEdition) {
                'Core' {
                    # Net 9.0 assembly call
                    [Diagrammer.ConvertImageToPDF]::ConvertPngToPdf($ImageInput.FullName, $DestinationPath)
                }
                'Desktop' {
                    # Net 4.8 assembly call
                    [DiaConvertImageToPDF.ConvertImageToPDF]::ConvertPngToPdf($ImageInput.FullName, $DestinationPath)
                }
                Default {
                    # Net 4.8 assembly call (Fucking shit)
                    [DiaConvertImageToPDF.ConvertImageToPDF]::ConvertPngToPdf($ImageInput.FullName, $DestinationPath)
                }
            }

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