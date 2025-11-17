function Add-WatermarkToImage {
    <#
    .SYNOPSIS
        Used to add a watermark text to Image
    .DESCRIPTION
        Takes a string and add it as an 45 degree watermakr to the provided Image file.
    .Example

        Add-WatermarkToImage ImageInput "c:\Image.png" DestinationPath "c:\Image_Edited.png" -WaterMarkText "Zen PR Solutions" -FontName 'Arial' -FontSize 20 -FontColor 'Red'

    .NOTES
        Version:        0.2.35
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux
    .PARAMETER ImageInputFile
        The Image file Path (PNG, TIFF, JPEG, JPG)
    .PARAMETER Base64Input
        The image in base64 format
    .PARAMETER ImageOutputFile
        The path of the resulting edited image
    .PARAMETER WaterMarkText
        The text to be inserted to the image as a watermark
    .PARAMETER FontName
        The font name
    .PARAMETER FontSize
        The font size
    .PARAMETER FontColor
        The font color [System.Drawing.Color] type (Red, Blue, Yellow etc..)
    .PARAMETER FontOpacity
        The font color opacity level
    #>

    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the path to the image file path'
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
            Mandatory = $false,
            HelpMessage = 'Please provide the complete filepath to export the diagram'
        )]
        [string] $DestinationPath,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the text to transform'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $WaterMarkText,

        [Parameter(
            HelpMessage = 'Please provide the font name'
        )]
        [string] $FontName = 'Arial',

        [Parameter(
            HelpMessage = 'Please provide the font size'
        )]
        [int] $FontSize,

        [Parameter(
            HelpMessage = 'Please provide the font color'
        )]
        [System.Drawing.Color] $FontColor = 'Red',

        [Parameter(
            HelpMessage = 'Please provide the font opacity level'
        )]
        [float] $FontOpacity = 20
    )

    begin {
    }

    process {

        if (-not $tempFormat) {
            # Set the temporary image format to PNG
            $tempFormat = 'png'
        }
        # Temporary Image file path
        $TempImageOutput = Join-Path -Path ([system.io.path]::GetTempPath()) -ChildPath "$(Get-Random).$tempFormat"

        $ImageName = Get-ChildItem -Path $ImageInput

        # Temporary Image file name
        $FileName = $ImageName.BaseName + "_WaterMark" + $ImageName.Extension

        try {
            if ($PSVersionTable.Platform -eq 'Unix') {
                $script:RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

                $FontPath = Join-Path -Path $RootPath -ChildPath 'Tools/Fonts/ARIAL.TTF'

                $Null = [Diagrammer.ImageProcessor]::AddWatermarkToImage($ImageName.FullName, $WaterMarkText, $TempImageOutput, $FontSize, $FontColor, $FontName, ($FontOpacity / 100), $FontPath)
            } else {
                # Fallback to System.Drawing

                # Initialize .net assemblies
                Add-Type -AssemblyName System.Windows.Forms
                $Bitmap = [System.Drawing.Image]::FromFile($ImageName.FullName)

                if (-not $FontSize) {
                    $FontSize = (($Bitmap.Width + $Bitmap.Height) / 2) / $WaterMarkText.Length
                }

                $FontType = [System.Drawing.Font]::new($FontName, $FontSize, [System.Drawing.FontStyle]::Italic, [System.Drawing.GraphicsUnit]::Pixel)
                $FontColor = [System.Drawing.Color]::FromArgb($FontOpacity, $FontColor)
                $SolidBrush = [System.Drawing.SolidBrush]::new($FontColor)

                $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)
                $StringFormat = [System.Drawing.StringFormat]::new()
                $StringFormat.Alignment = [System.Drawing.StringAlignment]::Center
                $StringFormat.LineAlignment = [System.Drawing.StringAlignment]::Center
                $StringFormat.FormatFlags = [System.Drawing.StringFormatFlags]::MeasureTrailingSpaces

                $Graphics.TranslateTransform($Bitmap.Width / 2, $Bitmap.Height / 2)
                $Graphics.RotateTransform(-45)
                $Graphics.DrawString($WaterMarkText, $FontType, $SolidBrush, 0, 0, $StringFormat)
                $Graphics.Dispose()

                # Save the Image to path define in $TempImageOutput
                $Bitmap.Save($TempImageOutput)
                # Destroy the Bitmap object
                $Bitmap.Dispose()
            }
        } catch {
            Write-Error "Failed to process image: $($_.Exception.Message)"
            return
        }

    }


    end {
        try {
            if ((Test-Path -Path $TempImageOutput)) {
                Write-Verbose -Message "Successfully added watermark text to $ImageInput image."
                if ($PSBoundParameters.ContainsKey('DestinationPath')) {
                    try {
                        if (Copy-Item -Path $TempImageOutput -Destination $DestinationPath) {
                            Write-Verbose -Message "Successfully replaced $DestinationPath with $TempImageOutput watermarked image."
                            if (Test-Path -Path $TempImageOutput) {
                                Remove-Item -Path $TempImageOutput -Force -ErrorAction SilentlyContinue
                            }
                        }
                    } catch {
                        Write-Verbose -Message "Unable to replace $DestinationPath watermark image to $TempImageOutput diagram."
                        Write-Debug -Message $($_.Exception.Message)
                        if (Test-Path -Path $TempImageOutput) {
                            Remove-Item -Path $TempImageOutput -Force -ErrorAction SilentlyContinue
                        }
                    }
                } else {
                    Write-Verbose -Message "Successfully watermark $ImageInput diagram."
                    Get-ChildItem -Path $TempImageOutput
                }
            }

        } catch {
            $PSCmdlet.ThrowTerminatingError($PSitem)
        }
    }
}