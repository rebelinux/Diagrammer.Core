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
        The path of the resulting edited image.
    .PARAMETER WaterMarkText
        The text to be inserted to the image as a watermark.
    .PARAMETER FontName
        The font name.
    .PARAMETER FontSize
        The font size.
    .PARAMETER FontColor
        The font color [System.Drawing.Color] type (Red, Blue, Yellow etc..)
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
        Add-Type -AssemblyName System.Windows.Forms

        if (-Not $PSBoundParameters.ContainsKey('Base64Input') -or -Not $PSBoundParameters.ContainsKey('Base64Input')) {
            throw "Error: Please provide a image path or a base64 string to process."
        }
    }

    process {

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

        $FontType = [System.Drawing.Font]::new($FontName, $FontSize, [System.Drawing.FontStyle]::Italic, [System.Drawing.GraphicsUnit]::Pixel, [System.Drawing.GraphicsUnit]::Bold)
        $FontColor = [System.Drawing.Color]::FromArgb($FontOpacity, $FontColor)
        $SolidBrush = [System.Drawing.SolidBrush]::new($FontColor)

        If ($Bitmap, $FontType, $FontColor, $SolidBrush) {

            $Grid = [System.Drawing.Point]::new($Bitmap.Width / 2, $Bitmap.Height / 2)
            $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)
            $StringFormat = [System.Drawing.StringFormat]::new()

            $StringFormat.Alignment = [System.Drawing.StringAlignment]::Center
            $StringFormat.LineAlignment = [System.Drawing.StringAlignment]::Center
            $StringFormat.FormatFlags = [System.Drawing.StringFormatFlags]::MeasureTrailingSpaces


            $Graphics.TranslateTransform($Bitmap.Width / 2, $Bitmap.Height / 2)
            $Graphics.RotateTransform(-45)

            $textSize = $Graphics.MeasureString($WaterMakerText, $FontType);

            $Graphics.DrawString($WaterMarkText, $FontType, $SolidBrush, - ($Grid.Width / 2), - ($Grid.Height / 2), $StringFormat)
            $Graphics.Dispose()

            $Bitmap.Save($ImageOutputFile)

        } else {
            Write-Information "Unable to add watermark to image!"
        }
    }

    end {
        $Bitmap.Dispose()
    }
}