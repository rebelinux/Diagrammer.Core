function Add-WatermarkToImage {
    <#
    .SYNOPSIS
        Used to add a watermark text to Image
    .DESCRIPTION
        Takes a string and add it as an 45 degree watermakr to the provided Image file.
    .Example

        Add-WatermarkToImage ImageInput "c:\Image.png" DestinationPath "c:\Image_Edited.png" -WaterMarkText "Zen PR Solutions" -FontName 'Arial' -FontSize 20 -FontColor 'Red'

    .NOTES
        Version:        0.1.8
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
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
            Mandatory = $true,
            HelpMessage = 'Please provide the complete filepath to export the diagram'
        )]
        [string] $DestinationPath,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the text to transform'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $WaterMarkText,

        [string] $FontName = 'Arial',

        [int] $FontSize = 180,

        [System.Drawing.Color] $FontColor = 'Red',

        [int] $FontOpacity = 20
    )

    begin {
        # Initialize .net assemblies
        Add-Type -AssemblyName System.Windows.Forms
    }

    process {

        $ImageName = Get-ChildItem -Path $ImageInput
        # Teporary Image file name
        $FileName = $ImageName.BaseName + "_WaterMark" + $ImageName.Extension

        # Get the image from the ImageInput path
        $Bitmap = [System.Drawing.Image]::FromFile($ImageName.FullName)

        # Teporary Image file path
        $TempImageOutput = Join-Path -Path ([system.io.path]::GetTempPath()) -ChildPath $FileName

        # Initialize the font properties and brush
        $FontType = [System.Drawing.Font]::new($FontName, $FontSize, [System.Drawing.FontStyle]::Italic, [System.Drawing.GraphicsUnit]::Pixel, [System.Drawing.GraphicsUnit]::Bold)
        $FontColor = [System.Drawing.Color]::FromArgb($FontOpacity, $FontColor)
        $SolidBrush = [System.Drawing.SolidBrush]::new($FontColor)

        If ($Bitmap, $FontType, $FontColor, $SolidBrush) {

            # Get the center of the image
            $Grid = [System.Drawing.Point]::new($Bitmap.Width / 2, $Bitmap.Height / 2)
            $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)

            # Set the properties to allow the text to be centered
            $StringFormat = [System.Drawing.StringFormat]::new()
            $StringFormat.Alignment = [System.Drawing.StringAlignment]::Center
            $StringFormat.LineAlignment = [System.Drawing.StringAlignment]::Center
            $StringFormat.FormatFlags = [System.Drawing.StringFormatFlags]::MeasureTrailingSpaces

            # Get the center of the image used to rotate the text in a -45 angle
            $Graphics.TranslateTransform($Bitmap.Width / 2, $Bitmap.Height / 2)
            $Graphics.RotateTransform(-45)

            # Apply the properties to the Bitmap
            $Graphics.DrawString($WaterMarkText, $FontType, $SolidBrush, - ($Grid.Width / 2), - ($Grid.Height / 2), $StringFormat)
            # Destroy the graphics object
            $Graphics.Dispose()

        } else {
            Write-Information "Unable to add watermark to image!"
        }
    }

    end {
        try {
            # Save the Image to path define in $ImageOutputFile
            $Bitmap.Save($TempImageOutput)
            # Destroy the Bitmap object
            $Bitmap.Dispose()

            if ($TempImageOutput) {
                Write-Verbose "Successfully added watermark text to $ImageInput image."
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

        } catch {
            $PSCmdlet.ThrowTerminatingError($PSitem)
        }
    }
}