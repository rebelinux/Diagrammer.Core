function Add-WatermarkToImage {
    <#
    .SYNOPSIS
        Used to add a watermark text to Image
    .DESCRIPTION
        Takes a string and add it as an 45 degree watermakr to the provided Image file.
    .Example

        Add-WatermarkToImage -ImageInputFile "c:\Image.png" -ImageOutputFile "c:\Image_Edited.png" -WaterMarkText "Zen PR Solutions" -FontName 'Arial' -FontSize 20 -FontColor 'Red'

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
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the image file'
        )]
        [ValidateScript( {
                if (Test-Path -Path $_) {
                    $true
                } else {
                    throw "File $_ not found!"
                }
            })]
        [string] $ImageInputFile,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the image base64 string'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $Base64Input,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the path for the outpu image file'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $ImageOutputFile,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the text to transform'
        )]
        [ValidateNotNullOrEmpty()]

        [string] $WaterMarkText,

        [string] $FontName = 'Arial',

        [int] $FontSize = -20,

        [System.Drawing.Color] $FontColor = 'Red',

        [int] $FontOpacity = 100
    )

    begin {
        # Initialize .net assemblies
        Add-Type -AssemblyName System.Windows.Forms

        # Validate mandatory parameters
        if ((!$PSBoundParameters.ContainsKey('ImageInputFile')) -and (!$PSBoundParameters.ContainsKey('Base64Input'))) {
            throw "Error: Please provide a image path or a base64 string to process."
        }
    }

    process {
        # if parameter Base64Input specified convert the string to a byte array the load it as a Bitmap.
        # Else get the image from the ImageInputFile path
        if ($PSBoundParameters.ContainsKey('Base64Input')) {

            $ImageByte = New-Object System.IO.MemoryStream(, [convert]::FromBase64String($Base64Input))
            if ($ImageByte) {
                $Bitmap = [System.Drawing.Image]::FromStream($ImageByte)
            } else {
                throw "Unable to convert base64 string!"
            }

        } else {
            $Bitmap = [System.Drawing.Image]::FromFile($ImageInputFile)
        }

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

            $Bitmap.Save($ImageOutputFile)

        } else {
            Write-Information "Unable to add watermark to image!"
        }
    }

    end {
        # Destroy the Bitmap object
        $Bitmap.Dispose()
    }
}