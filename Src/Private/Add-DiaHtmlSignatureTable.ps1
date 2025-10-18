function Add-DiaHtmlSignatureTable {
    <#
    .SYNOPSIS
        Converts a string array to an HTML table for use in a Signature table.

    .DESCRIPTION
        The Add-DiaHtmlSignatureTable function generates an HTML table representation from a string array, suitable for use as a Signature table, such as in GraphViz labels. It supports customization of table appearance, cell formatting, font styles, and inclusion of a logo image from a provided hashtable. The function also offers debug mode and various style options.

    .PARAMETER Rows
        An array of strings/objects to place in the table rows.

    .PARAMETER Align
        Alignment of content inside table cells. Default is 'Center'.

    .PARAMETER TableBorder
        The table border thickness. Default is 0.

    .PARAMETER CellBorder
        The table cell border thickness. Default is 0.

    .PARAMETER CellSpacing
        The table cell spacing. Default is 5.

    .PARAMETER CellPadding
        The table cell padding space. Default is 5.

    .PARAMETER fontSize
        The text font size used inside the cell. Default is 14.

    .PARAMETER fontName
        The text font name used inside the cell. Default is "Segoe Ui".

    .PARAMETER fontColor
        The text font color used inside the cell. Default is "#000000".

    .PARAMETER ImagesObj
        Hashtable mapping IconName to IconPath. Required for logo image support.

    .PARAMETER IconDebug
        Enables table debug mode, highlighting table borders and logo cell.

    .PARAMETER TableStyle
        Sets the table style (e.g., "ROUNDED", "RADIAL", "SOLID", "INVISIBLE", "INVIS", "DOTTED", "DASHED"). Styles can be combined.

    .PARAMETER NoFontBold
        Disables bold formatting for additional node info text.

    .PARAMETER Label
        Sets the SubGraph label.

    .PARAMETER Logo
        Icon name used to represent the node type, resolved from ImagesObj.

    .PARAMETER TableBorderColor
        Sets the subgraph table border color. Default is "#000000".

    .OUTPUTS
        [System.String] - Returns the generated HTML table as a string.

    .EXAMPLE
        Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows "Author: Bugs Bunny", "Company: ACME Inc." -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -DraftMode:$DraftMode

    .NOTES
        Version:        0.2.30
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
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
        [string] $fontName = "Segoe Ui",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font color'
        )]
        [string] $fontColor = "#000000",
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the Image Hashtable Object'
        )]
        [Hashtable] $ImagesObj = @{},
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enable the icon debug mode'
        )]
        [Alias("DraftMode")]
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
            '<TABLE STYLE="{0}" COLOR="red" border="{1}" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="{2}" colspan="1" rowspan="4">Logo</TD></TR>{3}</TABLE>' -f $TableStyle, $tableBorder, $Align, $TR
        } else {
            '<TABLE STYLE="{0}" border="{1}" cellborder="{2}" cellpadding="{6}"><TR><TD fixedsize="true" width="80" height="80" ALIGN="{3}" colspan="1" rowspan="4"><img src="{4}"/></TD></TR>{5}</TABLE>' -f $TableStyle, $tableBorder, $cellBorder, $Align, $Icon, $TR, $CellPadding
        }
    } else {
        if ($IconDebug) {
            '<TABLE STYLE="{1}" COLOR="red" border="1" cellborder="1" cellpadding="{2}">{0}</TABLE>' -f $TR, $TableStyle, $CellPadding
        } else {
            '<TABLE COLOR="{4}" STYLE="{3}" border="{0}" cellborder="{1}" cellpadding="{6}" cellspacing="{5}">{2}</TABLE>' -f $tableBorder, $cellBorder, $TR, $TableStyle, $TableBorderColor, $CellSpacing, $CellPadding
        }
    }
}