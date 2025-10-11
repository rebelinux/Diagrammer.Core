function Add-DiaHtmlSubGraph {
    <#
    .SYNOPSIS
        Function to convert a array to a HTML Table to mimic Graphviz Cluster (Subgraph).
    .DESCRIPTION
        Takes a array and converts it to a HTML table to mimic Graphviz Subgraph
    .Example
        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
        Add-DiaHtmlSubGraph -TableArray $SiteSubnets -Align "Center" -ColumnSize 2
            _________________________________
            |               |               |
            |192.168.5.0/24 |192.168.7.0/24 |
            ________________________________
            |               |               |
            |  10.0.0.0/24  |               |
            _________________________________

        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
        Add-DiaHTMLSubGraph -TableArray $SiteSubnets -Align "Center"
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
        Version:        0.2.30
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .PARAMETER TableArray
        An array of strings/objects to place in this record
    .PARAMETER Align
        Align content inside table cell
    .PARAMETER TableBorder
        The table border (Default: 0)
    .PARAMETER CellBorder
        The table cell border (Default: 0)
    .PARAMETER CellPadding
        The table cell padding space (Default: 5)
    .PARAMETER CellSpace
        The table cell space space (Default: 5)
    .PARAMETER FontColor
        The text font color used inside the cell (Default #565656)
    .PARAMETER FontName
        The text font name used inside the cell
    .PARAMETER FontSize
        The text font size used inside the cell
    .PARAMETER Logo
        Icon used to draw the node type
    .PARAMETER ColumnSize
        This number is used to specified how to split the object inside the HTML table.
    .PARAMETER ImagesObj
        Hashtable with the IconName > IconPath translation
    .PARAMETER IconDebug
        Set the table debug mode
    .PARAMETER IconType
        Node Icon type
    .PARAMETER NoFontBold
        Disable the node aditionalinfo bold in text
    .PARAMETER Label
        Allow to set SubGraph Label
    .PARAMETER LabelPos
        Allow to set SubGraph Label position. Allowed values are top or down (Default: down)
    .PARAMETER TableStyle
        Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
        styles can be combines ("rounded,dashed")
    .PARAMETER TableBorderColor
        Set the subgraph table border color
    .PARAMETER TableStyle
        Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
        styles can be combines ("rounded,dashed")
    .PARAMETER IconWidth
        Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
        styles can be combines ("rounded,dashed")
    .PARAMETER IconHeight
        Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
        styles can be combines ("rounded,dashed")
    #>

    <#
        TODO
        1. Add Icon to MultiColumns section Done
        2. Change hardcoded values (FontName, FontColor, FontSize)
        3. Document all parameters
        4. Look for a solution for the Icon and Label problem
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'The table array to process'
        )]
        [string[]] $TableArray,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the Image Hashtable Object'
        )]
        [Hashtable] $ImagesObj,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the text align'
        )]
        [string] $Align = 'Center',
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
            HelpMessage = 'Allow to set the padding of the html cell border'
        )]
        [int] $CellPadding = 5,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the spacing of the html cell border'
        )]
        [int] $CellSpacing = 5,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font size'
        )]
        [int] $fontSize = 14,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font name'
        )]
        [string] $fontName = "Segoe Ui Black",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font color'
        )]
        [string] $fontColor = "#565656",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'This value is used to specified a int used to split the object inside the HTML table'
        )]
        [int] $columnSize = 1,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enable the icon debug mode'
        )]
        [Alias("DraftMode")]
        [bool] $IconDebug,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Disable the aditional text bold configuration'
        )]
        [Switch] $NoFontBold,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table icon'
        )]
        [ValidateScript({
                if ($ImagesObj) {
                    $true
                } else {
                    throw "ImagesObj table needed if IconType option is especified."
                }
            })]
        [string]$IconType,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table label'
        )]
        [string]$Label,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table label position (top, down)'
        )]
        [ValidateSet('top', 'down')]
        [string]$LabelPos = 'down',
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)'
        )]
        [string]$TableStyle,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table border color'
        )]
        [string]$TableBorderColor = "#000000",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table border color'
        )]
        [string]$TableBackgroundColor = "#ffffff",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon width'
        )]
        [int] $IconWidth = 40,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon height'
        )]
        [int] $IconHeight = 40
    )

    if ($ImagesObj -and $ImagesObj[$IconType]) {
        $Icon = $ImagesObj[$IconType]
    } else { $SIcon = $false }

    if ($TableArray.Count -le 1) {
        $Group = $TableArray
    } else {
        $Group = Split-Array -inArray $TableArray -size $ColumnSize
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
    if ($IconDebug) {
        if ($Icon) {
            $TDSubgraphIcon = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{4}"><B>SubGraph Icon</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, $fontSize
            $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{5}"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$Label, $fontSize

            if ($LabelPos -eq 'down') {
                $TR += '<TR>{0}</TR>' -f $TDSubgraphIcon
                $TR += '<TR>{0}</TR>' -f $TDSubgraph
            } else {
                $TRTemp += '<TR>{0}</TR>' -f $TDSubgraphIcon
                $TRTemp += '<TR>{0}</TR>' -f $TDSubgraph
                $TRTemp += $TR
                $TR = $TRTemp
            }
        } else {
            $TDSubgraph = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{5}"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$Label, $fontSize
            if ($LabelPos -eq 'down') {
                $TR += '<TR>{0}</TR>' -f $TDSubgraph
            } else {
                $TRTemp = '<TR>{0}</TR>' -f $TDSubgraph
                $TRTemp += $TR
                $TR = $TRTemp
            }
        }
    } else {
        if ($Icon) {
            $TDSubgraphIcon = '<TD valign="BOTTOM" ALIGN="{0}" colspan="{1}" fixedsize="true" width="{5}" height="{6}"><IMG src="{4}"></IMG></TD>' -f $Align, $columnSize, $fontName, $fontColor, $Icon, $IconWidth, $IconHeight
            $TDSubgraph = '<TD valign="TOP" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{5}"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$Label, $fontSize

            if ($LabelPos -eq 'down') {
                $TR += '<TR>{0}</TR>' -f $TDSubgraphIcon
                $TR += '<TR>{0}</TR>' -f $TDSubgraph
            } else {
                $TRTemp += '<TR>{0}</TR>' -f $TDSubgraphIcon
                $TRTemp += '<TR>{0}</TR>' -f $TDSubgraph
                $TRTemp += $TR
                $TR = $TRTemp
            }
        } else {
            $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{5}"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$Label, $fontSize
            if ($LabelPos -eq 'down') {
                $TR += '<TR>{0}</TR>' -f $TDSubgraph
            } else {
                $TRTemp = '<TR>{0}</TR>' -f $TDSubgraph
                $TRTemp += $TR
                $TR = $TRTemp
            }
        }
    }

    # TODO
    # Invenstigate if adding the logo and the label to a aditional table

    if ($IconDebug) {
        if ($TableStyle) {
            return '<TABLE BGColor="{0}" STYLE="{1}" COLOR="red" border="1" cellborder="1" cellpadding="{2}">{3}</TABLE>' -f $TableBackgroundColor, $TableStyle, $CellPadding, $TR

        } else {
            return '<TABLE BGColor="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{1}">{2}</TABLE>' -f $TableBackgroundColor, $CellPadding, $TR
        }
    } else {
        if ($TableStyle) {
            return '<TABLE BGColor="{0}" COLOR="{5}" STYLE="{4}" border="{1}" cellborder="{2}" cellpadding="{7}" cellspacing="{6}">{3}</TABLE>' -f $TableBackgroundColor, $tableBorder, $cellBorder, $TR, $TableStyle, $TableBorderColor, $CellSpacing, $CellPadding

        } else {
            return '<TABLE BGColor="{0}" COLOR="{4}" border="{1}" cellborder="{2}" cellpadding="{6}" cellspacing="{5}">{3}</TABLE>' -f $TableBackgroundColor, $tableBorder, $cellBorder, $TR, $TableBorderColor, $CellSpacing, $CellPadding
        }
    }
}