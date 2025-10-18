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
        Specifies the padding inside the HTML table cells. Default is 10.

    .PARAMETER CellSpacing
        Specifies the spacing between HTML table cells. Default is 20.

    .PARAMETER SubgraphCellPadding
        Padding inside HTML table cells when rendering subgraph labels. Default is 5.

    .PARAMETER SubgraphCellSpacing
        Spacing between HTML table cells when rendering subgraph labels. Default is 5.

    .PARAMETER Fontsize
        Specifies the font size used for the label text. Default is 14.

    .PARAMETER FontColor
        Specifies the font color for the cell text. Default is "#000000".

    .PARAMETER FontName
        Specifies the font family used for the label text. Default is "Segoe Ui".

    .PARAMETER FontBold
        Switch to render the label text in bold.

    .PARAMETER FontItalic
        Switch to render the label text in italic.

    .PARAMETER FontUnderline
        Switch to underline the label text.

    .PARAMETER FontOverline
        Switch to overline the label text.

    .PARAMETER FontSubscript
        Switch to render the label text as subscript.

    .PARAMETER FontSuperscript
        Switch to render the label text as superscript.

    .PARAMETER FontStrikeThrough
        Switch to render the label text with a strikethrough.

    .PARAMETER IconDebug
        Enables debug (draft) mode for icon rendering. When set, a debug table row is included indicating DraftMode.

    .PARAMETER IconType
        The key or name of the icon to use. If set to 'NoIcon' no icon is displayed. Resolved from ImagesObj when available.

    .PARAMETER ImagesObj
        Hashtable mapping icon keys to image file names or paths. Default is an empty hashtable.

    .PARAMETER IconPath
        Optional path (directory) containing icon image files. Required when ImageSizePercent is less than 100.

    .PARAMETER IconWidth
        Optional width for the icon in pixels. When provided with IconHeight, a fixed-size image cell is used.

    .PARAMETER IconHeight
        Optional height for the icon in pixels. When provided with IconWidth, a fixed-size image cell is used.

    .PARAMETER ImageSizePercent
        Percentage to scale the icon (1-100). Default is 100. When less than 100, IconPath is required and Get-DiaImagePercent is used.

    .PARAMETER Label
        The text label used as the diagram title. This parameter is mandatory.

    .PARAMETER SubgraphLabel
        Switch to produce a table formatted for a Graphviz subgraph label (icon and text side-by-side).

    .PARAMETER TableBorder
        Border width for the generated HTML table. Default is 0.
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

    $FormattedLabel = Format-HtmlFontProperty -Text $Label -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

    if (-not $SubgraphLabel) {

        if ($IconDebug) {
            '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Main Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="{3}" Color="{4}" POINT-SIZE="{5}">{6}</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $FontName, $FontColor, $FontSize, $Label
        } elseif ($ICON -ne 'NoIcon') {
            if ($IconWidth -and $IconHeight) {
                '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TR><TD ALIGN="center" colspan="1" fixedsize="true" width="{3}" height="{4}"><img src="{5}"/></TD></TR><TR><TD ALIGN="center">{6}</TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $IconWidth, $IconHeight, $ICON, $FormattedLabel

            } elseif ($CalculatedImageSize) {
                '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TR><TD ALIGN="center" colspan="1" fixedsize="true" width="{3}" height="{4}"><img src="{5}"/></TD></TR><TR><TD ALIGN="center">{6}</TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $CalculatedImageSize.Width, $CalculatedImageSize.Height, $ICON, $FormattedLabel

            } else {
                '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TR><TD ALIGN="center" colspan="1"><img src="{3}"/></TD></TR><TR><TD ALIGN="center">{4}</TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $ICON, $FormattedLabel

            }
        } else {
            '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TR><TD ALIGN="center">{3}</TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $FormattedLabel
        }
    }
    if ($SubgraphLabel) {

        if ($IconDebug) {
            '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Subgraph Logo</TD><TD bgcolor="#FFCCCC" ALIGN="Center">{3}</TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $FormattedLabel
        } if ($ICON -ne 'NoIcon') {
            if ($IconWidth -and $IconHeight) {
                '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TR><TD ALIGN="center" colspan="1" fixedsize="true" width="{3}" height="{4}"><img src="{5}"/></TD><TD ALIGN="center">{6}</TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $IconWidth, $IconHeight, $ICON, $FormattedLabel
            } elseif ($CalculatedImageSize) {
                '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TR><TD ALIGN="center" colspan="1" fixedsize="true" width="{3}" height="{4}"><img src="{5}"/></TD><TD ALIGN="center">{6}</TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $CalculatedImageSize.Width, $CalculatedImageSize.Height, $ICON, $FormattedLabel
            } else {
                '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TR><TD ALIGN="center" colspan="1"><img src="{3}"/></TD><TD ALIGN="center">{4}</TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $ICON, $FormattedLabel
            }
        } else {
            '<TABLE border="{0}" cellborder="0" cellspacing="{1}" cellpadding="{2}"><TD ALIGN="center">{3}</TD></TR></TABLE>' -f $TableBorder, $CellSpacing, $CellPadding, $FormattedLabel
        }
    }
}