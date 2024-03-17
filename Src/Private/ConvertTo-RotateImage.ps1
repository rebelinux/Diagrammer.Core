function ConvertTo-RotateImage {
    <#
    .SYNOPSIS
        Funtion to rotate image.
    .DESCRIPTION
        Rotate image to 90, 180 or 270 angle.
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
        Add-Type -AssemblyName System.Windows.Forms
    }

    process {

        $ImageName = Get-ChildItem -Path $ImageInput
        $FileName = $ImageName.BaseName + "_Rotated" + $ImageName.Extension

        $TempImageOutput = Join-Path -Path ([system.io.path]::GetTempPath()) -ChildPath $FileName

        # Load image from path as bitmap
        $RotatedIMG = [System.Drawing.image]::FromFile($ImageName.FullName)

        if ($RotatedIMG -and $TempImageOutput) {
            # Rotate image to specified angle
            $RotatedIMG.rotateflip("Rotate$($Angle)FlipNone")
            # Save/Replace imge to original path
            $RotatedIMG.Save($TempImageOutput)

            $RotatedIMG.Dispose()

            if ($TempImageOutput) {
                Write-Verbose "Successfully rotated $ImageInput image."
                if ($PSBoundParameters.ContainsKey('DestinationPath')) {
                    try {
                        Copy-Item -Path $TempImageOutput -Destination $DestinationPath
                        Write-Verbose "Successfully replaced $DestinationPath with $TempImageOutput rotated image."
                    } catch {
                        Write-Verbose "Unable to replace $DestinationPath rotated image to $TempImageOutput diagram."
                        Write-Verbose $($_.Exception.Message)
                    }
                } else {
                    Write-Verbose "Successfully rotated $ImageInput diagram."
                    Get-ChildItem -Path $TempImageOutput
                }
            }
        }
    }
    end {}
}