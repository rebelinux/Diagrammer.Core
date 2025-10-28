function ConvertTo-RotateImage {
    <#
    .SYNOPSIS
        Rotates an image file by a specified angle and optionally exports or deletes the rotated image.

    .DESCRIPTION
        The ConvertTo-RotateImage function loads an image from a given file path, rotates it by a specified angle (90, 180, or 270 degrees), and saves the rotated image to a temporary file.
        Optionally, the rotated image can be copied to a specified destination path and/or deleted after processing.
        This function is useful for manipulating diagram or image files within automation scripts.

    .PARAMETER ImageInput
        The file path of the image to be rotated. The file must exist.

    .PARAMETER Angle
        The angle in degrees to rotate the image. Valid values are 0, 90, 180, or 270.

    .PARAMETER DeleteImage
        If specified, deletes the temporary rotated image file after processing.

    .PARAMETER DestinationPath
        The file path where the rotated image should be exported. If not specified, the rotated image remains in the temporary location.

    .OUTPUTS
        [String] - The path to the rotated image file or output from Get-ChildItem if no destination is specified.

    .EXAMPLE
        ConvertTo-RotateImage -ImageInput "C:\Images\diagram.png" -Angle 90

        Rotates 'diagram.png' by 90 degrees and saves the rotated image to a temporary file.

    .EXAMPLE
        ConvertTo-RotateImage -ImageInput "C:\Images\diagram.png" -Angle 180 -DestinationPath "C:\Images\diagram_rotated.png" -DeleteImage

        Rotates 'diagram.png' by 180 degrees, copies the rotated image to 'diagram_rotated.png', and deletes the temporary rotated file.

    .NOTES
        Author: Jonathan Colon
        Version: 0.2.27
        GitHub: https://github.com/rebelinux/Diagrammer.Core

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
        [string] $ImageInput,
        [Parameter(
            Position = 1,
            Mandatory = $true,
            HelpMessage = 'Allow to rotate the diagram output image. valid rotation degree (90, 180, 270)'
        )]
        [ValidateSet(0, 90, 180, 270)]
        [int] $Angle,
        [Parameter(
            Position = 2,
            Mandatory = $false,
            HelpMessage = 'Delete the rotated image file'
        )]
        [switch] $DeleteImage,
        [Parameter(
            Position = 3,
            Mandatory = $false,
            HelpMessage = 'Please provide the complete filepath to export the diagram'
        )]
        [string] $DestinationPath
    )

    begin {
    }

    process {

        $ImageName = Get-ChildItem -Path $ImageInput
        $FileName = $ImageName.BaseName + "_Rotated" + $ImageName.Extension

        $TempImageOutput = Join-Path -Path ([system.io.path]::GetTempPath()) -ChildPath $FileName

        # Load image from path as bitmap
        if ($PSVersionTable.Platform -eq 'Unix') {
            if ($PSVersionTable.Platform -eq 'Unix') {
                Add-Type -Path "$ProjectRoot\Src\Bin\Assemblies\SixLabors.ImageSharp.dll"
            }
            $RotatedIMG = [ImageProcessor]::RotateImageFromFile($ImageName.FullName, $TempImageOutput, $Angle)
        } else {
            Add-Type -AssemblyName System.Windows.Forms
            $RotatedIMG = [System.Drawing.image]::FromFile($ImageName.FullName)
            # Rotate image to specified angle
            $RotatedIMG.RotateFlip("Rotate$($Angle)FlipNone")
            # Save/Replace imge to original path
            if ($RotatedIMG) {
                $RotatedIMG.Save($TempImageOutput)
                Write-Verbose -Message "Successfully rotated $ImageInput image."
                $RotatedIMG.Dispose()
            } else {
                throw "Unable to rotate $ImageInput image."
            }
        }

        if ($RotatedIMG -and (Test-Path -Path $TempImageOutput)) {

            if ($TempImageOutput) {
                Write-Verbose -Message "Successfully rotated $ImageInput image."
                if ($PSBoundParameters.ContainsKey('DestinationPath')) {
                    try {
                        Copy-Item -Path $TempImageOutput -Destination $DestinationPath
                        Write-Verbose -Message "Successfully replaced $DestinationPath with $TempImageOutput rotated image."
                    } catch {
                        Write-Verbose -Message "Unable to replace $DestinationPath rotated image to $TempImageOutput diagram."
                        Write-Debug -Message $($_.Exception.Message)
                    }
                    if ($DeleteImage) {
                        try {
                            Remove-Item -Path $TempImageOutput -Force
                            Write-Verbose -Message "Successfully deleted temporary rotated image file $TempImageOutput."
                        } catch {
                            Write-Verbose -Message "Unable to delete temporary rotated image file $TempImageOutput."
                            Write-Debug -Message $($_.Exception.Message)
                        }
                    }
                } else {
                    Write-Verbose -Message "Successfully rotated $ImageInput diagram."
                    Get-ChildItem -Path $TempImageOutput
                }
            }
        }
    }
    end {}
}