function Add-DiaNodeText {
    <#
    .SYNOPSIS
        Generates an HTML representation of a text box for a diagram node.

    .DESCRIPTION
        The Add-DiaNodeText function creates an HTML representation of a text box for a diagram node.
        It supports customization of the text box's appearance, including border width, color, style, and font properties.
        The function also allows for debug mode, which highlights the text box for easier troubleshooting.

    .PARAMETER Name
        Specifies the name of the node to be illustrated. This is a required parameter.

    .PARAMETER IconDebug
        Enables debug mode for icons. When set to $true, the table border is highlighted in red to assist with visual debugging. Default is $false.

    .PARAMETER TableBorder
        Sets the width of the HTML table border in pixels. Default is 0 (no border).

    .PARAMETER TableBorderColor
        Specifies the color of the table border using a hex color code. Default is "#000000" (black).

    .PARAMETER TableBorderStyle
        Defines the style of the table border. Accepted values are: ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED.

    .PARAMETER FontColor
        Sets the color of the text within the text box using a hex color code. Default is "#000000" (black).

    .PARAMETER FontSize
        Specifies the font size of the text within the text box. Default is 12.

    .PARAMETER FontBold
        When set to $true, the text within the text box is rendered in bold. Default is $false.

    .PARAMETER FontItalic
        When set to $true, the text within the text box is rendered in italic. Default is $false.

    .PARAMETER FontUnderline
        When set to $true, the text within the text box is underlined. Default is $false.

    .PARAMETER Text
        The text content to be displayed within the text box. This is a required parameter.
        The text can include line breaks by using `\n` which will be converted to `<BR/>`.
        Example: "Line1\nLine2\nLine3" will render as:
        Line1
        Line2
        Line3

    .PARAMETER TableBackgroundColor
        Sets the background color of the text box using a hex color code. Default is "transparent".

    .PARAMETER TextAlign
        Specifies the alignment of the text within the text box. Accepted values are: Left, Right, Center, and Justify. Default is "Center".

    .PARAMETER GraphvizAttributes
        A hashtable of additional Graphviz attributes to apply to the node. This allows for further customization of the node's appearance.

    .PARAMETER NodeObject
        If specified, the function will return the node object instead of rendering it directly.

    .EXAMPLE
        Add-DiaNodeText -Name "Server1" -TableBorder 2 -TableBorderColor "#FF0000" -TableBorderStyle "SOLID" -Text "This is a test text box." -FontColor "#0000FF" -FontSize 14 -FontBold $true -TableBackgroundColor "#FFFF00" -NodeObject

        This command creates a text box node named "Server1" with a solid red border of 2 pixels, blue bold text of size 14, and a yellow background.
                    _________________
                    |               |
                    |   Text Box    |
                    |               |
                    |_______________|

    .NOTES
        Author: Jonathan Colon
        Version: 0.2.32
        Twitter: @jcolonfzenpr
        Github: rebelinux

    #>

    [CmdletBinding()]
    [OutputType([System.String])]

    param(

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the Node.'
        )]
        [string] $Name,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enables debug mode for icons, highlighting the table in red.'
        )]
        [Alias("DraftMode")]
        [bool] $IconDebug = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table border color'
        )]
        [string] $TableBorderColor = "#000000",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)'
        )]
        [ValidateSet("ROUNDED", "RADIAL", "SOLID", "INVISIBLE", "INVIS", "DOTTED", "DASHED")]
        [string] $TableBorderStyle,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the width of the html table border'
        )]
        [int] $TableBorder = 0,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'The text content to be displayed within the text box. This is a required parameter. The text can include line breaks by using `\n` which will be converted to `<BR/>`. Example: "Line1\nLine2\nLine3'
        )]
        [string] $Text,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the text to display inside the text box'
        )]
        [ValidateSet("Left", "Right", "Center")]
        [string] $TextAlign = "Center",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font color'
        )]
        [string] $FontColor = "#000000",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font size'
        )]
        [int] $FontSize = 12,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font bold'
        )]
        [switch] $FontBold,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font italic'
        )]
        [switch] $FontItalic,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font underline'
        )]
        [switch] $FontUnderline,

        [Parameter(
            HelpMessage = "The font face to use. Default is 'Segoe Ui'."
        )]
        [string]$FontName = "Segoe Ui",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the background color'
        )]
        [string] $TableBackgroundColor = "#FFFFFF",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional Graphviz attributes to add to the node (e.g., style = filled, color = lightgrey)'
        )]
        [hashtable] $GraphvizAttributes = @{},

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'If specified, the function will return the node object instead of rendering it directly.'
        )]
        [switch] $NodeObject
    )

    $Text = $Text -replace '\\n', '<BR/>'

    if ($TableBorder -gt 0 -and (-not $TableBorderStyle)) {
        throw "TableBorderStyle must be specified when TableBorder is used."
    } elseif (($TableBorderColor -ne '#000000') -and (-not $TableBorderStyle)) {
        throw "TableBorderStyle must be specified when TableBorderColor is used."
    } elseif ($TableBorderStyle -and ($TableBorder -eq 0)) {
        $TableBorder = 1
    }

    $FormattedText = Format-HtmlFontProperty -Text $Text -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName

    if ($IconDebug) {
        if ($NodeObject) {
            $HTML = "<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='{0}' ALIGN='{1}' colspan='1'>{2}</TD></TR></TABLE>" -f 'SOLID', $TextAlign, $FormattedText

            $JoinHash = Join-Hashtable -PrimaryHash @{label = $HTML; shape = 'plain'; fillcolor = 'transparent'; fontsize = 14 } -SecondaryHash $GraphvizAttributes -PreferSecondary

            Node -Name $Name -Attributes $JoinHash
        } else {
            "<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='{0}' ALIGN='{1}' colspan='1'>{2}</TD></TR></TABLE>" -f 'SOLID', $TextAlign, $FormattedText
        }
    } else {
        if ($NodeObject) {
            $HTML = if ($TableBorderStyle) {
                "<TABLE STYLE='{0}' bgcolor='{1}' border='{2}' color='{3}' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='{0}' ALIGN='{4}' colspan='1'>{5}</TD></TR></TABLE>" -f $TableBorderStyle, $TableBackgroundColor, $TableBorder, $TableBorderColor, $TextAlign, $FormattedText
            } else {
                "<TABLE border='{0}' color='{1}' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='{2}' colspan='1'>{3}</TD></TR></TABLE>" -f 0, $TableBorderColor, $TextAlign, $FormattedText
            }

            $JoinHash = Join-Hashtable -PrimaryHash @{label = $HTML; shape = 'plain'; fillcolor = 'transparent'; fontsize = 14 } -SecondaryHash $GraphvizAttributes -PreferSecondary

            Node -Name $Name -Attributes $JoinHash
        } else {
            if ($TableBorderStyle) {
                "<TABLE STYLE='{0}' bgcolor='{1}' border='{2}' color='{3}' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='{0}' ALIGN='{4}' colspan='1'>{5}</TD></TR></TABLE>" -f $TableBorderStyle, $TableBackgroundColor, $TableBorder, $TableBorderColor, $TextAlign, $FormattedText
            } else {
                "<TABLE bgcolor='{0}' border='{1}' color='{2}' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='{3}' colspan='1'>{4}</TD></TR></TABLE>" -f $TableBackgroundColor, 0, $TableBorderColor, $TextAlign, $FormattedText
            }

        }
    }

}