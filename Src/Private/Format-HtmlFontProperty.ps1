function Format-HtmlFontProperty {
    <#
        .SYNOPSIS
            Specifies html font formatting options.

        .PARAMETER Text
            The text to be formatted.

        .PARAMETER FontSize
            The size of the font. Default is 12.

        .PARAMETER FontColor
            The color of the font. Default is 'black'.

        .PARAMETER FontBold
            Switch to make the font bold.

        .PARAMETER FontItalic
            Switch to make the font italic.

        .PARAMETER FontUnderline
            Switch to underline the font.
    #>
    param (
        [Parameter(
            Mandatory,
            HelpMessage = "The text to be formatted.")]
        [string]$Text,

        [Parameter(
            HelpMessage = "The size of the font. Default is 12."
        )]
        [int]$FontSize = 12,

        [Parameter(
            HelpMessage = "The color of the font. Default is 'black'."
        )]
        [string]$FontColor = 'black',

        [Parameter(
            HelpMessage = "Switch to make the font bold."
        )]
        [switch]$FontBold = $false,

        [Parameter(
            HelpMessage = "Switch to make the font italic."
        )]
        [switch]$FontItalic = $false,

        [Parameter(
            HelpMessage = "Switch to underline the font."
        )]
        [switch]$FontUnderline = $false,

        [Parameter(
            HelpMessage = "The font face to use. Default is 'Segoe Ui Black'."
        )]
        [string]$FontName = "Segoe Ui Black"
    )

    $styleTags = @()
    if ($FontBold) { $styleTags += 'B' }
    if ($FontItalic) { $styleTags += 'I' }
    if ($FontUnderline) { $styleTags += 'U' }

    $fontTagOpen = "<FONT FACE='$FontName' POINT-SIZE='$FontSize' COLOR='$FontColor'>"
    $fontTagClose = "</FONT>"

    $formattedText = $Text
    foreach ($tag in $styleTags) {
        $formattedText = "<$tag>$formattedText</$tag>"
    }

    return "$fontTagOpen$formattedText$fontTagClose"
}