Function Get-DiaHTMLNodeTable {
    <#
    .SYNOPSIS
        Function to convert a array to a HTML Table. Graphviz Nodes split by Columns (Includes Icons)
    .DESCRIPTION
        Takes an array and converts it to a HTML table used for GraphViz Node label
    .Example

        # Array of String *6 Objects*
        $DCsArray = @("Server-dc-01v","Server-dc-02v","Server-dc-03v","Server-dc-04v","Server-dc-05v","Server-dc-06v")

        Get-DiaHTMLNodeTable -inputObject $DCsArray -Columnsize 3 -Align 'Center' -IconType "AD_DC" -MultiIcon -ImagesObj $Images -URLIcon $URLIcon

        ________________________________ _______________
        |               |               |               |
        |      Icon     |     Icon      |      Icon     |
        ________________________________|_______________|
        |               |               |               |
        | Server-DC-01V | Server-DC-02V | Server-DC-02V |
        ________________________________|________________
        ________________________________ _______________
        |               |               |               |
        |      Icon     |     Icon      |      Icon     |
        ________________________________|_______________|
        |               |               |               |
        | Server-DC-04V | Server-DC-05V | Server-DC-06V |
        ________________________________|________________

    .NOTES
        Version:        0.1.7
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .PARAMETER inputObject
        The array of object to processn
    .PARAMETER Align
        Align content inside table cell
    .PARAMETER TableBorder
        The table border line
    .PARAMETER CellBorder
        The table cell border
    .PARAMETER FontSize
        The cell text font size
    .PARAMETER IconType
        Node Icon type
    .PARAMETER ColumnSize
        This value is used to specified how to split the object inside the HTML table
    .PARAMETER Port
        Used inside Graphviz to draw the edge between nodes
    #>
    param(
        [string[]] $inputObject,
        [string] $Align = 'Center',
        [int] $tableBorder = 0,
        [int] $cellBorder = 0,
        [int] $fontSize = 14,
        [string] $iconType,
        [int] $columnSize = 1,
        [string] $Port = "EdgeDot",
        [Switch]$MultiIcon,
        [Hashtable] $ImagesObj,
        [bool] $URLIcon,
        [hashtable[]]$Rows
    )

    if ($inputObject.Count -le 1) {
        $Group = $inputObject
    } else {
        $Group = Split-array -inArray $inputObject -size $columnSize
    }

    if ($ImagesObj[$iconType]) {
        $Icon = $ImagesObj[$iconType]
    } else { $Icon = $false }

    $Number = 0

    if ($Icon) {
        if ($URLIcon) {
            if ($MultiIcon) {
                while ($Number -ne $Group.Count) {
                    foreach ($Element in $Group[$Number]) {
                        $TDICON += '<TD ALIGN="{0}" colspan="1">ICON</TD>' -f $Align
                    }
                    foreach ($Element in $Group[$Number]) {
                        $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1"><FONT POINT-SIZE="{2}">{3}</FONT></TD>' -f $Element, $Align, $FontSize, $Element
                    }

                    $TR += '<TR>{0}</TR>' -f $TDICON
                    $TR += '<TR>{0}</TR>' -f $TDName

                    $TDICON = ''
                    $TDName = ''
                    $Number++
                }
            } else {

                $TDICON += '<TD ALIGN="{0}" colspan="{1}">ICON</TD>' -f $Align, $inputObject.Count

                $TR += '<TR>{0}</TR>' -f $TDICON

                while ($Number -ne $Group.Count) {
                    foreach ($Element in $Group[$Number]) {
                        $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1"><FONT POINT-SIZE="{2}">{3}</FONT></TD>' -f $Element, $Align, $FontSize, $Element
                    }

                    $TR += '<TR>{0}</TR>' -f $TDName

                    $TDName = ''
                    $Number++
                }
            }
        } else {
            if ($MultiIcon) {
                while ($Number -ne $Group.Count) {
                    foreach ($Element in $Group[$Number]) {
                        $TDICON += '<TD ALIGN="{0}" colspan="1"><img src="{1}"/></TD>' -f $Align, $Icon
                    }
                    foreach ($Element in $Group[$Number]) {
                        $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1"><FONT POINT-SIZE="{2}">{3}</FONT></TD>' -f $Element, $Align, $FontSize, $Element
                    }

                    $TR += '<TR>{0}</TR>' -f $TDICON
                    $TR += '<TR>{0}</TR>' -f $TDName

                    $TDICON = ''
                    $TDName = ''
                    $Number++
                }
            } else {

                $TDICON += '<TD ALIGN="{0}" colspan="{1}"><img src="{2}"/></TD>' -f $Align, $inputObject.Count, $Icon

                $TR += '<TR>{0}</TR>' -f $TDICON

                while ($Number -ne $Group.Count) {
                    foreach ($Element in $Group[$Number]) {
                        $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1"><FONT POINT-SIZE="{2}">{3}</FONT></TD>' -f $Element, $Align, $FontSize, $Element
                    }

                    $TR += '<TR>{0}</TR>' -f $TDName

                    $TDName = ''
                    $Number++
                }
            }
        }
    }

    if ($URLIcon) {
        return '<TABLE PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="5">{1}</TABLE>' -f $Port, $TR
    } else {
        return '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellpadding="5">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR
    }
}