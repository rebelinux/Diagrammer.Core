function Out-Diagram {
    <#
    .SYNOPSIS
        Function to export diagram to expecified format.
    .DESCRIPTION
        Build a diagram of the configuration of Diagrammer.AD in PDF/PNG/SVG formats using Psgraph.
    .NOTES
        Version:        0.1.1
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
            Mandatory = $false,
            HelpMessage = 'Allow to rotate the diagram output image. valid rotation degree (90, 180)'
        )]
        [int]$Rotate,
        [Parameter(
            Position = 3,
            Mandatory = $true,
            HelpMessage = 'Set the output format of the generated Graphviz diagram'
        )]
        [Array]$Format,
        [Parameter(
            Position = 3,
            Mandatory = $false,
            HelpMessage = 'Set the output filename of the generated Graphviz diagram'
        )]
        [String]$Filename,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the diagram output file'
        )]
        [string] $OutputFolderPath
    )
    process {
        if ($ErrorDebug) {
            $GraphObj
        } else {

            # Setup all paths required for script to run
            $script:RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
            $script:GraphvizPath = Join-Path $RootPath 'Graphviz\bin\dot.exe'

            # If Filename parameter is not specified, set filename to the Output.$OutputFormat
            foreach ($OutputFormat in $Format) {
                if ($Filename) {
                    Try {
                        if ($OutputFormat -ne "base64") {
                            if ($OutputFormat -ne "svg") {
                                $Document = Export-PSGraph -Source $GraphObj -DestinationPath "$($OutputFolderPath)$($FileName)" -OutputFormat $OutputFormat -GraphVizPath $GraphvizPath
                                Write-ColorOutput -Color green  "Diagram '$FileName' has been saved to '$OutputFolderPath'."
                            } else {
                                $Document = Export-PSGraph -Source $GraphObj -DestinationPath "$($OutputFolderPath)$($FileName)" -OutputFormat $OutputFormat -GraphVizPath $GraphvizPath
                                #Fix icon path issue with svg output
                                $images = Select-String -Path $($Document.fullname) -Pattern '<image xlink:href=".*png".*>' -AllMatches
                                foreach ($match in $images) {
                                    $matchFound = $match -Match '"(.*png)"'
                                    if ($matchFound -eq $false) {
                                        continue
                                    }
                                    $iconName = $Matches.Item(1)
                                    $iconNamePath = "$IconPath\$($Matches.Item(1))"
                                    $iconContents = Get-Content $iconNamePath -Encoding byte
                                    $iconEncoded = [convert]::ToBase64String($iconContents)
                                    ((Get-Content -Path $($Document.fullname) -Raw) -Replace $iconName, "data:image/png;base64,$($iconEncoded)") | Set-Content -Path $($Document.fullname)
                                }
                                if ($Document) {
                                    Write-ColorOutput -Color green "Diagram '$FileName' has been saved to '$OutputFolderPath'."
                                } else {
                                    Write-ColorOutput -Color red  "Unable to save Diagram '$File' to '$OutputFolderPath'."
                                }

                            }
                        } else {
                            $Document = Export-PSGraph -Source $GraphObj -DestinationPath "$($OutputFolderPath)$($FileName)" -OutputFormat 'png' -GraphVizPath $GraphvizPath
                            if ($Document) {
                                # Code used to allow rotating image!
                                if ($Rotate) {
                                    Add-Type -AssemblyName System.Windows.Forms
                                    $RotatedIMG = New-Object System.Drawing.Bitmap $Document.FullName
                                    $RotatedIMG.RotateFlip("Rotate$($Rotate)FlipNone")
                                    $RotatedIMG.Save($Document.FullName, "png")
                                    if ($RotatedIMG) {
                                        $Base64 = [convert]::ToBase64String((Get-Content $Document -Encoding byte))
                                        if ($Base64) {
                                            Remove-Item -Path $Document.FullName
                                            $Base64
                                        } else { Remove-Item -Path $Document.FullName }
                                    }
                                } else {
                                    # Code used to output image to base64 format
                                    $Base64 = [convert]::ToBase64String((Get-Content $Document -Encoding byte))
                                    if ($Base64) {
                                        Remove-Item -Path $Document.FullName
                                        $Base64
                                    } else { Remove-Item -Path $Document.FullName }

                                }
                            }
                        }
                    } catch {
                        $Err = $_
                        Write-Error $Err
                    }
                } elseif (!$Filename) {
                    if ($OutputFormat -ne "base64") {
                        $File = "Output.$OutputFormat"
                    } else { $File = "Output.png" }
                    Try {
                        if ($OutputFormat -ne "base64") {
                            if ($OutputFormat -ne "svg") {
                                $Document = Export-PSGraph -Source $GraphObj -DestinationPath "$($OutputFolderPath)$($File)" -OutputFormat $OutputFormat -GraphVizPath $GraphvizPath
                                Write-ColorOutput -Color green  "Diagram '$File' has been saved to '$OutputFolderPath'."
                            } else {
                                $Document = Export-PSGraph -Source $GraphObj -DestinationPath "$($OutputFolderPath)$($File)" -OutputFormat $OutputFormat -GraphVizPath $GraphvizPath
                                $images = Select-String -Path $($Document.fullname) -Pattern '<image xlink:href=".*png".*>' -AllMatches
                                foreach ($match in $images) {
                                    $matchFound = $match -Match '"(.*png)"'
                                    if ($matchFound -eq $false) {
                                        continue
                                    }
                                    $iconName = $Matches.Item(1)
                                    $iconNamePath = "$IconPath\$($Matches.Item(1))"
                                    $iconContents = Get-Content $iconNamePath -Encoding byte
                                    $iconEncoded = [convert]::ToBase64String($iconContents)
                                    ((Get-Content -Path $($Document.fullname) -Raw) -Replace $iconName, "data:image/png;base64,$($iconEncoded)") | Set-Content -Path $($Document.fullname)
                                }
                                if ($Document) {
                                    Write-ColorOutput -Color green  "Diagram '$File' has been saved to '$OutputFolderPath'."
                                } else {
                                    Write-ColorOutput -Color red  "Unable to save Diagram '$File' to '$OutputFolderPath'."
                                }
                            }
                        } else {
                            $Document = Export-PSGraph -Source $GraphObj -DestinationPath "$($OutputFolderPath)$($File)" -OutputFormat 'png' -GraphVizPath $GraphvizPath
                            if ($Document) {
                                # Code used to allow rotating image!
                                if ($Rotate) {
                                    Add-Type -AssemblyName System.Windows.Forms
                                    $RotatedIMG = New-Object System.Drawing.Bitmap $Document.FullName
                                    $RotatedIMG.RotateFlip("Rotate$($Rotate)FlipNone")
                                    $RotatedIMG.Save($Document.FullName, "png")
                                    if ($RotatedIMG) {
                                        $Base64 = [convert]::ToBase64String((Get-Content $Document -Encoding byte))
                                        if ($Base64) {
                                            Remove-Item -Path $Document.FullName
                                            $Base64
                                        } else { Remove-Item -Path $Document.FullName }
                                    }
                                } else {
                                    # Code used to output image to base64 format
                                    $Base64 = [convert]::ToBase64String((Get-Content $Document -Encoding byte))
                                    if ($Base64) {
                                        Remove-Item -Path $Document.FullName
                                        $Base64
                                    } else { Remove-Item -Path $Document.FullName }
                                }
                            }
                        }
                    } catch {
                        $Err = $_
                        Write-Error $Err
                    }
                }
            }
        }
    }
    end {

    }
}