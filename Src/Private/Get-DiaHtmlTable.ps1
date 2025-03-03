Function Get-DiaHTMLTable {
    <#
    .SYNOPSIS
        Function to convert a string array to a HTML Table with Graphviz Nodes split by Columns (No Icons)
    .DESCRIPTION
        Takes an array and converts it to a HTML table used for GraphViz Node label
    .Example
        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
        Get-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -ColumnSize 2
            _________________________________
            |               |               |
            |192.168.5.0/24 |192.168.7.0/24 |
            ________________________________
            |               |               |
            |  10.0.0.0/24  |               |
            _________________________________

        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
        Get-DiaHTMLTable -Rows $SiteSubnets -Align "Center"
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
        Version:        0.2.17
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .PARAMETER Rows
        An array of strings/objects to place in this record
    .PARAMETER Align
        Align content inside table cell
    .PARAMETER TableBorder
        The table border line size
    .PARAMETER CellBorder
        The table cell border
    .PARAMETER FontSize
        The cell text font size
    .PARAMETER FontName
        The cell text font size
    .PARAMETER FontColor
        The text font color used inside the cell (Default #565656)
    .PARAMETER IconType
        Node Icon type
    .PARAMETER ColumnSize
        This value is used to specified a int used to split the object inside the HTML table
    .PARAMETER Port
        Used inside Graphviz to modify the head or tail of an edge, so that the end attaches directly to the object
    .PARAMETER MultiIcon
        Allow to draw an icon to each table element. If not set the table share a single Icon
    .PARAMETER ImagesObj
        Hashtable with the IconName > IconPath translation
    .PARAMETER IconDebug
        Set the table debug mode
    .PARAMETER AditionalInfo
        Hashtable used to add more information to the table elements
    .PARAMETER Subgraph
        Allow to create a table used to add a logo to a Graphviz subgraph
    .PARAMETER SubgraphTableStyle
        Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
    #>

    <#
        TODO
        1. Add Icon to MultiColumns section
        2. Change hardcoded values (FontName, FontColor, FontSize)
        3. Document all parameters
    #>

    param(
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The table array to process'
        )]
        [string[]] $Rows,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the text align'
        )]
        [string] $Align = 'center',
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the width of the html table border'
        )]
        [int] $TableBorder = 0,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the width of the html cell border'
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
        [string] $fontColor = "#565656",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font size'
        )]
        [int] $FontSize = 14,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font name'
        )]
        [string] $fontName = "Segoe Ui Black",
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
        [bool] $IconDebug,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)'
        )]
        [string] $TableStyle = "rounded,dashed",
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
                throw "ImagesObj table needed if SubgraphIconType option is especified."
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
            HelpMessage = 'Allow to set the subgraph table label font size'
        )]
        [int]$SubgraphLabelFontsize = 14,
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
        [string]$SubgraphTableStyle,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table border color'
        )]
        [string]$TableBorderColor = "#000000",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon width'
        )]
        [string] $SubgraphIconWidth,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon height'
        )]
        [string] $SubgraphIconHeight
    )

    if ($ImagesObj -and $ImagesObj[$SubgraphIconType]) {
        $SubgraphIcon = $ImagesObj[$SubgraphIconType]
    } else { $SubgraphIcon = $false }

    if ($Rows.Count -le 1) {
        $Group = $Rows
    } else {
        $Group = Split-array -inArray $Rows -size $ColumnSize
    }

    $Number = 0

    $TD = ''
    $TR = ''
    while ($Number -ne $Group.Count) {
        foreach ($Element in $Group[$Number]) {
            $TD += '<TD align="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}</FONT></TD>' -f $Align, $FontSize, $Element
        }
        $TR += '<TR>{0}</TR>' -f $TD
        $TD = ''
        $Number++
    }

    # This part set the capability to emulate Graphviz Subgraph
    if ($Subgraph) {
        if ($SubgraphIcon) {
            if ($IconDebug) {
                $TDSubgraphIcon = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{4}"><B>SubGraph Icon</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, $SubgraphLabelFontsize

                $TDSubgraph = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{5}"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$SubGraphLabel, $SubgraphLabelFontsize

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
                if ($SubgraphIconWidth -and $SubgraphIconHeight) {
                    $TDSubgraphIcon = '<TD ALIGN="{0}" colspan="{1}" fixedsize="true" width="{5}" height="{6}"><IMG src="{4}"></IMG></TD>' -f $Align, $columnSize, $fontName, $fontColor, $SubGraphIcon, $SubGraphIconWidth, $SubGraphIconHeight
                    $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{5}"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$SubGraphLabel, $SubgraphLabelFontsize

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
                    $TDSubgraphIcon = '<TD ALIGN="{0}" colspan="{1}" fixedsize="true" width="40" height="40"><IMG src="{2}"></IMG></TD>' -f $Align, $columnSize, $SubGraphIcon
                    $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{5}"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$SubGraphLabel, $SubgraphLabelFontsize

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
                $TDSubgraph = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{5}"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontcolor, [string]$SubgraphLabel, $fontSize
                if ($SubgraphLabelPos -eq 'down') {
                    $TR += '<TR>{0}</TR>' -f $TDSubgraph
                } else {
                    $TRTemp = '<TR>{0}</TR>' -f $TDSubgraph
                    $TRTemp += $TR
                    $TR = $TRTemp
                }
            } else {
                $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{5}"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontcolor, [string]$SubgraphLabel, $fontSize
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
        if ($SubgraphTableStyle) {
            return '<TABLE STYLE="{1}" COLOR="red" border="1" cellborder="1" cellpadding="{3}">{0}</TABLE>' -f $TR, $SubgraphTableStyle, $CellSpacing, $CellPadding

        } else {
            return '<TABLE COLOR="red" border="1" cellborder="1" cellpadding="{1}">{0}</TABLE>' -f $TR, $CellPadding
        }
    } else {
        if ($SubgraphTableStyle) {
            return '<TABLE COLOR="{4}" STYLE="{3}" border="{0}" cellborder="{1}" cellpadding="{6}" cellspacing="{5}">{2}</TABLE>' -f $tableBorder, $cellBorder, $TR, $SubgraphTableStyle, $TableBorderColor, $CellSpacing, $CellPadding

        } else {
            return '<TABLE STYLE="{0}" COLOR="{4}" border="{1}" cellborder="{2}" cellpadding="{6}" cellspacing="{5}">{3}</TABLE>' -f $TableStyle, $tableBorder, $cellBorder, $TR, $TableBorderColor, $CellSpacing, $CellPadding
        }
    }
}