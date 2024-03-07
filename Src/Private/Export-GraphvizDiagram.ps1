function Export-GraphvizDiagram {
    <#
    .SYNOPSIS
        Function to export diagram to expecified format.
    .DESCRIPTION
        Export a diagram in PDF/PNG/SVG formats using PSgraph.
    .NOTES
        Version:        0.1.8
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
            HelpMessage = 'Please provide the graphviz dot object'
        )]
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
            Position = 6,
            Mandatory = $false,
            HelpMessage = 'Allow to rotate the diagram output image. valid rotation degree (90, 180, 270)'
        )]
        [ValidateSet(0, 90, 180, 270)]
        [int] $Rotate,
        [Parameter(
            Position = 7,
            Mandatory = $false,
            HelpMessage = 'Allow to add a watermark to the output image (Not supported in svg format)'
        )]
        [string] $WaterMark,
        [Parameter(
            Position = 8,
            Mandatory = $false,
            HelpMessage = 'Allow to specified the color used for the watermark text'
        )]
        [string] $WaterMarkColor = 'Red'
    )

    process {
        if ($ErrorDebug) {
            $GraphObj
        } else {

            # Setup all paths required for script to run
            $script:RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
            $script:GraphvizPath = Join-Path $RootPath 'Graphviz\bin\dot.exe'


            # If Filename parameter is not specified, set filename to the Output.$OutputFormat
            if (!$Filename) {
                if ($Format -ne "base64") {
                    $Filename = "Output.$Format"
                } else { $Filename = "Output.png" }
            }
            Try {
                $DestinationPath = Join-Path -Path $OutputFolderPath -ChildPath $FileName

                if ($Format -eq "svg") {
                    if ($WaterMark) {
                        Write-Verbose "WaterMark option is not supported with the svg format."
                    }
                    if ($Rotate) {
                        Write-Verbose "Rotate option is not supported with the svg format."
                    }
                    ConvertTo-Svg -GraphObj $GraphObj -DestinationPath $DestinationPath
                } elseif ($Format -eq "dot") {
                    if ($WaterMark) {
                        Write-Verbose "WaterMark option is not supported with the dot format."
                    }
                    if ($Rotate) {
                        Write-Verbose "Rotate option is not supported with the dot format."
                    }
                    ConvertTo-Dot -GraphObj $GraphObj -DestinationPath $DestinationPath
                } elseif ($Format -eq "pdf") {
                    if ($WaterMark) {
                        Write-Verbose "WaterMark option is not supported with the pdf format."
                    }
                    if ($Rotate) {
                        Write-Verbose "Rotate option is not supported with the pdf format."
                    }
                    ConvertTo-pdf -GraphObj $GraphObj -DestinationPath $DestinationPath
                } else {
                    # Always convert to PNG format before edit output image.
                    try {
                        $TempOutPut = Join-Path -Path ([system.io.path]::GetTempPath()) -ChildPath "TempOutPut.png"
                        $Document = ConvertTo-Png -GraphObj $GraphObj -DestinationPath $TempOutPut
                    } catch {
                        Write-Verbose "Unable to convert Graphviz object to PNG format. Path: $TempOutPut"
                        Write-Verbose $($_.Exception.Message)
                    }

                    if ($Rotate) {
                        ConvertTo-RotateImage -ImageInput $Document.FullName -DestinationPath $DestinationPath -Angle $Rotate
                    }

                    if ($WaterMark) {
                        if ($Rotate) {

                            $ImageName = $Document
                            # Teporary Image file name
                            $FileName = $ImageName.BaseName + "_Rotated" + $ImageName.Extension

                            # Teporary Image file path
                            $TempImageOutput = Join-Path -Path ([system.io.path]::GetTempPath()) -ChildPath $FileName

                            Add-WatermarkToImage -ImageInput $TempImageOutput -DestinationPath $DestinationPath -WaterMarkText $WaterMark -FontColor $WaterMarkColor

                        } else {
                            Add-WatermarkToImage -ImageInput $Document.FullName -DestinationPath $DestinationPath -WaterMarkText $WaterMark -FontColor $WaterMarkColor
                        }
                    }
                }

                if ($Format -eq "base64") {
                    ConvertTo-Base64 -ImageInput $Document
                } elseif ($Format -eq "png") {
                    if ($Rotate -or $WaterMark) {
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


    }
    end {}
}