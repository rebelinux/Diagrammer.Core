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
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux

    .PARAMETER TableArray
        An array of strings/objects to place in this record
    .PARAMETER ImagesObj
        Hashtable with the IconName > IconPath translation
    .PARAMETER ImageSizePercent
        Set the image size in percent (Default: 100)
    .PARAMETER Align
        Align content inside table cell (Default: Center)
    .PARAMETER TableBorder
        The table border width (Default: 0)
    .PARAMETER CellBorder
        The table cell border width (Default: 0)
    .PARAMETER CellPadding
        The table cell padding space (Default: 5)
    .PARAMETER CellSpacing
        The table cell spacing (Default: 5)
    .PARAMETER FontSize
        The text font size used inside the cell (Default: 14)
    .PARAMETER FontName
        The text font name used inside the cell (Default: Segoe Ui)
    .PARAMETER FontColor
        The text font color used inside the cell (Default: #000000)
    .PARAMETER ColumnSize
        Number used to split objects inside the HTML table (Default: 1)
    .PARAMETER IconDebug
        Enable the icon debug mode
    .PARAMETER NoFontBold
        Disable the additional text bold configuration
    .PARAMETER IconType
        The subgraph table icon type
    .PARAMETER Label
        The subgraph table label
    .PARAMETER LabelPos
        The subgraph table label position (top or down, Default: down)
    .PARAMETER TableStyle
        Table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, DASHED)
    .PARAMETER TableBorderColor
        The subgraph table border color (Default: #000000)
    .PARAMETER TableBackgroundColor
        The subgraph table background color (Default: #ffffff)
    .PARAMETER IconWidth
        The subgraph icon width (Default: 40)
    .PARAMETER IconHeight
        The subgraph icon height (Default: 40)
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
            HelpMessage = 'Set the image size in percent (100% is default)'
        )]
        [ValidateRange(1, 100)]
        [int] $ImageSizePercent = 100,

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
        [int] $FontSize = 14,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font name'
        )]
        [string] $FontName = "Segoe Ui",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font color'
        )]
        [string] $FontColor = "#000000",

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
        [int] $ColumnSize = 1,

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
        [int] $IconHeight = 40,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the name of the node.'
        )]
        [String]$Name,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the text align'
        )]
        [ValidateScript({
                if ($Name) {
                    $true
                } else {
                    throw "Name parameter is required when NodeObject is set."
                }
            })]
        [switch] $NodeObject,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)'
        )]
        [hashtable] $GraphvizAttributes = @{}
    )

    if ($ImagesObj -and $ImagesObj[$IconType]) {
        $Icon = $ImagesObj[$IconType]
    } else { $Icon = $false }

    # Set the image size if ImageSizePercent is less than 100
    if ($ImageSizePercent -lt 100) {
        if (-not $IconPath) {
            throw "IconPath is required when ImageSizePercent is less than 100."
        }
        $ImageSize = Get-DiaImagePercent -ImageInput (Join-Path -Path $IconPath -Child $Icon) -Percent $ImageSizePercent

        $IconWidth = $ImageSize.Width
        $IconHeight = $ImageSize.Height
    }

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

    # Format the name with the specified font properties
    $FormattedLabel = Format-HtmlFontProperty -Text $Label -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

    # This part set the capability to emulate Graphviz Subgraph
    if ($IconDebug) {
        if ($Icon) {
            $TDSubgraphIcon = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{4}">{5}</FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, $fontSize, $Icon
            $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}">{2}</TD>' -f $Align, $columnSize, $FormattedLabel

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
            $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}">{2}</TD>' -f $Align, $columnSize, $FormattedLabel
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
            $TDSubgraphIcon = '<TD valign="BOTTOM" ALIGN="{0}" colspan="{1}" fixedsize="true" width="{3}" height="{4}"><IMG src="{2}"></IMG></TD>' -f $Align, $columnSize, $Icon, $IconWidth, $IconHeight
            $TDSubgraph = '<TD valign="TOP" ALIGN="{0}" colspan="{1}">{2}</TD>' -f $Align, $columnSize, $FormattedLabel

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
            $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}">{2}</TD>' -f $Align, $columnSize, $FormattedLabel
            if ($LabelPos -eq 'down') {
                $TR += '<TR>{0}</TR>' -f $TDSubgraph
            } else {
                $TRTemp = '<TR>{0}</TR>' -f $TDSubgraph
                $TRTemp += $TR
                $TR = $TRTemp
            }
        }
    }

    if ($IconDebug) {
        if ($TableStyle) {
            if ($NodeObject) {
                $HTML = '<TABLE BGColor="{0}" STYLE="{1}" COLOR="red" border="1" cellborder="1" cellpadding="{2}">{3}</TABLE>' -f $TableBackgroundColor, $TableStyle, $CellPadding, $TR

                Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

            } else {
                '<TABLE BGColor="{0}" STYLE="{1}" COLOR="red" border="1" cellborder="1" cellpadding="{2}">{3}</TABLE>' -f $TableBackgroundColor, $TableStyle, $CellPadding, $TR
            }

        } else {
            if ($NodeObject) {
                $HTML = '<TABLE BGColor="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{1}">{2}</TABLE>' -f $TableBackgroundColor, $CellPadding, $TR

                Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

            } else {
                '<TABLE BGColor="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{1}">{2}</TABLE>' -f $TableBackgroundColor, $CellPadding, $TR
            }
        }
    } else {
        if ($TableStyle) {
            if ($NodeObject) {
                $HTML = '<TABLE BGColor="{0}" COLOR="{5}" STYLE="{4}" border="{1}" cellborder="{2}" cellpadding="{7}" cellspacing="{6}">{3}</TABLE>' -f $TableBackgroundColor, $tableBorder, $cellBorder, $TR, $TableStyle, $TableBorderColor, $CellSpacing, $CellPadding

                Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

            } else {
                '<TABLE BGColor="{0}" COLOR="{5}" STYLE="{4}" border="{1}" cellborder="{2}" cellpadding="{7}" cellspacing="{6}">{3}</TABLE>' -f $TableBackgroundColor, $tableBorder, $cellBorder, $TR, $TableStyle, $TableBorderColor, $CellSpacing, $CellPadding
            }
        } else {
            if ($NodeObject) {
                $HTML = '<TABLE BGColor="{0}" COLOR="{4}" border="{1}" cellborder="{2}" cellpadding="{6}" cellspacing="{5}">{3}</TABLE>' -f $TableBackgroundColor, $tableBorder, $cellBorder, $TR, $TableBorderColor, $CellSpacing, $CellPadding

                Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

            } else {
                '<TABLE BGColor="{0}" COLOR="{4}" border="{1}" cellborder="{2}" cellpadding="{6}" cellspacing="{5}">{3}</TABLE>' -f $TableBackgroundColor, $tableBorder, $cellBorder, $TR, $TableBorderColor, $CellSpacing, $CellPadding
            }
        }
    }
}