Function Add-DiaNodeIcon {
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
        Version:        0.2.27
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux

    Specifies the name of the node to process.

    .PARAMETER Align
    Specifies the alignment of the content inside the table cell.
    Acceptable values may include alignment options such as 'Left', 'Center', or 'Right'.

    .PARAMETER Rows
    An object containing additional information about the node.
    This can be used to provide supplementary details for the node.

    .PARAMETER RowsOrdered
    An ordered object containing additional information about the node.
    This ensures the information is processed in a specific sequence.

    .PARAMETER IconType
        Node Icon type. This parameter is mandatory if ImagesObj is specified.

    .PARAMETER TableBorder
        The width of the table border line. Default is 0.

    .PARAMETER CellBorder
        The width of the table cell border. Default is 0.

    .PARAMETER CellPadding
        The padding inside the table cell. Default is 5.

    .PARAMETER CellSpacing
        The spacing between table cells. Default is 5.
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
            Mandatory = $true,
            HelpMessage = 'Specifies the type of icon to use for the node.'
        )]
        [string]$IconType,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Specifies the name of the node.'
        )]
        [String]$Name,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the alignment of the content inside the table cell. Acceptable values are Center, Right, or Left.'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Center', 'Right', 'Left')]
        [string] $Align = 'Center',

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
            Mandatory = $false,
            HelpMessage = 'Specifies the font size for the text inside the table.'
        )]
        [int] $FontSize = 14,

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
        [int] $CellSpacing = 5
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
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'>ICON</TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'>ICON</TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                }
            } else {
                if ($NoFontBold) {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'>ICON</TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                } else {
                    "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' rowspan='4' valign='Bottom'>ICON</TD></TR><TR><TD align='$Align'><B> <FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
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
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
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
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'>$Name</FONT></TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'>$Name</FONT></B></TD></TR>$TR</TABLE>"
                }
            } else {
                if ($NoFontBold) {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><FONT POINT-SIZE='$FontSize'> $Name</FONT></TD></TR> $TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' colspan='1'></TD></TR><TR><TD align='$Align'><B><FONT POINT-SIZE='$FontSize'> $Name</FONT></B></TD></TR> $TR</TABLE>"
                }
            }
        }
    }

}