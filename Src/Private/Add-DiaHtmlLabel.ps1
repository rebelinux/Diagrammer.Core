function Add-DiaHtmlLabel {
    <#
    .SYNOPSIS
        Converts a string to an HTML table for the report main logo and title.
    .DESCRIPTION
        This function takes a string and converts it into an HTML table format used for the report's main logo and title. It supports customization of the logo, font, and debug options.
    .EXAMPLE
        $MainGraphLabel = Switch ($DiagramType) {
            'Forest' { 'Active Directory Forest Diagram' }
            'Domain' { 'Active Directory Domain Diagram' }
            'Sites' { 'Active Directory Site Inventory Diagram' }
            'SitesTopology' { 'Active Directory Site Topology Diagram' }
        }
        $CustomLogo = "Logo Path"
        $IconDebug = $false
        Add-DiaHTMLLabel -Label $MainGraphLabel -IconType $CustomLogo -IconDebug $IconDebug
        # This will generate an HTML table with the specified label and logo.
    .NOTES
        Version:        0.2.30
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        GitHub:         rebelinux
    .PARAMETER CellPadding
        The padding inside the table cell. Default is 5.
    .PARAMETER CellSpacing
        The spacing between table cells. Default is 5.
    .PARAMETER Fontsize
        Specifies the font size of the label. Default is 1.
    .PARAMETER fontColor
        Specifies the font color for the cell text. Default is "#000000".
    .PARAMETER fontName
        Specifies the font name for the cell text. Default is "Segoe Ui".
    .PARAMETER IconDebug
        Enables the table debug mode if set to $true.
    .PARAMETER IconHeight
        Specifies the height of the subgraph icon. Default is 40.
    .PARAMETER IconPath
        Optionally specifies the full path to the icon image file. If not provided, the default image path is used.
    .PARAMETER IconType
        Specifies the main diagram logo type.
    .PARAMETER IconWidth
        Specifies the width of the subgraph icon. Default is 40.
    .PARAMETER ImageSizePercent
        Set the image size in percent (100% is default). Requires IconPath when less than 100.
    .PARAMETER ImagesObj
        Hashtable containing the IconName to IconPath translation.
    .PARAMETER Label
        The string used to set the Diagram Title. This parameter is mandatory.
    .PARAMETER SubgraphLabel
        Switch to create a table used to add a logo to a Graphviz subgraph.
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide Label string to process'
        )]
        [string] $Label,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide Image hashtable to process'
        )]
        [Hashtable] $ImagesObj = @{},

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide Icon type to process'
        )]
        [string] $IconType,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Include the full path for the icon images (default is false)'
        )]
        [System.IO.FileInfo] $IconPath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon height'
        )]
        [int] $IconHeight,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon width'
        )]
        [int] $IconWidth,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enable the icon debug mode'
        )]
        [Alias("DraftMode")]
        [bool] $IconDebug,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a label font size'
        )]
        [int] $Fontsize = 14,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font color'
        )]
        [string] $FontColor = "#000000",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font name'
        )]
        [string] $FontName = "Segoe Ui",

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
            Mandatory = $false,
            HelpMessage = 'Allow to set the font overline'
        )]
        [switch] $FontOverline,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font subscript'
        )]
        [switch] $FontSubscript,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font superscript'
        )]
        [switch] $FontSuperscript,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font strikethrough'
        )]
        [switch] $FontStrikeThrough,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the padding inside the HTML table cells.'
        )]
        [int] $CellPadding = 10,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the spacing between HTML table cells.'
        )]
        [int] $CellSpacing = 20,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the SubgraphLabel padding inside the HTML table cells.'
        )]
        [int] $SubgraphCellPadding = 5,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the SubgraphLabel spacing between HTML table cells.'
        )]
        [int] $SubgraphCellSpacing = 5,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the image size in percent (100% is default)'
        )]
        [ValidateRange(1, 100)]
        [int] $ImageSizePercent = 100,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide SubgraphLabel to process'
        )]
        [Switch] $SubgraphLabel,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the image size in percent (100% is default)'
        )]
        [int] $TableBorder = 0
    )

    if ($IconType -eq 'NoIcon') {
        $ICON = 'NoIcon'
    } elseif ($ImagesObj[$IconType]) {
        $ICON = $ImagesObj[$IconType]
    } else { $ICON = "no_icon.png" }

    if ($ImageSizePercent -lt 100) {
        if (-not $IconPath) {
            throw "IconPath is required when ImageSizePercent is less than 100."
        }
        $CalculatedImageSize = Get-DiaImagePercent -ImageInput (Join-Path -Path $IconPath -Child $ICON) -Percent $ImageSizePercent
    }

    if (-not $SubgraphLabel) {

        $FormattedLabel = Format-HtmlFontProperty -Text $Label -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

        if ($IconDebug) {
            return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($CellSpacing)' cellpadding='$($CellSpacing)'><TR><TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'>Main Logo</TD></TR><TR><TD bgcolor='#FFCCCC' ALIGN='center' ><FONT FACE='$($fontName)' Color='$($fontColor)' POINT-SIZE='$($Fontsize)'>$Label</FONT></TD></TR><TR><TD ALIGN='center'><FONT Color='red'>Debug ON</font></TD></TR></TABLE>"
        } elseif ($ICON -ne 'NoIcon') {
            if ($IconWidth -and $IconHeight) {
                return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($CellSpacing)' cellpadding='$($CellPadding)'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='$($IconWidth)' height='$($IconHeight)'><img src='$($ICON)'/></TD></TR><TR><TD ALIGN='center'>$FormattedLabel</TD></TR></TABLE>"

            } elseif ($CalculatedImageSize) {
                return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($CellSpacing)' cellpadding='$($CellPadding)'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='$($CalculatedImageSize.Width)' height='$($CalculatedImageSize.Height)'><img src='$($ICON)'/></TD></TR><TR><TD ALIGN='center'>$FormattedLabel</TD></TR></TABLE>"

            } else {
                return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($CellSpacing)' cellpadding='$($CellPadding)'><TR><TD ALIGN='center' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD ALIGN='center'>$FormattedLabel</TD></TR></TABLE>"

            }
        } else {
            return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($CellSpacing)' cellpadding='$($CellSpacing)'><TR><TD ALIGN='center'>$FormattedLabel</TD></TR></TABLE>"
        }
    }
    if ($SubgraphLabel) {

        $FormattedSubgraphLabel = Format-HtmlFontProperty -Text $SubgraphLabel -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

        if ($IconDebug) {
            return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($CellSpacing)' cellpadding='$($CellSpacing)'><TR><TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'>Subgraph Logo</TD><TD bgcolor='#FFCCCC' ALIGN='center'>$FormattedSubgraphLabel</TD></TR></TABLE>"
        } if ($ICON -ne 'NoIcon') {
            if ($IconWidth -and $IconHeight) {
                return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($SubgraphCellPadding)' cellpadding='$($SubgraphCellPadding)'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='$($IconWidth)' height='$($IconHeight)'><img src='$($ICON)'/></TD><TD ALIGN='center'>$FormattedSubgraphLabel</TD></TR></TABLE>"
            } elseif ($CalculatedImageSize) {
                return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($SubgraphCellPadding)' cellpadding='$($SubgraphCellPadding)'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='$($CalculatedImageSize.Width)' height='$($CalculatedImageSize.Height)'><img src='$($ICON)'/></TD><TD ALIGN='center'>$FormattedSubgraphLabel</TD></TR></TABLE>"
            } else {
                return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($SubgraphCellPadding)' cellpadding='$($SubgraphCellPadding)'><TR><TD ALIGN='center' colspan='1'><img src='$($ICON)'/></TD><TD ALIGN='center'>$FormattedSubgraphLabel</TD></TR></TABLE>"
            }
        } else {
            return "<TABLE border='$TableBorder' cellborder='0' cellspacing='$($CellSpacing)' cellpadding='$($CellSpacing)'><TD ALIGN='center'>$FormattedSubgraphLabel</TD></TR></TABLE>"
        }
    }
}