Function Get-DiaNodeIcon {
    <#
    .SYNOPSIS
        Function to convert a Graphviz node label to a HTML Table with Icon
    .DESCRIPTION
        Takes a string and converts it to a HTML table used for GraphViz Node label
    .Example
        $DC = "Server-DC-01v"
        $DCRows = @{
            Memory = "4GB"
            CPU = "2"
        }
        Get-DiaNodeIcon -Name $DC -IconType "ForestRoot" -Align "Center" -Rows $DCRows
                    _________________
                    |               |
                    |      Icon     |
                    _________________
                    |               |
                    | Server-DC-01V |
                    _________________
                    |               |
                    |    CPU = 2    |
                    | Memory = 4GB  |
                    _________________
    .NOTES
        Version:        0.2.15
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .PARAMETER Name
        The string to process
    .PARAMETER Align
        Align content inside table cell
    .PARAMETER Rows
        Object used to specified aditional node information
    .PARAMETER RowsOrdered
        Object used to specified aditional node information (Ordered)
    .PARAMETER IconType
        Icon used to draw the node type
    .PARAMETER ImagesObj
        Hashtable with the IconName > IconPath translation
    #>

    [CmdletBinding()]
    [OutputType([System.String])]

    param(
        [hashtable[]]$Rows,
        [PSCustomObject[]]$RowsOrdered,
        [string]$IconType,
        [String]$Name,
        [String]$Align = 'Center',
        [Hashtable] $ImagesObj = @{},
        [bool] $IconDebug,
        [int] $TableBorder = 0,
        [int] $CellBorder = 0,
        [int] $FontSize = 14,
        [Switch] $NoFontBold
    )


    if ($IconType -eq 'NoIcon') {
        $ICON = 'NoIcon'
    } elseif ($ImagesObj[$IconType]) {
        $ICON = $ImagesObj[$IconType]
    } else { $ICON = "no_icon.png" }

    $TR = @()
    if (-Not $RowsOrdered) {
        foreach ($r in $Rows) {
            $TR += $r.getEnumerator() | ForEach-Object { "<TR><TD align='$Align' colspan='1'><FONT POINT-SIZE='$FontSize'>$($_.Key): $($_.Value)</FONT></TD></TR>" }
        }
    } else {
        foreach ($r in $RowsOrdered) {
            $TR += $r.PSObject.Properties  | ForEach-Object { "<TR><TD align='$Align' colspan='1'><FONT POINT-SIZE='$FontSize'>$($_.Name): $($_.Value)</FONT></TD></TR>" }
        }
    }

    if ($IconDebug) {
        if ($ICON -ne 'NoIcon') {
            if ($Align -eq "Center") {
                if ($NoFontBold) {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' colspan='1'>ICON</TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' colspan='1'>ICON</TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                }
            } else {
                if ($NoFontBold) {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'>ICON</TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'>ICON</TD></TR><TR><TD align='$Align'><B> <FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                }
            }
        } else {
            if ($Align -eq "Center") {
                if ($NoFontBold) {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                }
            } else {
                if ($NoFontBold) {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                }
            }
        }
    } else {
        if ($ICON -ne 'NoIcon') {
            if ($Align -eq "Center") {
                if ($NoFontBold) {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                }
            } else {
                if ($NoFontBold) {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                }
            }
        } else {
            if ($Align -eq "Center") {
                if ($NoFontBold) {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                }
            } else {
                if ($NoFontBold) {
                    "<TABLE border='$TableBorderyyy' cellborder='$CellBorder' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorderyyy' cellborder='$CellBorder' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                }
            }
        }
    }

}