function Export-Diagrammer {
    <#
    .SYNOPSIS
        Exports a diagram to a specified format.

    .DESCRIPTION
        The Export-Diagrammer function exports a diagram in PDF, PNG, SVG, or base64 formats using PSgraph.
        It supports adding watermarks to the output image (except for SVG and PDF formats) and allows for
        rotating the diagram output image.

    .PARAMETER GraphObj
        The Graphviz dot object to be exported. This parameter is mandatory.

    .PARAMETER ErrorDebug
        Enables error debugging. This parameter is optional.

    .PARAMETER Format
        The output format of the generated Graphviz diagram. Supported formats are PDF, PNG, SVG, and base64.
        This parameter is mandatory.

    .PARAMETER Filename
        The output filename of the generated Graphviz diagram. If not specified, the default filename is "Output"
        with the appropriate extension based on the format.

    .PARAMETER OutputFolderPath
        The path to the folder where the diagram output file will be saved. This parameter is optional but must
        be a valid path if provided.

    .PARAMETER IconPath
        The path to the icons directory, used for the SVG format. This parameter is optional but must be a valid
        path if provided.

    .PARAMETER WaterMarkText
        The text to be used as a watermark on the output image. This parameter is optional and not supported for
        SVG and PDF formats.

    .PARAMETER WaterMarkColor
        The color of the watermark text. The default color is 'Red'. This parameter is optional.

    .PARAMETER Rotate
        The degree to rotate the diagram output image. Valid rotation degrees are 0 and 90. This parameter is optional.

    .NOTES
        Version:        0.2.20
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        GitHub:         rebelinux

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
            HelpMessage = 'Please provide the graphviz dot object'
        )]
        [ValidateNotNullOrEmpty()]
        $GraphObj,
        [Parameter(
            Position = 1,
            Mandatory = $false,
            HelpMessage = 'Allow to enable error debugging'
        )]
        [bool]$ErrorDebug,
        [Parameter(
            Position = 2,
            Mandatory = $true,
            HelpMessage = 'Set the output format of the generated Graphviz diagram'
        )]
        [Array]$Format,
        [Parameter(
            Position = 3,
            Mandatory = $false,
            HelpMessage = 'Set the output filename of the generated Graphviz diagram'
        )]
        [string]$Filename,
        [Parameter(
            Position = 4,
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the diagram output file'
        )]
        [ValidateScript({
                if (-Not ($_ | Test-Path) ) {
                    throw "Folder does not exist"
                }
                return $true
            })]
        [System.IO.FileInfo] $OutputFolderPath,
        [Parameter(
            Position = 5,
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the icons directory (Used for SVG format)'
        )]
        [ValidateScript({
                if (-Not ($_ | Test-Path) ) {
                    throw "Folder does not exist"
                }
                return $true
            })]
        [System.IO.FileInfo] $IconPath,
        [Parameter(
            Position = 7,
            Mandatory = $false,
            HelpMessage = 'Allow to add a watermark to the output image (Not supported in svg format)'
        )]
        [string] $WaterMarkText,
        [Parameter(
            Position = 8,
            Mandatory = $false,
            HelpMessage = 'Allow to specified the color used for the watermark text'
        )]
        [string] $WaterMarkColor = 'Red',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to rotate the diagram output image. valid rotation degree (90, 180, 270)'
        )]
        [ValidateSet(0, 90)]
        [int] $Rotate = 0
    )

    process {
        # Setup all paths required for script to run
        $script:RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
        $script:GraphvizPath = Join-Path $RootPath 'Graphviz\bin\dot.exe'


        # If Filename parameter is not specified, set filename to the Output.$OutputFormat
        if (-Not $Filename) {
            if ($Format -ne "base64") {
                $Filename = "Output.$Format"
            } else { $Filename = "Output.png" }
        }
        Try {
            $DestinationPath = Join-Path -Path $OutputFolderPath -ChildPath $FileName

            if ($Format -eq "svg") {
                if ($WaterMarkText) {
                    Write-Verbose "WaterMark option is not supported with the svg format."
                }
                ConvertTo-Svg -GraphObj $GraphObj -DestinationPath $DestinationPath -Angle $Rotate
            } elseif ($Format -eq "jpg") {
                if ($WaterMarkText) {
                    Write-Verbose "WaterMark option is not supported with the dot format."
                }
                ConvertTo-Jpg -GraphObj $GraphObj -DestinationPath $DestinationPath
            } elseif ($Format -eq "dot") {
                if ($WaterMarkText) {
                    Write-Verbose "WaterMark option is not supported with the dot format."
                }
                ConvertTo-Dot -GraphObj $GraphObj -DestinationPath $DestinationPath
            } elseif ($Format -eq "pdf") {
                if ($WaterMarkText) {
                    Write-Verbose "WaterMark option is not supported with the pdf format."
                }
                ConvertTo-pdf -GraphObj $GraphObj -DestinationPath $DestinationPath
            } else {
                # Always convert to PNG format before edit output image.
                try {
                    $TempOutPut = Join-Path -Path ([system.io.path]::GetTempPath()) -ChildPath "TempOutPut.png"
                    $Document = ConvertTo-Png -GraphObj $GraphObj -DestinationPath $TempOutPut
                } catch {
                    Write-Verbose "Unable to convert Graphviz object to PNG format. Path: $TempOutPut"
                    Write-Debug $($_.Exception.Message)
                }


                if ($WaterMarkText) {
                    Add-WatermarkToImage -ImageInput $Document.FullName -DestinationPath $DestinationPath -WaterMarkText $WaterMarkText -FontColor $WaterMarkColor
                }
            }

            if ($Format -eq "base64") {
                ConvertTo-Base64 -ImageInput $Document
            } elseif ($Format -eq "png") {
                if ($WaterMarkText) {
                    if ($Document) {
                        Write-Verbose -Message "Deleting Temporary PNG file: $($Document.FullName)"
                        Remove-Item -Path $Document
                    }
                    Get-ChildItem -Path $DestinationPath
                } else {
                    Copy-Item -Path $Document.FullName -Destination $DestinationPath
                    if ($Document) {
                        Write-Verbose -Message "Deleting Temporary PNG file: $($Document.FullName)"
                        Remove-Item -Path $Document
                    }
                    Get-ChildItem -Path $DestinationPath
                }
            }

        } catch {
            if ($Document) {
                Remove-Item -Path $Document
            }
            $Err = $_
            Write-Error $Err
        }
    }
    end {}
}