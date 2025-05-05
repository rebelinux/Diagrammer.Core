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
Function Resize-Image() {
    [CmdLetBinding(
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        ConfirmImpact = "Medium",
        DefaultParameterSetName = "Absolute"
    )]
    Param (
        [Parameter(Mandatory = $True)]
        [ValidateScript({
                $_ | ForEach-Object {
                    Test-Path $_
                }
            })][String[]]$ImagePath,
        [Parameter(Mandatory = $False)][Switch]$MaintainRatio,
        [Parameter(Mandatory = $False, ParameterSetName = "Absolute")][Int]$Height,
        [Parameter(Mandatory = $False, ParameterSetName = "Absolute")][Int]$Width,
        [Parameter(Mandatory = $False, ParameterSetName = "Percent")][Double]$Percentage,
        [Parameter(Mandatory = $False)][System.Drawing.Drawing2D.SmoothingMode]$SmoothingMode = "HighQuality",
        [Parameter(Mandatory = $False)][System.Drawing.Drawing2D.InterpolationMode]$InterpolationMode = "HighQualityBicubic",
        [Parameter(Mandatory = $False)][System.Drawing.Drawing2D.PixelOffsetMode]$PixelOffsetMode = "HighQuality",
        [Parameter(Mandatory = $False)][String]$NameModifier = "resized"
    )
    Begin {
        If ($Width -and $Height -and $MaintainRatio) {
            Throw "Absolute Width and Height cannot be given with the MaintainRatio parameter."
        }

        If (($Width -xor $Height) -and (-not $MaintainRatio)) {
            Throw "MaintainRatio must be set with incomplete size parameters (Missing height or width without MaintainRatio)"
        }

        If ($Percentage -and $MaintainRatio) {
            Write-Warning -Message"The MaintainRatio flag while using the Percentage parameter does nothing"
        }
    }
    Process {
        ForEach ($Image in $ImagePath) {
            $Path = (Resolve-Path $Image).Path
            $Dot = $Path.LastIndexOf(".")

            #Add name modifier (OriginalName_{$NameModifier}.jpg)
            $OutputPath = $Path.Substring(0, $Dot) + "_" + $NameModifier + $Path.Substring($Dot, $Path.Length - $Dot)

            $OldImage = New-Object -TypeName System.Drawing.Bitmap -ArgumentList $Path
            # Grab these for use in calculations below.
            $OldHeight = $OldImage.Height
            $OldWidth = $OldImage.Width

            If ($MaintainRatio) {
                $OldHeight = $OldImage.Height
                $OldWidth = $OldImage.Width
                If ($Height) {
                    $Width = $OldWidth / $OldHeight * $Height
                }
                If ($Width) {
                    $Height = $OldHeight / $OldWidth * $Width
                }
            }

            If ($Percentage) {
                $Product = ($Percentage / 100)
                $Height = $OldHeight * $Product
                $Width = $OldWidth * $Product
            }

            $Bitmap = New-Object -TypeName System.Drawing.Bitmap -ArgumentList $Width, $Height
            $NewImage = [System.Drawing.Graphics]::FromImage($Bitmap)

            #Retrieving the best quality possible
            $NewImage.SmoothingMode = $SmoothingMode
            $NewImage.InterpolationMode = $InterpolationMode
            $NewImage.PixelOffsetMBitmapode = $PixelOffsetMode
            $NewImage.DrawImage($OldImage, $(New-Object -TypeName System.Drawing.Rectangle -ArgumentList 0, 0, $Width, $Height))

            If ($PSCmdlet.ShouldProcess("Resized image based on $Path", "save to $OutputPath")) {
                $Bitmap.Save($OutputPath)
            }

            $Bitmap.Dispose()
            $NewImage.Dispose()
            $OldImage.Dispose()
        }
    }
}