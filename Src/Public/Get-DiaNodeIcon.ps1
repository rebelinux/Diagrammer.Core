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
        Version:        0.1.7
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .PARAMETER Name
        The string to process
    .PARAMETER Align
        Align content inside table cell
    .PARAMETER Rows
        Object used to specified aditional node information
    .PARAMETER IconType
        Icon used to draw the node type
    #>

    [CmdletBinding()]
    [OutputType([System.String])]

    param(
        [hashtable[]]$Rows,
        [string]$IconType,
        [String]$Name,
        [String]$Align,
        [Hashtable] $ImagesObj = @{},
        [bool] $URLIcon
    )


    if ($IconType -eq 'NoIcon') {
        $ICON = 'NoIcon'
    } elseif ($ImagesObj[$IconType]) {
        $ICON = $ImagesObj[$IconType]
    } else { $ICON = "no_icon.png" }

    $TR = @()
    foreach ($r in $Rows) {
        $TR += $r.getEnumerator() | ForEach-Object { "<TR><TD align='$Align' colspan='1'><FONT POINT-SIZE='14'>$($_.Key): $($_.Value)</FONT></TD></TR>" }
    }

    if ($URLIcon) {
        if ($ICON -ne 'NoIcon') {
            if ($Align -eq "Center") {
                "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' colspan='1'>ICON</TD></TR><TR><TD align='$Align'><B>$Name</B></TD></TR>$TR</TABLE>"
            } else {
                "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'>ICON</TD></TR><TR><TD align='$Align'><B> $Name</B></TD></TR> $TR</TABLE>"
            }
        } else {
            if ($Align -eq "Center") {
                "<TABLE color='red' border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B>$Name</B></TD></TR>$TR</TABLE>"
            } else {
                "<TABLE color='red' border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'></TD></TR><TR><TD align='$Align'><B> $Name</B></TD></TR> $TR</TABLE>"
            }
        }
    } else {
        if ($ICON -ne 'NoIcon') {
            if ($Align -eq "Center") {
                "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><B>$Name</B></TD></TR>$TR</TABLE>"
            } else {
                "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><B> $Name</B></TD></TR> $TR</TABLE>"
            }
        } else {
            if ($Align -eq "Center") {
                "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B>$Name</B></TD></TR>$TR</TABLE>"
            } else {
                "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='0'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'></TD></TR><TR><TD align='$Align'><B> $Name</B></TD></TR> $TR</TABLE>"
            }
        }
    }

}