function Resize-Image {
    <#
        .SYNOPSIS
            Resize an image
        .DESCRIPTION
            Resize an image based on a new given height or width or a single dimension and a maintain ratio flag.
            The execution of this CmdLet creates a new file named "OriginalName_resized" and maintains the original
            file extension
        .PARAMETER Width
            The new width of the image. Can be given alone with the MaintainRatio flag
        .PARAMETER Height
            The new height of the image. Can be given alone with the MaintainRatio flag
        .PARAMETER ImagePath
            The path to the image being resized
        .PARAMETER MaintainRatio
            Maintain the ratio of the image by setting either width or height. Setting both width and height and also this parameter results in an error
        .PARAMETER Percentage
        Resize the image *to* the size given in this parameter. It's imperative to know that this does not resize by the percentage but to the percentage of the image.
        .PARAMETER SmoothingMode
            Sets the smoothing mode. Default is HighQuality.
        .PARAMETER InterpolationMode
            Sets the interpolation mode. Default is HighQualityBicubic.
        .PARAMETER PixelOffsetMode
            Sets the pixel offset mode. Default is HighQuality.
        .EXAMPLE
            Resize-Image -Height 45 -Width 45 -ImagePath "Path/to/image.jpg"
        .EXAMPLE
            Resize-Image -Height 45 -MaintainRatio -ImagePath "Path/to/image.jpg"
        .EXAMPLE
            #Resize to 50% of the given image
            Resize-Image -Percentage 50 -ImagePath "Path/to/image.jpg"
        .NOTES
            Written By:
            Christopher Walker
    #>
    [CmdLetBinding(
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        ConfirmImpact = "Medium",
        DefaultParameterSetName = "Absolute"
    )]

    param (
        [Parameter(Mandatory = $True)]
        [ValidateScript({
                $_ | ForEach-Object {
                    Test-Path $_
                }
            })]
        [String[]]$ImagePath,
        [Parameter(
            Mandatory = $True,
            HelpMessage = 'Please provide the path to the image output file'
        )]
        [ValidateScript({
                if (-not ($_ | Test-Path) ) {
                    throw "Folder does not exist"
                }
                return $true
            })]
        [System.IO.FileInfo]$DestinationPath,
        [Parameter(Mandatory = $False)][Switch]$MaintainRatio,
        [Parameter(Mandatory = $False, ParameterSetName = "Absolute")][Int]$Height,
        [Parameter(Mandatory = $False, ParameterSetName = "Absolute")][Int]$Width,
        [Parameter(Mandatory = $False, ParameterSetName = "Percent")][Double]$Percentage,
        [Parameter(Mandatory = $False)][System.Drawing.Drawing2D.SmoothingMode]$SmoothingMode = "HighQuality",
        [Parameter(Mandatory = $False)][String]$NameModifier = "resized"
    )
    begin {
        if ($Width -and $Height -and $MaintainRatio) {
            throw "Absolute Width and Height cannot be given with the MaintainRatio parameter."
        }

        if (($Width -xor $Height) -and (-not $MaintainRatio)) {
            throw "MaintainRatio must be set with incomplete size parameters (Missing height or width without MaintainRatio)"
        }

        if ($Percentage -and $MaintainRatio) {
            Write-Warning -Message "The MaintainRatio flag while using the Percentage parameter does nothing"
        }
    }
    process {
        foreach ($Image in $ImagePath) {
            $Path = (Resolve-Path $Image).Path
            $Dot = $Path.LastIndexOf(".")

            #Add name modifier (OriginalName_{$NameModifier}.jpg)
            $OutputPath = $Path.Substring(0, $Dot) + "_" + $NameModifier + $Path.Substring($Dot, $Path.Length - $Dot)

            $OldImage = New-Object -TypeName System.Drawing.Bitmap -ArgumentList $Path
            # Grab these for use in calculations below.
            $OldHeight = $OldImage.Height
            $OldWidth = $OldImage.Width

            if ($MaintainRatio) {
                $OldHeight = $OldImage.Height
                $OldWidth = $OldImage.Width
                if ($Height) {
                    $Width = $OldWidth / $OldHeight * $Height
                }
                if ($Width) {
                    $Height = $OldHeight / $OldWidth * $Width
                }
            }

            if ($Percentage) {
                $Product = ($Percentage / 100)
                $Height = $OldHeight * $Product
                $Width = $OldWidth * $Product
            }

            $Bitmap = New-Object -TypeName System.Drawing.Bitmap -ArgumentList $Width, $Height
            $NewImage = [System.Drawing.Graphics]::FromImage($Bitmap)

            #Retrieving the best quality possible
            $NewImage.SmoothingMode = $SmoothingMode
            $NewImage.DrawImage($OldImage, $(New-Object -TypeName System.Drawing.Rectangle -ArgumentList 0, 0, $Width, $Height))

            if ($PSCmdlet.ShouldProcess("Resized image based on $Path", "save to $OutputPath")) {
                $Bitmap.Save($OutputPath)
            }

            $Bitmap.Dispose()
            $NewImage.Dispose()
            $OldImage.Dispose()

            if (Test-Path -Path $OutputPath) {
                if ($DestinationPath) {
                    Write-Verbose -Message "Successfully resized image. Path: $OutputPath."
                    Copy-Item -Path $OutputPath -Destination $DestinationPath -Force
                    if (Test-Path -Path (Join-Path -Path $DestinationPath -ChildPath (Split-Path -Path $OutputPath -Leaf))) {
                        Get-ChildItem -Path (Join-Path -Path $DestinationPath -ChildPath (Split-Path -Path $OutputPath -Leaf))
                    } else {
                        Write-Warning -Message "Failed to copy resized image to $DestinationPath"
                    }
                } else {
                    Write-Verbose -Message "Successfully resized image. Saved Path: $OutputPath."
                    Get-ChildItem -Path $OutputPath
                }
            }
        }
    }
}