Function Get-DiaHTMLNodeTable {
    <#
    .SYNOPSIS
        Function to convert a array to a HTML Table. Graphviz Nodes split by Columns (Includes Icons)
    .DESCRIPTION
        Takes an array and converts it to a HTML table used for GraphViz Node label
    .Example

        # Array of String *6 Objects*
        $DCsArray = @("Server-dc-01v","Server-dc-02v","Server-dc-03v","Server-dc-04v","Server-dc-05v","Server-dc-06v")

        Get-DiaHTMLNodeTable -inputObject $DCsArray -Columnsize 3 -Align 'Center' -IconType "AD_DC" -MultiIcon -ImagesObj $Images -IconDebug $IconDebug

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
        Version:        0.1.9
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .PARAMETER inputObject
        The array of object to process
    .PARAMETER Align
        Align content inside table cell
    .PARAMETER TableBorder
        The table border line size
    .PARAMETER CellBorder
        The table cell border
    .PARAMETER FontSize
        The cell text font size
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
    #>
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide input object to process'
        )]
        [string[]] $inputObject,
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the icon type'
        )]
        [string] $iconType,
        [Parameter(
            Mandatory = $true,
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
        [int] $tableBorder = 0,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the width of the html cell border'
        )]
        [int] $cellBorder = 0,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font size'
        )]
        [int] $fontSize = 14,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'This value is used to specified a int used to split the object inside the HTML table'
        )]
        [int] $columnSize = 1,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Used inside Graphviz to modify the head or tail of an edge, so that the end attaches directly to the object'
        )]
        [string] $Port = "EdgeDot",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Used inside Graphviz to modify the head or tail of an edge, so that the end attaches directly to the object'
        )]
        [Switch]$MultiIcon,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enable the icon debug mode'
        )]
        [bool] $IconDebug,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Hashtable used to add more information to the table elements (Not yet implemented)'
        )]
        [hashtable[]]$AditionalInfo
    )

    if ($inputObject.Count -le 1) {
        $Group = $inputObject
    } else {
        $Group = Split-array -inArray $inputObject -size $columnSize
    }

    if ($AditionalInfo) {
        $Filter = $AditionalInfo.keys | Select-Object -Unique
        $RowsGroupHTs = @()

        foreach ($RepoObj in ($Filter | Sort-Object)) {
            $RowsGroupHTs += @{
                $RepoObj = $AditionalInfo.$RepoObj
            }
        }
    }

    if ($ImagesObj[$iconType]) {
        $Icon = $ImagesObj[$iconType]
    } else { $Icon = $false }

    $Number = 0

    if ($Icon) {
        if ($IconDebug) {
            if ($MultiIcon) {
                while ($Number -ne $Group.Count) {
                    foreach ($Element in $Group[$Number]) {
                        $TDICON += '<TD ALIGN="{0}" colspan="1">ICON</TD>' -f $Align
                    }
                    $TR += '<TR>{0}</TR>' -f $TDICON
                    $TDICON = ''

                    foreach ($Element in $Group[$Number]) {
                        $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1"><FONT POINT-SIZE="{2}">{3}</FONT></TD>' -f $Element, $Align, $FontSize, $Element
                    }
                    $TR += '<TR>{0}</TR>' -f $TDName
                    $TDName = ''

                    if ($AditionalInfo) {
                        if (($RowsGroupHTs.Keys.Count -le 1 ) -and ($RowsGroupHTs.Values.Count -le 1) -and ($inputObject.Count -le 1)) {
                            # $RowsGroupHT is Single key with Single Values
                            #  Keys: Path - Values: C:\Backup
                            #
                            foreach ($Element in $RowsGroupHTs[$Number]) {
                                $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$Element.Keys, [string]$Element.values
                            }

                            $TR += '<TR>{0}</TR>' -f $TDInfo
                            $TDInfo = ''
                        } elseif (($RowsGroupHTs.Keys.Count -gt 1) -and ($RowsGroupHTs.Values.Count -gt 1) -and ($inputObject.Count -le 1)) {
                            # $RowsGroupHT is Multiple key and each key have a Single Values
                            #  Keys:        Values:
                            #       Path:          C:\Backup
                            #       OBjStor:       True
                            #

                            foreach ($RowsGroupHT in $RowsGroupHTs) {
                                foreach ($Element in $RowsGroupHT) {
                                    $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$Element.Keys, [string]$Element.Values
                                }
                                $TR += '<TR>{0}</TR>' -f $TDInfo
                                $TDInfo = ''
                            }

                        } else {
                            # $RowsGroupHT is Single key and each key have Multiple Values
                            #  Keys: Path - Values: {C:\Backup, F:\Backup}
                            #
                            foreach ($RowsGroupHT in $RowsGroupHTs) {
                                $RowsGroup = Split-array -inArray ($RowsGroupHT.GetEnumerator() | ForEach-Object { $_.value }) -size $columnSize
                                foreach ($Element in $RowsGroup[$Number]) {
                                    $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$RowsGroupHT.Keys, [string]$Element
                                }
                                $TR += '<TR>{0}</TR>' -f $TDInfo
                                $TDInfo = ''
                            }
                        }
                    }

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

                    if ($AditionalInfo) {
                        if (($RowsGroupHTs.Keys.Count -le 1 ) -and ($RowsGroupHTs.Values.Count -le 1) -and ($inputObject.Count -le 1)) {
                            # $RowsGroupHT is Single key with Single Values
                            #  Keys: Path - Values: C:\Backup
                            #
                            foreach ($Element in $RowsGroupHTs[$Number]) {
                                $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$Element.Keys, [string]$Element.values
                            }

                            $TR += '<TR>{0}</TR>' -f $TDInfo
                            $TDInfo = ''
                        } elseif (($RowsGroupHTs.Keys.Count -gt 1) -and ($RowsGroupHTs.Values.Count -gt 1) -and ($inputObject.Count -le 1)) {
                            # $RowsGroupHT is Multiple key and each key have a Single Values
                            #  Keys:        Values:
                            #       Path:          C:\Backup
                            #       OBjStor:       True
                            #

                            foreach ($RowsGroupHT in $RowsGroupHTs) {
                                foreach ($Element in $RowsGroupHT) {
                                    $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$Element.Keys, [string]$Element.Values
                                }
                                $TR += '<TR>{0}</TR>' -f $TDInfo
                                $TDInfo = ''
                            }

                        } else {
                            # $RowsGroupHT is Single key and each key have Multiple Values
                            #  Keys: Path - Values: {C:\Backup, F:\Backup}
                            #
                            foreach ($RowsGroupHT in $RowsGroupHTs) {
                                $RowsGroup = Split-array -inArray ($RowsGroupHT.GetEnumerator() | ForEach-Object { $_.value }) -size $columnSize
                                foreach ($Element in $RowsGroup[$Number]) {
                                    $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$RowsGroupHT.Keys, [string]$Element
                                }
                                $TR += '<TR>{0}</TR>' -f $TDInfo
                                $TDInfo = ''
                            }
                        }
                    }

                    $Number++
                }
            }
        } else {
            if ($MultiIcon) {
                while ($Number -ne $Group.Count) {
                    foreach ($Element in $Group[$Number]) {
                        $TDICON += '<TD ALIGN="{0}" colspan="1"><img src="{1}"/></TD>' -f $Align, $Icon
                    }
                    $TR += '<TR>{0}</TR>' -f $TDICON
                    $TDICON = ''

                    foreach ($Element in $Group[$Number]) {
                        $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1"><FONT POINT-SIZE="{2}"><B>{3}</B></FONT></TD>' -f $Element, $Align, $FontSize, $Element
                    }
                    $TR += '<TR>{0}</TR>' -f $TDName
                    $TDName = ''

                    if ($AditionalInfo) {
                        if (($RowsGroupHTs.Keys.Count -le 1 ) -and ($RowsGroupHTs.Values.Count -le 1) -and ($inputObject.Count -le 1)) {
                            # $RowsGroupHT is Single key with Single Values
                            #  Keys: Path - Values: C:\Backup
                            #
                            foreach ($Element in $RowsGroupHTs[$Number]) {
                                $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$Element.Keys, [string]$Element.values
                            }

                            $TR += '<TR>{0}</TR>' -f $TDInfo
                            $TDInfo = ''
                        } elseif (($RowsGroupHTs.Keys.Count -gt 1) -and ($RowsGroupHTs.Values.Count -gt 1) -and ($inputObject.Count -le 1)) {
                            # $RowsGroupHT is Multiple key and each key have a Single Values
                            #  Keys:        Values:
                            #       Path:          C:\Backup
                            #       OBjStor:       True
                            #

                            foreach ($RowsGroupHT in $RowsGroupHTs) {
                                foreach ($Element in $RowsGroupHT) {
                                    $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$Element.Keys, [string]$Element.Values
                                }
                                $TR += '<TR>{0}</TR>' -f $TDInfo
                                $TDInfo = ''
                            }

                        } else {
                            # $RowsGroupHT is Single key and each key have Multiple Values
                            #  Keys: Path - Values: {C:\Backup, F:\Backup}
                            #
                            foreach ($RowsGroupHT in $RowsGroupHTs) {
                                $RowsGroup = Split-array -inArray ($RowsGroupHT.GetEnumerator() | ForEach-Object { $_.value }) -size $columnSize
                                foreach ($Element in $RowsGroup[$Number]) {
                                    $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$RowsGroupHT.Keys, [string]$Element
                                }
                                $TR += '<TR>{0}</TR>' -f $TDInfo
                                $TDInfo = ''
                            }
                        }
                    }

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

                    if ($AditionalInfo) {
                        if (($RowsGroupHTs.Keys.Count -le 1 ) -and ($RowsGroupHTs.Values.Count -le 1) -and ($inputObject.Count -le 1)) {
                            # $RowsGroupHT is Single key with Single Values
                            #  Keys: Path - Values: C:\Backup
                            #
                            foreach ($Element in $RowsGroupHTs[$Number]) {
                                $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$Element.Keys, [string]$Element.values
                            }

                            $TR += '<TR>{0}</TR>' -f $TDInfo
                            $TDInfo = ''
                        } elseif (($RowsGroupHTs.Keys.Count -gt 1) -and ($RowsGroupHTs.Values.Count -gt 1) -and ($inputObject.Count -le 1)) {
                            # $RowsGroupHT is Multiple key and each key have a Single Values
                            #  Keys:        Values:
                            #       Path:          C:\Backup
                            #       OBjStor:       True
                            #

                            foreach ($RowsGroupHT in $RowsGroupHTs) {
                                foreach ($Element in $RowsGroupHT) {
                                    $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$Element.Keys, [string]$Element.Values
                                }
                                $TR += '<TR>{0}</TR>' -f $TDInfo
                                $TDInfo = ''
                            }

                        } else {
                            # $RowsGroupHT is Single key and each key have Multiple Values
                            #  Keys: Path - Values: {C:\Backup, F:\Backup}
                            #
                            foreach ($RowsGroupHT in $RowsGroupHTs) {
                                $RowsGroup = Split-array -inArray ($RowsGroupHT.GetEnumerator() | ForEach-Object { $_.value }) -size $columnSize
                                foreach ($Element in $RowsGroup[$Number]) {
                                    $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$RowsGroupHT.Keys, [string]$Element
                                }
                                $TR += '<TR>{0}</TR>' -f $TDInfo
                                $TDInfo = ''
                            }
                        }
                    }

                    $Number++
                }
            }
        }
    } else {
        throw "Error: $IconType IconType not found in Images object"

    }

    if ($IconDebug) {
        return '<TABLE PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="5">{1}</TABLE>' -f $Port, $TR
    } else {
        return '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellpadding="5">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR
    }
}
