Function Add-DiaHtmlSignatureTable {
    <#
    .SYNOPSIS
        Function to convert a string array to a HTML Table used to create the Signature table
    .DESCRIPTION
        Takes an array and converts it to a HTML table used for GraphViz Node label
    .Example
        $Images = @{
            "Main_Logo" = "Diagrammer.png"
            "DomainController" = "AD_DC.png"
            "Subnets" = "AD_Subnets.png"
        }
        $DCsArray = @("Server-dc-01v", "Server-dc-02v", "Server-dc-03v", "Server-dc-04v", "Server-dc-05v", "Server-dc-06v")

        $DCNodes = Add-DiaHTMLNodeTable -ImagesObj $Images -inputObject $DCsArray -columnSize 3 -Align 'Center' -iconType "DomainController" -MultiIcon

        $TableObjects = @($DCNodes)

        Add-DiaHtmlSubGraph -ImagesObj $Images -TableArray $TableObjects -Align "Center" -IconType 'DomainController' -columnSize 1 -Label 'Domain Controllers' -LabelPos 'top' -IconDebug $true
        ____________________________________________________
        | |                      ICON                     | |
        ___________________________________________________ |
        | |                Domain Controllers             | |
        _____________________________________________________
        | |               |               |               | |
        | |      Icon     |     Icon      |      Icon     | |
        __________________________________|_______________| |
        | |               |               |               | |
        | | Server-DC-01V | Server-DC-02V | Server-DC-02V | |
        __________________________________|__________________
        _____________________________________________________
        | |               |               |               | |
        | |      Icon     |     Icon      |      Icon     | |
        __________________________________|_______________| |
        | |               |               |               | |
        | | Server-DC-04V | Server-DC-05V | Server-DC-06V | |
        __________________________________|__________________

    .NOTES
        Version:        0.2.27
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .PARAMETER Row
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
    .PARAMETER NoFontBold
        Disable the node aditionalinfo bold in text
    .PARAMETER Label
        Allow to set SubGraph Label
    .PARAMETER TableStyle
        Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
        styles can be combines ("rounded,dashed")
    .PARAMETER TableBorderColor
        Set the subgraph table border color
    .PARAMETER IconWidth
        Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
        styles can be combines ("rounded,dashed")
    .PARAMETER IconHeight
        Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
        styles can be combines ("rounded,dashed")
    #>

    <#
        TODO
        1. Add Icon to MultiColumns section
        2. Change hardcoded values (FontName, FontColor, FontSize)
        3. Document all parameters
    #>

    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'The table array to process'
        )]
        [string[]] $Rows,
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
            Mandatory = $true,
            HelpMessage = 'Please provide the Image Hashtable Object'
        )]
        [Hashtable] $ImagesObj = @{},
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
            HelpMessage = 'Allow to set a subgraph icon width'
        )]
        [string] $IconWidth,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon height'
        )]
        [string] $IconHeight,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table label'
        )]
        [string]$Label,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the logo icon'
        )]
        [string]$Logo,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table border color'
        )]
        [string]$TableBorderColor = "#000000"
    )

    if ($ImagesObj[$Logo]) {
        $ICON = $ImagesObj[$Logo]
    } else { $ICON = $false }

    $TR = ''
    foreach ($r in $Rows) {
        Write-Verbose -Message "Creating Node: $r"
        if ($NoFontBold) {
            $TR += '<TR><TD valign="top" align="{0}" colspan="2"><FONT POINT-SIZE="{1}">{2}</FONT></TD></TR>' -f $Align, $FontSize, $r
        } else {
            $TR += '<TR><TD valign="top" align="{0}" colspan="2"><B><FONT POINT-SIZE="{1}">{2}</FONT></B></TD></TR>' -f $Align, $FontSize, $r
        }
    }

    if ($ICON) {
        if ($IconDebug) {
            return '<TABLE STYLE="{0}" border="{1}" cellborder="1" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="{2}" colspan="1" rowspan="4">Logo</TD></TR>{3}</TABLE>' -f $TableStyle, $tableBorder, $Align, $TR
        } else {
            return '<TABLE STYLE="{0}" border="{1}" cellborder="{2}" cellpadding="{6}"><TR><TD fixedsize="true" width="80" height="80" ALIGN="{3}" colspan="1" rowspan="4"><img src="{4}"/></TD></TR>{5}</TABLE>' -f $TableStyle, $tableBorder, $cellBorder, $Align, $Icon, $TR, $CellPadding
        }
    } else {
        if ($IconDebug) {
            return '<TABLE STYLE="{1}" COLOR="red" border="1" cellborder="1" cellpadding="{2}">{0}</TABLE>' -f $TR, $TableStyle, $CellPadding
        } else {
            return '<TABLE COLOR="{4}" STYLE="{3}" border="{0}" cellborder="{1}" cellpadding="{6}" cellspacing="{5}">{2}</TABLE>' -f $tableBorder, $cellBorder, $TR, $TableStyle, $TableBorderColor, $CellSpacing, $CellPadding
        }
    }
}