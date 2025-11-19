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
        Version:        0.2.35
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux

    Specifies the name of the node to process.

    .PARAMETER Align
        Specifies the alignment of the content inside the table cell. Acceptable values are 'Center', 'Right', or 'Left'. Default is 'Center'.

    .PARAMETER AditionalInfo
        A hashtable, ordered dictionary, PSCustomObject, or array containing additional information about the node.
        Each entry is rendered as an extra table row in the format "Key: Value". (Note: parameter name is 'AditionalInfo'.)

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
        If set to 'NoIcon', no image is displayed. Other values are resolved via ImagesObj or IconPath.

    .PARAMETER ImagesObj
        A hashtable mapping icon types to their corresponding image paths. Used to resolve the icon image for the node.

    .PARAMETER ImageSizePercent
        Sets the image size in percent (1-100). Default is 100. If less than 100, IconPath must be provided and Get-DiaImagePercent is used.

    .PARAMETER IconPath
        Path to the folder containing the icon images. Required when ImageSizePercent is less than 100.

    .PARAMETER IconDebug
        If set to $true, enables debug mode for icons, highlighting the table border/background in red for troubleshooting.

    .PARAMETER LabelName
        The label of the node to display in the table. If not specified, defaults to the value of the Name parameter.

    .PARAMETER Name
        The name of the node to display in the table. This parameter is required.

    .PARAMETER NoFontBold
        If specified, disables bold font for the text inside the table (overrides FontBold).

    .PARAMETER Port
        Used inside Graphviz to modify the head or tail of an edge, so that the end attaches directly to the object. Default is "EdgeDot".

    .PARAMETER TableBorder
        Specifies the width of the HTML table border. Default is 0.

    .PARAMETER TableLayout
        Specifies the table layout, either 'Vertical' or 'Horizontal'. Default is 'Vertical'.
        Controls cell rowspan/colspan and positioning of the icon vs. text rows.

    .PARAMETER TableBackgroundColor
        Allows setting a table background color (Hex format, e.g., #FFFFFF).

    .PARAMETER CellBackgroundColor
        Allows setting a cell background color (Hex format, e.g., #FFFFFF).

    .PARAMETER NodeObject
        When specified, the function will register the generated HTML with the diagram engine by calling Format-NodeObject.
        Use this to attach Graphviz node attributes and to have the node included in the internal node registry.
        Note: the function validates that Name is present when NodeObject is used.

    .PARAMETER GraphvizAttributes
        A hashtable of additional Graphviz attributes to add to the node (for example: @{ style = 'filled'; color = 'lightgrey' }).
        These are passed to Format-NodeObject when NodeObject is specified.
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
            Mandatory = $false,
            HelpMessage = 'Specifies the name of the html label.'
        )]
        [String]$LabelName,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Specifies the name of the graphviz node.'
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
        [string] $CellBackgroundColor,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the text align'
        )]
        [ValidateScript({
                if ($Name) {
                    $true
                } else {
                    throw "Name parameter is required when NodeObject is set."
                }
            })]
        [switch] $NodeObject,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)'
        )]
        [hashtable] $GraphvizAttributes = @{},

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Used inside Graphviz to modify the head or tail of an edge, so that the end attaches directly to the object'
        )]
        [string] $Port = "EdgeDot"
    )

    # Set TD properties based on $TableLayout
    if ($TableLayout -eq 'Vertical') {
        $TDProperties = 'colspan="1" rowspan="1" valign="Middle"'
    } else {
        $TDProperties = 'colspan="1" rowspan="4" valign="Middle"'
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

    # Process additionalinfo if provided
    if ($AditionalInfo) {
        switch ($AditionalInfo.GetType().Name) {
            'Hashtable' {
                foreach ($r in $AditionalInfo) {
                    [string]$TR += $r.getEnumerator() | ForEach-Object {
                        '<TR><TD PORT="{0}" align="{1}" colspan="1"><FONT POINT-SIZE="{2}">{3}: {4}</FONT></TD></TR>' -f $_.Key, $Align, $FontSize, $_.Key, $_.Value
                    }
                }
            }

            'OrderedDictionary' {
                foreach ($r in $AditionalInfo) {
                    [string]$TR += $r.getEnumerator() | ForEach-Object {
                        '<TR><TD PORT="{0}" align="{1}" colspan="1"><FONT POINT-SIZE="{2}">{3}: {4}</FONT></TD></TR>' -f $_.Key, $Align, $FontSize, $_.Key, $_.Value
                    }
                }
            }

            'PSCustomObject' {
                foreach ($r in $AditionalInfo) {
                    [string]$TR += $r.PSObject.Properties | ForEach-Object {
                        '<TR><TD PORT="{0}" align="{1}" colspan="1"><FONT POINT-SIZE="{2}">{3}: {4}</FONT></TD></TR>' -f $_.Name, $Align, $FontSize, $_.Name, $_.Value
                    }
                }
            }

            'Object[]' {
                foreach ($r in $AditionalInfo) {
                    [string]$TR += $r.PSObject.Properties | ForEach-Object {
                        '<TR><TD PORT="{0}" align="{1}" colspan="1"><FONT POINT-SIZE="{2}">{3}: {4}</FONT></TD></TR>' -f $_.Name, $Align, $FontSize, $_.Name, $_.Value
                    }
                }
            }
        }
    }

    # Determine FontBold based on NoFontBold switch
    if ($NoFontBold) {
        $FontBold = $false
    } else {
        $FontBold = $true
    }

    if (-not $LabelName) {
        $LabelName = $Name
    }

    # Format the name with the specified font properties
    $FormattedName = Format-HtmlFontProperty -Text $LabelName -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

    if ($IconDebug) {
        if ($ICON -ne 'NoIcon') {
            if ($NodeObject) {
                $HTML = '<TABLE PORT="{0}" color="red" border="1" cellborder="1" cellspacing="{1}" cellpadding="{2}"><TR><TD bgcolor="#FFCCCC" ALIGN="{3}" {4}><FONT FACE="{5}" Color="{6}" POINT-SIZE="{7}">{8}</FONT></TD></TR><TR><TD align="{3}">{9}</TD></TR>{10}</TABLE>' -f $Port, $CellSpacing, $CellPadding, $Align, $TDProperties, $FontName, $FontColor, $FontSize, $ICON, $FormattedName, $TR

                Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

            } else {
                '<TABLE PORT="{0}" color="red" border="1" cellborder="1" cellspacing="{1}" cellpadding="{2}"><TR><TD bgcolor="#FFCCCC" ALIGN="{3}" {4}><FONT FACE="{5}" Color="{6}" POINT-SIZE="{7}">{8}</FONT></TD></TR><TR><TD align="{3}">{9}</TD></TR>{10}</TABLE>' -f $Port, $CellSpacing, $CellPadding, $Align, $TDProperties, $FontName, $FontColor, $FontSize, $ICON, $FormattedName, $TR
            }
        } else {
            if ($NodeObject) {
                $HTML = '<TABLE PORT="{0}" color="red" border="1" cellborder="1" cellspacing="{1}" cellpadding="{2}"><TR><TD ALIGN="{3}" {4}></TD></TR><TR><TD align="{3}">{5}</TD></TR>{6}</TABLE>' -f $Port, $CellSpacing, $CellPadding, $Align, $TDProperties, $FormattedName, $TR

                Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

            } else {
                '<TABLE PORT="{0}" color="red" border="1" cellborder="1" cellspacing="{1}" cellpadding="{2}"><TR><TD ALIGN="{3}" {4}></TD></TR><TR><TD align="{3}">{5}</TD></TR>{6}</TABLE>' -f $Port, $CellSpacing, $CellPadding, $Align, $TDProperties, $FormattedName, $TR
            }
        }
    } else {
        if ($ICON -ne 'NoIcon') {
            if ($ImageSize) {
                if ($TableBackgroundColor) {
                    if ($NodeObject) {
                        $HTML = '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}" bgcolor="{5}"><TR><TD ALIGN="{6}" FIXEDSIZE="true" width="{7}" height="{8}" {9}><img src="{10}"/></TD></TR><TR><TD align="{6}">{11}</TD></TR>{12}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $TableBackgroundColor, $Align, $ImageSize.Width, $ImageSize.Height, $TDProperties, $ICON, $FormattedName, $TR


                        Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

                    } else {
                        '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}" bgcolor="{5}"><TR><TD ALIGN="{6}" FIXEDSIZE="true" width="{7}" height="{8}" {9}><img src="{10}"/></TD></TR><TR><TD align="{6}">{11}</TD></TR>{12}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $TableBackgroundColor, $Align, $ImageSize.Width, $ImageSize.Height, $TDProperties, $ICON, $FormattedName, $TR
                    }
                } elseif ($CellBackgroundColor) {
                    if ($NodeObject) {
                        $HTML = '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" FIXEDSIZE="true" width="{6}" height="{7}" {8}><img src="{9}"/></TD></TR><TR><TD bgcolor="{10}" align="{5}">{11}</TD></TR>{12}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $ImageSize.Width, $ImageSize.Height, $TDProperties, $ICON, $CellBackgroundColor, $FormattedName, $TR



                        Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

                    } else {
                        '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" FIXEDSIZE="true" width="{6}" height="{7}" {8}><img src="{9}"/></TD></TR><TR><TD bgcolor="{10}" align="{5}">{11}</TD></TR>{12}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $ImageSize.Width, $ImageSize.Height, $TDProperties, $ICON, $CellBackgroundColor, $FormattedName, $TR
                    }
                } else {
                    if ($NodeObject) {
                        $HTML = '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" FIXEDSIZE="true" width="{6}" height="{7}" {8}><img src="{9}"/></TD></TR><TR><TD align="{5}">{10}</TD></TR>{11}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $ImageSize.Width, $ImageSize.Height, $TDProperties, $ICON, $FormattedName, $TR

                        Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

                    } else {
                        '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" FIXEDSIZE="true" width="{6}" height="{7}" {8}><img src="{9}"/></TD></TR><TR><TD align="{5}">{10}</TD></TR>{11}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $ImageSize.Width, $ImageSize.Height, $TDProperties, $ICON, $FormattedName, $TR
                    }
                }
            } else {
                if ($TableBackgroundColor) {
                    if ($NodeObject) {
                        $HTML = '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}" bgcolor="{5}"><TR><TD ALIGN="{6}" {7}><img src="{8}"/></TD></TR><TR><TD align="{6}">{9}</TD></TR>{10}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $TableBackgroundColor, $Align, $TDProperties, $ICON, $FormattedName, $TR

                        Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

                    } else {
                        '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}" bgcolor="{5}"><TR><TD ALIGN="{6}" {7}><img src="{8}"/></TD></TR><TR><TD align="{6}">{9}</TD></TR>{10}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $TableBackgroundColor, $Align, $TDProperties, $ICON, $FormattedName, $TR
                    }
                } elseif ($CellBackgroundColor) {
                    if ($NodeObject) {
                        $HTML = '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" {6}><img src="{7}"/></TD></TR><TR><TD bgcolor="{8}" align="{5}">{9}</TD></TR>{10}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $ICON, $CellBackgroundColor, $FormattedName, $TR

                        Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

                    } else {
                        '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" {6}><img src="{7}"/></TD></TR><TR><TD bgcolor="{8}" align="{5}">{9}</TD></TR>{10}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $ICON, $CellBackgroundColor, $FormattedName, $TR
                    }
                } else {
                    if ($NodeObject) {
                        $HTML = '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" {6}><img src="{7}"/></TD></TR><TR><TD align="{5}">{8}</TD></TR>{9}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $ICON, $FormattedName, $TR

                        Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

                    } else {
                        '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" {6}><img src="{7}"/></TD></TR><TR><TD align="{5}">{8}</TD></TR>{9}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $ICON, $FormattedName, $TR
                    }
                }
            }
        } else {
            if ($TableBackgroundColor) {
                if ($NodeObject) {
                    $HTML = '<TABLE PORT="{0}" bgcolor="{1}" border="{2}" cellborder="{3}" cellspacing="{4}" cellpadding="{5}"><TR><TD ALIGN="{6}" {7}></TD></TR><TR><TD align="{6}">{8}</TD></TR>{9}</TABLE>' -f $Port, $TableBackgroundColor, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $FormattedName, $TR

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

                } else {
                    '<TABLE PORT="{0}" bgcolor="{1}" border="{2}" cellborder="{3}" cellspacing="{4}" cellpadding="{5}"><TR><TD ALIGN="{6}" {7}></TD></TR><TR><TD align="{6}">{8}</TD></TR>{9}</TABLE>' -f $Port, $TableBackgroundColor, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $FormattedName, $TR
                }
            } elseif ($CellBackgroundColor) {
                if ($NodeObject) {
                    $HTML = '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" {6}></TD></TR><TR><TD bgcolor="{7}" align="{5}">{8}</TD></TR>{9}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $CellBackgroundColor, $FormattedName, $TR

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

                } else {
                    '<TABLE PORT="{0}" bgcolor="{1}" border="{2}" cellborder="{3}" cellspacing="{4}" cellpadding="{5}"><TR><TD ALIGN="{6}" {7}></TD></TR><TR><TD align="{6}">{8}</TD></TR>{9}</TABLE>' -f $Port, $TableBackgroundColor, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $FormattedName, $TR
                }
            } else {
                if ($NodeObject) {
                    $HTML = '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" {6}></TD></TR><TR><TD align="{5}">{7}</TD></TR>{8}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $FormattedName, $TR

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes

                } else {
                    '<TABLE PORT="{0}" border="{1}" cellborder="{2}" cellspacing="{3}" cellpadding="{4}"><TR><TD ALIGN="{5}" {6}></TD></TR><TR><TD align="{5}">{7}</TD></TR>{8}</TABLE>' -f $Port, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $Align, $TDProperties, $FormattedName, $TR
                }
            }
        }
    }

}