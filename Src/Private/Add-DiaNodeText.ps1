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

    .PARAMETER FillColor
        Sets the background color of the text box using a hex color code. Default is "transparent".
    .PARAMETER TextAlign
        Specifies the alignment of the text within the text box. Accepted values are: Left, Right, Center, and Justify. Default is "Center".

    .PARAMETER GraphvizAttributes
        A hashtable of additional Graphviz attributes to apply to the node. This allows for further customization of the node's appearance.

    .PARAMETER NodeObject
        If specified, the function will return the node object instead of rendering it directly.

    .EXAMPLE
        Add-DiaNodeText -Name "Server1" -IconDebug $true -TableBorder 2 -TableBorderColor "#FF0000" -TableBorderStyle "SOLID" -Text "This is a test text box." -FontColor "#0000FF" -FontSize 14 -FontBold $true -FillColor "#FFFF00"

        ** Generates an HTML text with a "ServerWindows" icon, 50% size, red solid border. **
                    _________________
                    |               |
                    |   Text Box    |
                    |               |
                    |_______________|

    .NOTES
        Author: Jonathan Colon
        Version: 0.2.30
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
            HelpMessage = 'Allow to set the width of the html table border'
        )]
        [int] $TableBorder = 0,

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
            Mandatory = $true,
            HelpMessage = 'Set the text to display inside the text box'
        )]
        [string] $Text,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the text to display inside the text box'
        )]
        [ValidateSet("Left", "Right", "Center", "Justify")]
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
        [bool] $FontBold = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font italic'
        )]
        [bool] $FontItalic = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font underline'
        )]
        [bool] $FontUnderline = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the fill color'
        )]
        [string] $FillColor = "transparent",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)'
        )]
        [hashtable] $GraphvizAttributes = @{},

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'If specified, the function will return the node object instead of rendering it directly.'
        )]
        [switch] $NodeObject
    )


    if ($IconDebug) {
        if ($NodeObject) {
            $HTML = "<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='{0}' ALIGN='{2}' colspan='1'>{1}</TD></TR></TABLE>" -f 'SOLID', $Text, $TextAlign

            $JoinHash = Join-Hashtable -PrimaryHash @{label = $HTML; shape = 'plain'; fillcolor = 'transparent'; fontsize = 14 } -SecondaryHash $GraphvizAttributes -PreferSecondary

            Node -Name $Name -Attributes $JoinHash
        } else {
            "<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='{0}' ALIGN='{2}' colspan='1'><FONT POINT-SIZE='{4}' COLOR='{3}'>{1}</FONT></TD></TR></TABLE>" -f 'SOLID', $Text, $TextAlign, $FontColor, $FontSize
        }
    } else {
        if ($NodeObject) {
            $HTML = if ($TableBorderStyle) {
                "<TABLE STYLE='{0}' border='{1}' color='{2}' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='{0}' ALIGN='{3}' colspan='1'>{4}</TD></TR></TABLE>" -f $TableBorderStyle, $TableBorder, $TableBorderColor, $TextAlign, $Text
            } else {
                "<TABLE border='{0}' color='{1}' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='{2}' colspan='1'>{3}</TD></TR></TABLE>" -f $TableBorder, $TableBorderColor, $TextAlign, $Text
            }

            $JoinHash = Join-Hashtable -PrimaryHash @{label = $HTML; shape = 'plain'; fillcolor = 'transparent'; fontsize = 14 } -SecondaryHash $GraphvizAttributes -PreferSecondary

            Node -Name $Name -Attributes $JoinHash
        } else {
            if ($TableBorderStyle) {
                "<TABLE STYLE='{0}' border='{1}' color='{2}' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='{0}' ALIGN='{3}' colspan='1'>{4}</TD></TR></TABLE>" -f $TableBorderStyle, $TableBorder, $TableBorderColor, $TextAlign, $Text
            } else {
                "<TABLE border='{0}' color='{1}' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='{2}' colspan='1'>{3}</TD></TR></TABLE>" -f $TableBorder, $TableBorderColor, $TextAlign, $Text
            }

        }
    }

}