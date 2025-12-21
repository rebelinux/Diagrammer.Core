function Add-DiaHtmlTable {
    <#
    .SYNOPSIS
        Converts a string array to an HTML table with Graphviz nodes split by columns (No Icons).
    .DESCRIPTION
        This function takes an array and converts it to an HTML table used for Graphviz node labels.
    .EXAMPLE
        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
        Add-DiaHTMLTable -Rows $SiteSubnets -ALIGN "Center" -ColumnSize 2
            _________________________________
            |               |               |
            |192.168.5.0/24 |192.168.7.0/24 |
            ________________________________
            |               |               |
            |  10.0.0.0/24  |               |
            _________________________________

        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
        Add-DiaHTMLTable -Rows $SiteSubnets -ALIGN "Center"
            _________________
            |               |
            |192.168.5.0/24 |
            _________________
            |               |
            |192.168.7.0/24 |
            _________________
            |               |
            |  10.0.0.0/24  |
            _________________

    .NOTES
        Version:        0.2.36
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux
    .PARAMETER Rows
        An array of strings/objects to place in the table.
    .PARAMETER ALIGN
        Specifies the ALIGNment of content inside the table cell.
    .PARAMETER TableBorder
        Specifies the table border line size.
    .PARAMETER CellBorder
        Specifies the table cell border size.
    .PARAMETER CellSpacing
        Specifies the spacing between table cells.
    .PARAMETER CellPadding
        Specifies the padding inside table cells.
    .PARAMETER FontColor
        Specifies the font color used inside the cell (Default: #000000).
    .PARAMETER FontSize
        Specifies the font size of the cell text.
    .PARAMETER FontName
        Specifies the font name of the cell text.
    .PARAMETER FontBold
        Sets the cell text to bold.
    .PARAMETER FontItalic
        Sets the cell text to italic.
    .PARAMETER FontUnderline
        Sets the cell text to underline.
    .PARAMETER FontOverline
        Sets the cell text to overline.
    .PARAMETER FontSubscript
        Sets the cell text to subscript.
    .PARAMETER FontSuperscript
        Sets the cell text to superscript.
    .PARAMETER FontStrikeThrough
        Sets the cell text to strikethrough.
    .PARAMETER ColumnSize
        Specifies the number of columns to split the objects inside the HTML table.
    .PARAMETER ImagesObj
        A hashtable with the IconName to IconPath translation.
    .PARAMETER IconDebug
        Enables the table debug mode.
    .PARAMETER TableStyle
        Allows setting a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED).
    .PARAMETER TableBorderColor
        Specifies the table border color.
    .PARAMETER TableBackgroundColor
        Specifies the table border color.
    .PARAMETER NodeObject
        Indicates that the table should be formatted as a Graphviz node object.
    .PARAMETER Name
        The node name (required if NodeObject is set).
    .PARAMETER GraphvizAttributes
        Additional Graphviz attributes to add to the node.
    .PARAMETER Subgraph
        Allows creating a table used to add a logo to a Graphviz subgraph.
    .PARAMETER SubgraphIconType
        Specifies the subgraph icon type (requires ImagesObj).
    .PARAMETER SubgraphLabel
        Specifies the subgraph table label.
    .PARAMETER SubgraphLabelFontsize
        Specifies the font size for the subgraph label.
    .PARAMETER SubgraphFontColor
        Specifies the font color used inside the cell (Default: #000000).
    .PARAMETER SubgraphFontBold
        Sets the subgraph label text to bold.
    .PARAMETER SubgraphFontItalic
        Sets the subgraph label text to italic.
    .PARAMETER SubgraphFontUnderline
        Sets the subgraph label text to underline.
    .PARAMETER SubgraphFontOverline
        Sets the subgraph label text to overline.
    .PARAMETER SubgraphFontSubscript
        Sets the subgraph label text to subscript.
    .PARAMETER SubgraphFontSuperscript
        Sets the subgraph label text to superscript.
    .PARAMETER SubgraphFontStrikeThrough
        Sets the subgraph label text to strikethrough.
    .PARAMETER SubgraphLabelPos
        Sets the subgraph label position (top, down).
    .PARAMETER SubgraphTableStyle
        Allows setting a table style for the subgraph (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED).
    .PARAMETER SubgraphIconWIDTH
        Specifies the subgraph icon WIDTH.
    .PARAMETER SubgraphIconHEIGHT
        Specifies the subgraph icon HEIGHT.
    .PARAMETER NoFontBold
        Disables additional text bold configuration.
    #>

    [CmdletBinding()]
    [OutputType([System.String])]

    param(
        [Parameter(
            Mandatory,
            HelpMessage = 'The node name (optional)'
        )]
        [string] $Name,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The table array to process'
        )]
        [string[]] $Rows,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the text ALIGN'
        )]
        [string] $ALIGN = 'center',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the WIDTH of the html table border'
        )]
        [int] $TableBorder = 0,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the WIDTH of the html cell border'
        )]
        [int] $CellBorder = 0,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the spacing of the html cell border'
        )]
        [int] $CellSpacing = 5,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the padding of the html cell border'
        )]
        [int] $CellPadding = 5,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font color'
        )]
        [string] $FontColor = '#000000',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font size'
        )]
        [int] $FontSize = 14,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font name'
        )]
        [string] $FontName = 'Segoe Ui',

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
            HelpMessage = 'This value is used to specified a int used to split the object inside the HTML table'
        )]
        [int] $ColumnSize = 2,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the Image Hashtable Object'
        )]
        [Hashtable] $ImagesObj,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enable the icon debug mode'
        )]
        [Alias('DraftMode')]
        [bool] $IconDebug,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)'
        )]
        [string] $TableStyle = 'SOLID',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Disable the aditional text bold configuration'
        )]
        [Switch] $NoFontBold,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Create the table with that can be used as a Subgraph replacement with the hashtable inside it'
        )]
        [Switch]$Subgraph,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table icon'
        )]
        [ValidateScript({
                if ($ImagesObj) {
                    $true
                } else {
                    throw 'ImagesObj table needed if SubgraphIconType option is especified.'
                }
            })]
        [string]$SubgraphIconType,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table label'
        )]
        [string]$SubgraphLabel,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font name'
        )]
        [string] $SubgraphFontName = 'Segoe Ui',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table label font size'
        )]
        [int]$SubgraphLabelFontsize = 14,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font color'
        )]
        [string] $SubgraphFontColor = '#000000',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font bold'
        )]
        [switch] $SubgraphFontBold,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font italic'
        )]
        [switch] $SubgraphFontItalic,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font underline'
        )]
        [switch] $SubgraphFontUnderline,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font overline'
        )]
        [switch] $SubgraphFontOverline,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font subscript'
        )]
        [switch] $SubgraphFontSubscript,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font superscript'
        )]
        [switch] $SubgraphFontSuperscript,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font strikethrough'
        )]
        [switch] $SubgraphFontStrikeThrough,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table label position (top, down)'
        )]
        [ValidateSet('top', 'down')]
        [string]$SubgraphLabelPos = 'down',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)'
        )]
        [string]$SubgraphTableStyle = 'SOLID',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table border color'
        )]
        [string]$TableBorderColor = '#000000',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table background color'
        )]
        [string]$TableBackgroundColor = '#ffffff',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon WIDTH'
        )]
        [string] $SubgraphIconWIDTH,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon HEIGHT'
        )]
        [string] $SubgraphIconHEIGHT,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the text ALIGN'
        )]
        [ValidateScript({
                if ($Name) {
                    $true
                } else {
                    throw 'Name parameter is required when NodeObject is set.'
                }
            })]
        [switch] $NodeObject,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)'
        )]
        [hashtable] $GraphvizAttributes = @{}
    )

    ## Getting the Subgraph Icon from the ImagesObj Hashtable
    if ($ImagesObj -and $ImagesObj[$SubgraphIconType]) {
        $SubgraphIcon = $ImagesObj[$SubgraphIconType]
    } else { $SubgraphIcon = $false }

    ## This part split the array in groups based on the ColumnSize value
    if ($Rows.Count -le 1) {
        $Group = $Rows
    } else {
        $Group = Split-Array -inArray $Rows -size $ColumnSize
    }

    # Index to track the number of rows processed
    $Number = 0

    $TD = ''
    $TR = ''
    # Create the table and splitting elements based on the ColumnSize value
    while ($Number -ne $Group.Count) {
        foreach ($Element in $Group[$Number]) {
            $FormattedElement = Format-HtmlFontProperty -Text $Element -FontSize $Fontsize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

            $TD += '<TD ALIGN="{0}" COLSPAN="1">{1}</TD>' -f $ALIGN, $FormattedElement
        }
        $TR += '<TR>{0}</TR>' -f $TD
        $TD = ''
        $Number++
    }

    # This part set the capability to emulate Graphviz Subgraph
    if ($Subgraph) {
        if ($SubGraphLabel) {
            # Get the Formatted Subgraph Label Ex: <FONT POINT-SIZE="12">Label</FONT>
            $FormattedName = Format-HtmlFontProperty -Text $SubGraphLabel -FontSize $SubgraphLabelFontsize -FontColor $SubgraphFontColor -FontBold:$SubgraphFontBold -FontItalic:$SubgraphFontItalic -FontUnderline:$SubgraphFontUnderline -FontName $SubgraphFontName -FontSubscript:$SubgraphFontSubscript -FontSuperscript:$SubgraphFontSuperscript -FontStrikeThrough:$SubgraphFontStrikeThrough -FontOverline:$SubgraphFontOverline
        }
        if ($SubgraphIcon) {
            if ($IconDebug) {
                $TDSubgraphIcon = '<TD BGCOLOR="#FFCCCC" ALIGN="{0}" COLSPAN="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{4}"><B>SubGraph Icon</B></FONT></TD>' -f $ALIGN, $columnSize, $FontName, $FontColor, $SubgraphLabelFontsize

                $TDSubgraph = '<TD BGCOLOR="#FFCCCC" ALIGN="{0}" COLSPAN="{1}">{2}</TD>' -f $ALIGN, $columnSize, $FormattedName

                if ($SubgraphLabelPos -eq 'down') {
                    $TR += '<TR>{0}</TR>' -f $TDSubgraphIcon
                    $TR += '<TR>{0}</TR>' -f $TDSubgraph
                } else {
                    $TRTemp += '<TR>{0}</TR>' -f $TDSubgraphIcon
                    $TRTemp += '<TR>{0}</TR>' -f $TDSubgraph
                    $TRTemp += $TR
                    $TR = $TRTemp
                }
            } else {
                if ($SubgraphIconWIDTH -and $SubgraphIconHEIGHT) {

                    $TDSubgraphIcon = '<TD ALIGN="{0}" COLSPAN="{1}" FIXEDSIZE="true" WIDTH="{2}" HEIGHT="{3}"><IMG SRC="{4}"></IMG></TD>' -f $ALIGN, $columnSize, $SubGraphIconWIDTH, $SubGraphIconHEIGHT, $SubGraphIcon

                    $TDSubgraph = '<TD ALIGN="{0}" COLSPAN="{1}">{2}</TD>' -f $ALIGN, $columnSize, $FormattedName

                    if ($SubgraphLabelPos -eq 'down') {
                        $TR += '<TR>{0}</TR>' -f $TDSubgraphIcon
                        $TR += '<TR>{0}</TR>' -f $TDSubgraph
                    } else {
                        $TRTemp += '<TR>{0}</TR>' -f $TDSubgraphIcon
                        $TRTemp += '<TR>{0}</TR>' -f $TDSubgraph
                        $TRTemp += $TR
                        $TR = $TRTemp
                    }
                } else {

                    $TDSubgraphIcon = '<TD ALIGN="{0}" COLSPAN="{1}" FIXEDSIZE="true" WIDTH="40" HEIGHT="40"><IMG SRC="{2}"></IMG></TD>' -f $ALIGN, $columnSize, $SubGraphIcon

                    $TDSubgraph = '<TD ALIGN="{0}" COLSPAN="{1}">{2}</TD>' -f $ALIGN, $columnSize, $FormattedName

                    if ($SubgraphLabelPos -eq 'down') {
                        $TR += '<TR>{0}</TR>' -f $TDSubgraphIcon
                        $TR += '<TR>{0}</TR>' -f $TDSubgraph
                    } else {
                        $TRTemp += '<TR>{0}</TR>' -f $TDSubgraphIcon
                        $TRTemp += '<TR>{0}</TR>' -f $TDSubgraph
                        $TRTemp += $TR
                        $TR = $TRTemp
                    }
                }
            }
        } else {
            if ($IconDebug) {
                $TDSubgraph = '<TD BGCOLOR="#FFCCCC" ALIGN="{0}" COLSPAN="{1}">{2}</TD>' -f $ALIGN, $columnSize, $FormattedName
                if ($SubgraphLabelPos -eq 'down') {
                    $TR += '<TR>{0}</TR>' -f $TDSubgraph
                } else {
                    $TRTemp = '<TR>{0}</TR>' -f $TDSubgraph
                    $TRTemp += $TR
                    $TR = $TRTemp
                }

            } else {
                $TDSubgraph = '<TD ALIGN="{0}" COLSPAN="{1}">{2}</TD>' -f $ALIGN, $columnSize, $FormattedName
                if ($SubgraphLabelPos -eq 'down') {
                    $TR += '<TR>{0}</TR>' -f $TDSubgraph
                } else {
                    $TRTemp = '<TR>{0}</TR>' -f $TDSubgraph
                    $TRTemp += $TR
                    $TR = $TRTemp
                }
            }
        }
    }

    if ($IconDebug) {
        $HTML = Format-HtmlTable -TableStyle $SubgraphTableStyle -TableBorderColor 'red' -CellBorder $CellBorder -TableRowContent $TR -Cellspacing $CellSpacing -Cellpadding $CellPadding -TableBackgroundColor $TableBackgroundColor

        Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes -AsHtml:(-not $NodeObject)
    } else {
        $HTML = Format-HtmlTable -TableStyle $SubgraphTableStyle -TableBorderColor $TableBorderColor -CellBorder $CellBorder -TableBorder $TableBorder -TableRowContent $TR -Cellspacing $CellSpacing -Cellpadding $CellPadding -TableBackgroundColor $TableBackgroundColor

        Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes -AsHtml:(-not $NodeObject)
    }
}