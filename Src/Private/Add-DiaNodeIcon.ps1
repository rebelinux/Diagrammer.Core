function Add-DiaNodeIcon {
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
        Add-DiaNodeIcon -Name $DC -IconType "ForestRoot" -Align "Center" -Rows $DCRows
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
        Version:        0.2.29
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux

    Specifies the name of the node to process.

    .PARAMETER Align
        Specifies the alignment of the content inside the table cell. Acceptable values are 'Center', 'Right', or 'Left'. Default is 'Center'.

    .PARAMETER AditionalInfo
        A hashtable or ordered hashtable containing additional information about the node. This data is displayed as extra rows in the table.

    .PARAMETER CellBorder
        Specifies the width of the HTML cell border. Default is 0.

    .PARAMETER CellPadding
        Specifies the padding inside the HTML table cells. Default is 5.

    .PARAMETER CellSpacing
        Specifies the spacing between HTML table cells. Default is 5.

    .PARAMETER FontSize
        Specifies the font size for the text inside the table. Default is 14.

    .PARAMETER IconDebug
        If set to $true, enables debug mode for icons, highlighting the table border in red for troubleshooting.

    .PARAMETER IconType
        Specifies the type of icon to use for the node. This parameter is required.

    .PARAMETER ImagesObj
        A hashtable mapping icon types to their corresponding image paths. Used to resolve the icon image for the node.

    .PARAMETER Name
        The name of the node to display in the table. This parameter is required.

    .PARAMETER NoFontBold
        If specified, disables bold font for the text inside the table.

    .PARAMETER TableBorder
        Specifies the width of the HTML table border. Default is 0.

    .PARAMETER TableBackgroundColor
        Allow to set a table background color (Hex format EX: #FFFFFF).

    .PARAMETER CellBackgroundColor
        Allow to set a cell background color (Hex format EX: #FFFFFF).
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'A hashtable array containing additional information about the node.'
        )]
        [Alias("RowsOrdered", "Rows")]
        $AditionalInfo,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the alignment of the content inside the table cell. Acceptable values are Center, Right, or Left.'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Center', 'Right', 'Left')]
        [string] $Align = 'Center',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the width of the HTML cell border.'
        )]
        [int] $CellBorder = 0,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the padding inside the HTML table cells.'
        )]
        [int] $CellPadding = 5,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the spacing between HTML table cells.'
        )]
        [int] $CellSpacing = 5,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the font size for the text inside the table.'
        )]
        [int] $FontSize = 14,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Specifies the type of icon to use for the node.'
        )]
        [string]$IconType,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'A hashtable containing mappings of icon types to their corresponding image paths.'
        )]
        [Hashtable] $ImagesObj = @{},

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enables debug mode for icons, highlighting the table in red.'
        )]
        [bool] $IconDebug = $false,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Specifies the name of the node.'
        )]
        [String]$Name,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Disables bold font for the text inside the table.'
        )]
        [Switch] $NoFontBold,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the width of the HTML table border.'
        )]
        [int] $TableBorder = 0,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table background color'
        )]
        [string] $TableBackgroundColor,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a cell background color'
        )]
        [string] $CellBackgroundColor
    )

    # Todo set the rowspan value dinamically
    # $rowspan = 0

    if ($IconType -eq 'NoIcon') {
        $ICON = 'NoIcon'
    } elseif ($ImagesObj[$IconType]) {
        $ICON = $ImagesObj[$IconType]
    } else { $ICON = "no_icon.png" }

    $TR = @()

    if ($AditionalInfo) {
        switch ($AditionalInfo.GetType().Name) {
            'Hashtable' {
                foreach ($r in $AditionalInfo) {
                    $TR += $r.getEnumerator() | ForEach-Object { "<TR><TD align='$Align' colspan='1'><FONT POINT-SIZE='$FontSize'>$($_.Key): $($_.Value)</FONT></TD></TR>" }
                }
            }

            'OrderedDictionary' {
                foreach ($r in $AditionalInfo) {
                    $TR += $r.getEnumerator() | ForEach-Object { "<TR><TD align='$Align' colspan='1'><FONT POINT-SIZE='$FontSize'>$($_.Key): $($_.Value)</FONT></TD></TR>" }
                }
            }

            'PSCustomObject' {
                foreach ($r in $AditionalInfo) {
                    $TR += $r.PSObject.Properties | ForEach-Object { "<TR><TD align='$Align' colspan='1'><FONT POINT-SIZE='$FontSize'>$($_.Name): $($_.Value)</FONT></TD></TR>" }
                }
            }

            'Object[]' {
                foreach ($r in $AditionalInfo) {
                    $TR += $r.PSObject.Properties | ForEach-Object { "<TR><TD align='$Align' colspan='1'><FONT POINT-SIZE='$FontSize'>$($_.Name): $($_.Value)</FONT></TD></TR>" }
                }
            }
        }
    }

    if ($IconDebug) {
        if ($ICON -ne 'NoIcon') {
            if ($Align -eq "Center") {
                if ($NoFontBold) {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD bgcolor='#FFCCCC' ALIGN='$Align' colspan='1'>ICON</TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD bgcolor='#FFCCCC' ALIGN='$Align' colspan='1'>ICON</TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                }
            } else {
                if ($NoFontBold) {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD bgcolor='#FFCCCC' ALIGN='$Align' rowspan='4' valign='Bottom'>ICON</TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD bgcolor='#FFCCCC' ALIGN='$Align' rowspan='4' valign='Bottom'>ICON</TD></TR><TR><TD align='$Align'><B> <FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                }
            }
        } else {
            if ($Align -eq "Center") {
                if ($NoFontBold) {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                }
            } else {
                if ($NoFontBold) {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                }
            }
        }
    } else {
        if ($ICON -ne 'NoIcon') {
            if ($Align -eq "Center") {
                if ($NoFontBold) {
                    if ($TableBackgroundColor) {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding' bgcolor='$TableBackgroundColor'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"

                    } elseif ($CellBackgroundColor) {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD bgcolor='$CellBackgroundColor' align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                    } else {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                    }
                } else {
                    if ($TableBackgroundColor) {
                        "<TABLE bgcolor='$TableBackgroundColor' border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                    } elseif ($CellBackgroundColor) {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD bgcolor='$CellBackgroundColor' align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                    } else {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                    }
                }
            } else {
                if ($NoFontBold) {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                }
            }
        } else {
            if ($Align -eq "Center") {
                if ($NoFontBold) {
                    if ($TableBackgroundColor) {
                        "<TABLE bgcolor='$TableBackgroundColor' border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                    } elseif ($CellBackgroundColor) {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD bgcolor='$CellBackgroundColor' align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                    } else {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                    }
                } else {
                    if ($TableBackgroundColor) {
                        "<TABLE bgcolor='$TableBackgroundColor' border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                    } elseif ($CellBackgroundColor) {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD bgcolor='$CellBackgroundColor' align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"

                    } else {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                    }
                }
            } else {
                if ($NoFontBold) {
                    if ($TableBackgroundColor) {
                        "<TABLE bgcolor='$TableBackgroundColor' border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                    } elseif ($CellBackgroundColor) {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD bgcolor='$CellBackgroundColor' align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                    } else {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                    }
                } else {
                    if ($TableBackgroundColor) {
                        "<TABLE bgcolor='$TableBackgroundColor' border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                    } elseif ($CellBackgroundColor) {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD bgcolor='$CellBackgroundColor' align='$Align'><B><FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                    } else {
                        "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                    }
                }
            }
        }
    }

}