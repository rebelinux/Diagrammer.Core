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
        Version:        0.2.32
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux

    Specifies the name of the node to process.

    .PARAMETER Align
        Specifies the alignment of the content inside the table cell. Acceptable values are 'Center', 'Right', or 'Left'. Default is 'Center'.

    .PARAMETER AditionalInfo
        A hashtable, ordered dictionary, or array containing additional information about the node. This data is displayed as extra rows in the table.

    .PARAMETER CellBorder
        Specifies the width of the HTML cell border. Default is 0.

    .PARAMETER CellPadding
        Specifies the padding inside the HTML table cells. Default is 5.

    .PARAMETER CellSpacing
        Specifies the spacing between HTML table cells. Default is 5.

    .PARAMETER FontSize
        Specifies the font size for the text inside the table. Default is 14.

    .PARAMETER FontName
        Specifies the font name for the text inside the table. Default is 'Segoe Ui'.

    .PARAMETER FontColor
        Specifies the font color for the text inside the table. Default is '#000000'.

    .PARAMETER FontBold
        If specified, sets the font to bold for the text inside the table.

    .PARAMETER FontItalic
        If specified, sets the font to italic for the text inside the table.

    .PARAMETER FontUnderline
        If specified, underlines the font for the text inside the table.

    .PARAMETER FontOverline
        If specified, applies an overline to the font for the text inside the table.

    .PARAMETER FontSubscript
        If specified, sets the font to subscript for the text inside the table.

    .PARAMETER FontSuperscript
        If specified, sets the font to superscript for the text inside the table.

    .PARAMETER FontStrikeThrough
        If specified, applies a strikethrough to the font for the text inside the table.

    .PARAMETER IconType
        Specifies the type of icon to use for the node. This parameter is required.

    .PARAMETER ImagesObj
        A hashtable mapping icon types to their corresponding image paths. Used to resolve the icon image for the node.

    .PARAMETER ImageSizePercent
        Sets the image size in percent (1-100). Default is 100.

    .PARAMETER IconPath
        Path to the folder containing the icon images.

    .PARAMETER IconDebug
        If set to $true, enables debug mode for icons, highlighting the table border in red for troubleshooting.

    .PARAMETER Name
        The name of the node to display in the table. This parameter is required.

    .PARAMETER NoFontBold
        If specified, disables bold font for the text inside the table.

    .PARAMETER TableBorder
        Specifies the width of the HTML table border. Default is 0.

    .PARAMETER TableLayout
        Specifies the table layout, either 'Vertical' or 'Horizontal'. Default is 'Vertical'.

    .PARAMETER TableBackgroundColor
        Allows setting a table background color (Hex format, e.g., #FFFFFF).

    .PARAMETER CellBackgroundColor
        Allows setting a cell background color (Hex format, e.g., #FFFFFF).
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'A hashtable array containing additional information about the node.'
        )]
        [Alias("RowsOrdered", "Rows", "AdditionalInfo")]
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
            HelpMessage = 'Set the image size in percent (100% is default)'
        )]
        [ValidateRange(1, 100)]
        [int] $ImageSizePercent = 100,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Path to the folder containing the icon images.'
        )]
        [string] $IconPath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enables debug mode for icons, highlighting the table in red.'
        )]
        [Alias("DraftMode")]
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
            HelpMessage = 'Specifies the width of the HTML table border.'
        )]
        [ValidateSet('Vertical', 'Horizontal')]
        [string] $TableLayout = 'Vertical',

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

    # Set TD properties based on $TableLayout
    if ($TableLayout -eq 'Vertical') {
        $TDProperties = "colspan='1' rowspan='1' valign='Middle'"
    } else {
        $TDProperties = "colspan='1' rowspan='4' valign='Middle'"
    }

    # Get the icon image from the hashtable
    if ($IconType -eq 'NoIcon') {
        $ICON = 'NoIcon'
    } elseif ($ImagesObj[$IconType]) {
        $ICON = $ImagesObj[$IconType]
    } else { $ICON = "no_icon.png" }

    # Set the image size if ImageSizePercent is less than 100
    if ($ImageSizePercent -lt 100) {
        if (-not $IconPath) {
            throw "IconPath is required when ImageSizePercent is less than 100."
        }
        $ImageSize = Get-DiaImagePercent -ImageInput (Join-Path -Path $IconPath -Child $ICON) -Percent $ImageSizePercent
    }

    $TR = @()

    # Process additional info if provided
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

    if ($NoFontBold) {
        $FontBold = $false
    } else {
        $FontBold = $true
    }

    $FormattedName = Format-HtmlFontProperty -Text $Name -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

    if ($IconDebug) {
        if ($ICON -ne 'NoIcon') {
            if ($NoFontBold) {
                "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD bgcolor='#FFCCCC' ALIGN='$Align' $TDProperties><FONT FACE='$FontName' Color='$FontColor' POINT-SIZE='$FontSize'>Icon</FONT></TD></TR><TR><TD align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
            } else {
                "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD bgcolor='#FFCCCC' ALIGN='$Align' $TDProperties><FONT FACE='$FontName' Color='$FontColor' POINT-SIZE='$FontSize'>Icon</FONT></TD></TR><TR><TD align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
            }
        } else {
            if ($NoFontBold) {
                "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' $TDProperties></TD></TR><TR><TD align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
            } else {
                "<TABLE color='red' border='1' cellborder='1' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' $TDProperties></TD></TR><TR><TD align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
            }
        }
    } else {
        if ($ICON -ne 'NoIcon') {
            if ($ImageSize) {
                if ($TableBackgroundColor) {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding' bgcolor='$TableBackgroundColor'><TR><TD ALIGN='$Align' FIXEDSIZE='true' width='$($ImageSize.Width)' height='$($ImageSize.Height)' $TDProperties><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
                } elseif ($CellBackgroundColor) {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' FIXEDSIZE='true' width='$($ImageSize.Width)' height='$($ImageSize.Height)' $TDProperties><img src='$($ICON)'/></TD></TR><TR><TD bgcolor='$CellBackgroundColor' align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' FIXEDSIZE='true' width='$($ImageSize.Width)' height='$($ImageSize.Height)' $TDProperties><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
                }
            } else {
                if ($TableBackgroundColor) {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding' bgcolor='$TableBackgroundColor'><TR><TD ALIGN='$Align' $TDProperties><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'><$FormattedName</TD></TR>$TR</TABLE>"

                } elseif ($CellBackgroundColor) {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' $TDProperties><img src='$($ICON)'/></TD></TR><TR><TD bgcolor='$CellBackgroundColor' align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
                } else {
                    "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' $TDProperties><img src='$($ICON)'/></TD></TR><TR><TD align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
                }
            }
        } else {
            if ($TableBackgroundColor) {
                "<TABLE bgcolor='$TableBackgroundColor' border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' $TDProperties></TD></TR><TR><TD align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
            } elseif ($CellBackgroundColor) {
                "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' $TDProperties></TD></TR><TR><TD bgcolor='$CellBackgroundColor' align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
            } else {
                "<TABLE border='$TableBorder' cellborder='$CellBorder' cellspacing='$CellSpacing' cellpadding='$CellPadding'><TR><TD ALIGN='$Align' $TDProperties></TD></TR><TR><TD align='$Align'>$FormattedName</TD></TR>$TR</TABLE>"
            }
        }
    }

}