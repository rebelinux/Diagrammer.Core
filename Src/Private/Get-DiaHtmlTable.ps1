Function Get-DiaHTMLTable {
    <#
    .SYNOPSIS
        Function to convert a string array to a HTML Table with Graphviz Nodes split by Columns (No Icons)
    .DESCRIPTION
        Takes an array and converts it to a HTML table used for GraphViz Node label
    .Example
        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
        Get-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -ColumnSize 2 -MultiColunms
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
        Version:        0.2.1
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .PARAMETER Rows
        An array of strings/objects to place in this record
    .PARAMETER Align
        Align content inside table cell
    .PARAMETER TableBorder
        The table line border
    .PARAMETER CellBorder
        The table cell border
    .PARAMETER FontSize
        The text fornt size used inside the cell
    .PARAMETER Logo
        Icon used to draw the node type
    .PARAMETER ColumnSize
        This number is used to specified how to split the object inside the HTML table.
        Used in conjunction with MultiColunms
    .PARAMETER MultiColunms
        Split the object into a HTML table with custom ColumnSize
    .PARAMETER ImagesObj
        Hashtable with the IconName > IconPath translation
    .PARAMETER IconDebug
        Set the table debug mode
    .PARAMETER TableStyle
        Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
        styles can be combines ("rounded,dashed")
    #>
    param(
        [string[]] $Rows,
        [string] $Align = 'center',
        [int] $TableBorder = 0,
        [int] $CellBorder = 0,
        [int] $FontSize = 14,
        [string] $Logo,
        [Switch] $MultiColunms,
        [int] $ColumnSize = 2,
        [Hashtable] $ImagesObj = @{},
        [bool] $IconDebug,
        [string] $TableStyle = "rounded,dashed",
        [Switch] $NoFontBold
    )

    if ($MultiColunms) {
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

        if ($IconDebug) {
            return '<TABLE COLOR="red" border="1" cellborder="1" cellpadding="5">{0}</TABLE>' -f $TR
        } else {
            return '<TABLE border="0" cellborder="0" cellpadding="5">{0}</TABLE>' -f $TR
        }

    } else {
        if ($ImagesObj[$Logo]) {
            $ICON = $ImagesObj[$Logo]
        } else { $ICON = $false }

        $TR = ''
        foreach ($r in $Rows) {
            Write-Verbose "Creating Node: $r"
            if ($NoFontBold) {
                $TR += '<TR><TD valign="top" align="{0}" colspan="2"><FONT POINT-SIZE="{1}">{2}</FONT></TD></TR>' -f $Align, $FontSize, $r
            } else {
                $TR += '<TR><TD valign="top" align="{0}" colspan="2"><B><FONT POINT-SIZE="{1}">{2}</FONT></B></TD></TR>' -f $Align, $FontSize, $r
            }
        }

        if (!$ICON) {
            return '<TABLE STYLE="{0}" border="{1}" cellborder="{2}" cellpadding="5">{3}</TABLE>' -f $TableStyle ,$TableBorder, $CellBorder, $TR
        } elseif ($IconDebug) {
            return '<TABLE STYLE="{0}" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="center" colspan="1" rowspan="4">Logo</TD></TR>{1}</TABLE>' -f $TableStyle, $TR

        } else {
            return '<TABLE STYLE="{0}" border="{1}" cellborder="{2}" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="{3}" colspan="1" rowspan="4"><img src="{4}"/></TD></TR>{5}</TABLE>' -f $TableStyle, $TableBorder, $CellBorder, $Align, $Icon, $TR
        }
    }
}