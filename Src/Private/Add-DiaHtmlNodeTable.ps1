function Add-DiaHtmlNodeTable {
    <#
    .SYNOPSIS
        Converts an array to an HTML table for Graphviz node labels, including icons.

    .DESCRIPTION
        This function takes an array and converts it into an HTML table, which can be used as a label for Graphviz nodes.
        The table can include icons and additional information for each element.

    .EXAMPLE
        # Array of String *6 Objects*
        $DCsArray = @("Server-dc-01v","Server-dc-02v","Server-dc-03v","Server-dc-04v","Server-dc-05v","Server-dc-06v")

        $Images = @{
            "Microsoft_Logo" = "Microsoft_Logo.png"
            "ForestRoot" = "Forrest_Root.png"
            "AD_LOGO_Footer" = "DMAD_Logo.png"
            "AD_DC" = "DomainController.png"
            "AD_Domain" = "ADDomain.png"
            "AD_Site" = "Site.png"
            "AD_Site_Subnet" = "SubNet.png"
            "AD_Site_Node" = "SiteNode.png"
        }

        Add-DiaHTMLNodeTable -ImagesObj $Images -inputObject $DCsArray -Columnsize 3 -Align 'Center' -IconType "AD_DC" -MultiIcon -IconDebug $True

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
        Version:        0.2.29
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux

    .PARAMETER inputObject
        The array of objects to process.

    .PARAMETER Align
        Align content inside table cell. Default is 'Center'.

    .PARAMETER TableBorder
        The width of the table border line. Default is 0.

    .PARAMETER CellBorder
        The width of the table cell border. Default is 0.

    .PARAMETER CellPadding
        The padding inside the table cell. Default is 5.

    .PARAMETER CellSpacing
        The spacing between table cells. Default is 5.

    .PARAMETER FontSize
        The cell text font size. Default is 14.

    .PARAMETER FontName
        The cell text font name. Default is "Segoe Ui".

    .PARAMETER FontColor
        The text font color used inside the cell. Default is #000000.

    .PARAMETER IconType
        Node Icon type. This parameter is mandatory if ImagesObj is specified.

    .PARAMETER ColumnSize
        The number of columns to split the object inside the HTML table. Default is 1.

    .PARAMETER Port
        Used inside Graphviz to modify the head or tail of an edge, so that the end attaches directly to the object. Default is "EdgeDot".

    .PARAMETER MultiIcon
        Allow to draw an icon for each table element. If not set, the table shares a single icon.

    .PARAMETER ImagesObj
        Hashtable with the IconName to IconPath translation.

    .PARAMETER IconDebug
        Enable the icon debug mode.

    .PARAMETER AditionalInfo
        Hashtable used to add more information to the table elements.

    .PARAMETER Subgraph
        Create the table that can be used as a Subgraph replacement with the hashtable inside it.

    .PARAMETER SubgraphIconType
        Allow to set the subgraph table icon. This parameter is mandatory if ImagesObj is specified.

    .PARAMETER SubgraphLabel
        Allow to set the subgraph table label.

    .PARAMETER SubgraphLabelFontsize
        Allow to set the subgraph table label font size. Default is 14.

    .PARAMETER SubgraphLabelPos
        Allow to set the subgraph label position. Valid values are 'top' and 'down'. Default is 'down'.

    .PARAMETER SubgraphTableStyle
        Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED).

    .PARAMETER TableBorderColor
        Allow to set a table border color. Default is #000000.

    .PARAMETER SubgraphIconWidth
        Allow to set a subgraph icon width.

    .PARAMETER SubgraphIconHeight
        Allow to set a subgraph icon height.

    .PARAMETER TableBackgroundColor
        Allow to set a table background color (Hex format EX: #FFFFFF).

    .PARAMETER CellBackgroundColor
        Allow to set a cell background color (Hex format EX: #FFFFFF).
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide input object to process'
        )]
        [string[]] $inputObject,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the Image Hashtable Object'
        )]
        [Hashtable] $ImagesObj,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the icon type or icon type array'
        )]
        [ValidateScript({
                if ($ImagesObj) {
                    $true
                } else {
                    throw "ImagesObj table needed if IconType option is especified."
                }
            })]
        [string[]] $iconType,

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
            HelpMessage = 'Allow to set the padding of the html cell border'
        )]
        [int] $CellPadding = 5,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the spacing of the html cell border'
        )]
        [int] $CellSpacing = 5,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font size'
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
            Mandatory = $false,
            HelpMessage = 'This value is used to specified a int used to split the object inside the HTML table'
        )]
        [int] $ColumnSize = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Used inside Graphviz to modify the head or tail of an edge, so that the end attaches directly to the object'
        )]
        [string] $Port = "EdgeDot",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'This value enable the option to assign a unique icon per node object'
        )]
        [Switch]$MultiIcon,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enable the icon debug mode'
        )]
        [Alias("DraftMode")]
        [bool] $IconDebug,

        [Parameter(
            ParameterSetName = 'AdditionalInfo',
            Mandatory = $false,
            HelpMessage = 'Hashtable used to add more information to the table elements'
        )]
        [Alias("RowsOrdered", "Rows", "AditionalInfoOrdered")]
        $AditionalInfo,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Create the table with that can be used as a Subgraph replacement with the hashtable inside it'
        )]
        [Switch]$Subgraph,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table icon'
        )]
        [ValidateScript({
                if ($ImagesObj) {
                    $true
                } else {
                    throw "ImagesObj table needed if SubgraphIconType option is especified."
                }
            })]
        [string]$SubgraphIconType,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table label'
        )]
        [string]$SubgraphLabel,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table label font size'
        )]
        [int]$SubgraphLabelFontSize = 14,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table label font size'
        )]
        [string]$SubgraphLabelFontColor = "#000000",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font bold'
        )]
        [switch] $SubgraphFontBold,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font italic'
        )]
        [switch] $SubgraphFontItalic,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font underline'
        )]
        [switch] $SubgraphFontUnderline,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font overline'
        )]
        [switch] $SubgraphFontOverline,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font subscript'
        )]
        [switch] $SubgraphFontSubscript,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font superscript'
        )]
        [switch] $SubgraphFontSuperscript,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font strikethrough'
        )]
        [switch] $SubgraphFontStrikeThrough,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph label'
        )]
        [ValidateSet('top', 'down')]
        [string]$SubgraphLabelPos = 'top',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)'
        )]
        [string]$SubgraphTableStyle,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table border color'
        )]
        [string]$TableBorderColor = "#000000",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon width'
        )]
        [string] $SubgraphIconWidth,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon height'
        )]
        [string] $SubgraphIconHeight,

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
            HelpMessage = 'Specifies the name of the node.'
        )]
        [String]$Name,

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
        [hashtable] $GraphvizAttributes = @{}
    )

    if ($inputObject.Count -le 1) {
        $Group = $inputObject
    } else {
        $Group = Split-Array -inArray $inputObject -size $columnSize
    }


    if ($AditionalInfo) {
        switch ($AditionalInfo.GetType().Name) {
            'Hashtable' {
                if ($AditionalInfo) {
                    $Filter = $AditionalInfo.keys | Select-Object -Unique
                    $RowsGroupHTs = @()

                    foreach ($RepoObj in ($Filter)) {
                        $RowsGroupHTs += @{
                            $RepoObj = $AditionalInfo.$RepoObj
                        }
                    }
                }
            }

            'OrderedDictionary' {
                if ($AditionalInfo) {
                    $Filter = $AditionalInfo.keys | Select-Object -Unique
                    $RowsGroupHTs = @()

                    foreach ($RepoObj in ($Filter)) {
                        $RowsGroupHTs += @{
                            $RepoObj = $AditionalInfo.$RepoObj
                        }
                    }
                }
            }

            'Object[]' {
                if ($AditionalInfo[0].GetType().Name -eq 'PSCustomObject') {
                    $Filter = $AditionalInfo | ForEach-Object { $_.PSObject.Properties.name } | Select-Object -Unique
                    $RowsGroupHTs = @()

                    foreach ($RepoObj in ($Filter)) {
                        $RowsGroupHTs += @{
                            $RepoObj = $AditionalInfo.$RepoObj
                        }
                    }
                } else {
                    $Filter = $AditionalInfo.keys | Select-Object -Unique
                    $RowsGroupHTs = @()

                    foreach ($RepoObj in ($Filter)) {
                        $RowsGroupHTs += @{
                            $RepoObj = $AditionalInfo.$RepoObj
                        }
                    }
                }
            }

            'PSCustomObject' {
                if ($AditionalInfo) {
                    $Filter = $AditionalInfo | ForEach-Object { $_.PSObject.Properties.name } | Select-Object -Unique
                    $RowsGroupHTs = @()

                    foreach ($RepoObj in ($Filter)) {
                        $RowsGroupHTs += @{
                            $RepoObj = $AditionalInfo.$RepoObj
                        }
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

    if ($ImagesObj) {
        if ($iconType.Count -gt 1) {
            $Icon = @()
            foreach ($i in $iconType) {
                if ($ImagesObj[$i]) {
                    $Icon += $ImagesObj[$i]
                } else {
                    $Icon += $ImagesObj["No_Icon"]
                }
            }
        } else {
            if ($ImagesObj[$iconType[0]]) {
                $Icon = $ImagesObj[$iconType[0]]
            } else { $Icon = $false }
        }
    }

    if ($SubgraphIconType) {
        if ($ImagesObj[$SubgraphIconType]) {
            $SubgraphIcon = $ImagesObj[$SubgraphIconType]
        } else { $SubgraphIcon = $false }
    }

    $Number = 0
    $iconNumber = 0

    if ($Icon) {
        if ($IconDebug) {
            if ($MultiIcon) {
                while ($Number -ne $Group.Count) {
                    foreach ($Element in $Group[$Number]) {
                        $TDICON += '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="1"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{1}">{4}</FONT></TD>' -f $Align, $FontSize, $FontName, $FontColor, $Icon[$iconNumber]
                    }
                    $TR += '<TR>{0}</TR>' -f $TDICON
                    $TDICON = ''

                    foreach ($Element in $Group[$Number]) {
                        $FormattedName = Format-HtmlFontProperty -Text $Element -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

                        $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1">{2}</TD>' -f $Element, $Align, $FormattedName
                    }
                    $TR += '<TR>{0}</TR>' -f $TDName
                    $TDName = ''

                    if ($AditionalInfo -or $AditionalInfoOrdered) {
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
                            #       Keys:        Values:
                            #       Path:          C:\Backup
                            #       OBjStor:       True$RowsGroupHTs$RowsGroupHTs
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
                                $RowsGroup = Split-Array -inArray ($RowsGroupHT.GetEnumerator() | ForEach-Object { $_.value }) -size $columnSize
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

                $TDICON += '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{3}" Color="{4}" POINT-SIZE="{2}">{5}</FONT></TD>' -f $Align, $inputObject.Count, $FontSize, $FontName, $FontColor, $Icon[$iconNumber]

                $TR += '<TR>{0}</TR>' -f $TDICON

                while ($Number -ne $Group.Count) {
                    foreach ($Element in $Group[$Number]) {
                        $FormattedName = Format-HtmlFontProperty -Text $Element -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

                        $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1">{2}</TD>' -f $Element, $Align, $FormattedName
                    }

                    $TR += '<TR>{0}</TR>' -f $TDName

                    $TDName = ''

                    if ($AditionalInfo -or $AditionalInfoOrdered) {
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
                            #       Keys:        Values:
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
                                $RowsGroup = Split-Array -inArray ($RowsGroupHT.GetEnumerator() | ForEach-Object { $_.value }) -size $columnSize
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
                    if ($Icon.Count -gt 1) {
                        foreach ($Element in $Group[$Number]) {
                            $TDICON += '<TD ALIGN="{0}" colspan="1"><img src="{1}"/></TD>' -f $Align, $Icon[$iconNumber]
                            $iconNumber++
                        }
                    } else {
                        foreach ($Element in $Group[$Number]) {
                            $TDICON += '<TD ALIGN="{0}" colspan="1"><img src="{1}"/></TD>' -f $Align, $Icon
                        }
                    }
                    $TR += '<TR>{0}</TR>' -f $TDICON
                    $TDICON = ''

                    foreach ($Element in $Group[$Number]) {
                        # Format the name with the specified font properties
                        $FormattedName = Format-HtmlFontProperty -Text $Element -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

                        if ($CellBackgroundColor) {
                            $TDName += '<TD BGCOLOR="{0}" PORT="{1}" ALIGN="{2}" colspan="1">{3}</TD>' -f $CellBackgroundColor, $Element, $Align, $FormattedName
                        } else {
                            $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1">{2}</TD>' -f $Element, $Align, $FormattedName
                        }
                    }
                    $TR += '<TR>{0}</TR>' -f $TDName
                    $TDName = ''

                    if ($AditionalInfo -or $AditionalInfoOrdered) {
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
                            #       Keys:          Values:
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
                                $RowsGroup = Split-Array -inArray ($RowsGroupHT.GetEnumerator() | ForEach-Object { $_.value }) -size $columnSize
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

                $TDICON += '<TD ALIGN="{0}" colspan="{1}"><img src="{2}"/></TD>' -f $Align, $inputObject.Count, $Icon[0]

                $TR += '<TR>{0}</TR>' -f $TDICON

                while ($Number -ne $Group.Count) {
                    foreach ($Element in $Group[$Number]) {
                        # Format the name with the specified font properties
                        $FormattedName = Format-HtmlFontProperty -Text $Element -FontSize $FontSize -FontColor $FontColor -FontBold:$FontBold -FontItalic:$FontItalic -FontUnderline:$FontUnderline -FontName $FontName -FontSubscript:$FontSubscript -FontSuperscript:$FontSuperscript -FontStrikeThrough:$FontStrikeThrough -FontOverline:$FontOverline

                        if ($CellBackgroundColor) {
                            $TDName += '<TD BGCOLOR="{0}" PORT="{1}" ALIGN="{2}" colspan="1">{3}</TD>' -f $CellBackgroundColor, $Element, $Align, $FormattedName
                        } else {
                            $TDName += '<TD PORT="{0}" ALIGN="{1}" colspan="1">{2}</TD>' -f $Element, $Align, $FormattedName
                        }
                    }
                    $TR += '<TR>{0}</TR>' -f $TDName
                    $TDName = ''

                    if ($AditionalInfo -or $AditionalInfoOrdered) {
                        if (($RowsGroupHTs.Keys.Count -le 1 ) -and ($RowsGroupHTs.Values.Count -le 1) -and ($inputObject.Count -le 1)) {
                            # $RowsGroupHT is Single key with Single Values
                            #  Keys: Path - Values: C:\Backup
                            #
                            foreach ($Element in $RowsGroupHTs[$Number]) {
                                $TDInfo += '<TD ALIGN="{0}" colspan="1"><FONT POINT-SIZE="{1}">{2}: {3}</FONT></TD>' -f $Align, $FontSize, [string]$Element.Keys, [string]$Element.values
                            }

                            $TR += '<TR>{0}</TR>' -f $TDInfobgcolor
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
                                $RowsGroup = Split-Array -inArray ($RowsGroupHT.GetEnumerator() | ForEach-Object { $_.value }) -size $columnSize
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

    # This part set the capability to emulate Graphviz Subgraph
    if ($Subgraph) {
        $FormattedSubGraphLabel = Format-HtmlFontProperty -Text $SubGraphLabel -FontSize $SubgraphLabelFontSize -FontColor $SubgraphLabelFontColor -FontBold:$SubgraphFontBold -FontItalic:$SubgraphFontItalic -FontUnderline:$SubgraphFontUnderline -FontName $SubgraphFontName -FontSubscript:$SubgraphFontSubscript -FontSuperscript:$SubgraphFontSuperscript -FontStrikeThrough:$SubgraphFontStrikeThrough -FontOverline:$SubgraphFontOverline

        if ($SubgraphIcon) {
            if ($IconDebug) {
                $TDSubgraphIcon = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="{4}"><B>{5}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, $SubgraphLabelFontSize, $SubGraphIcon
                $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}">{2}</TD>' -f $Align, $columnSize, $FormattedSubGraphLabel

                if ($SubgraphLabelPos -eq 'down') {
                    $TR += '<TR>{0}</TR>' -f $TDSubgraphIcon
                    $TR += '<TR>{0}</TR>' -f $TDSubgraph
                } else {
                    $TRTemp += '<TR>{0}</TR>' -f $TDSubgraphIcon
                    $TRTemp += '<TR>{0}</TR>' -f $TDSubgraph
                    $TRTemp += $TR
                    $TR = $TRTemp
                }
            } else {
                if ($SubgraphIconWidth -and $SubgraphIconHeight) {
                    $TDSubgraphIcon = '<TD ALIGN="{0}" colspan="{1}" fixedsize="true" width="{5}" height="{6}"><IMG src="{4}"></IMG></TD>' -f $Align, $columnSize, $fontName, $fontColor, $SubGraphIcon, $SubGraphIconWidth, $SubGraphIconHeight
                    $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}">{2}</TD>' -f $Align, $columnSize, $FormattedSubGraphLabel

                    if ($SubgraphLabelPos -eq 'down') {
                        $TR += '<TR>{0}</TR>' -f $TDSubgraphIcon
                        $TR += '<TR>{0}</TR>' -f $TDSubgraph
                    } else {
                        $TRTemp += '<TR>{0}</TR>' -f $TDSubgraphIcon
                        $TRTemp += '<TR>{0}</TR>' -f $TDSubgraph
                        $TRTemp += $TR
                        $TR = $TRTemp
                    }
                } else {
                    $TDSubgraphIcon = '<TD ALIGN="{0}" colspan="{1}" fixedsize="true" width="40" height="40"><IMG src="{2}"></IMG></TD>' -f $Align, $columnSize, $SubGraphIcon
                    $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}">{2}</TD>' -f $Align, $columnSize, $FormattedSubGraphLabel

                    if ($SubgraphLabelPos -eq 'down') {
                        $TR += '<TR>{0}</TR>' -f $TDSubgraphIcon
                        $TR += '<TR>{0}</TR>' -f $TDSubgraph
                    } else {
                        $TRTemp += '<TR>{0}</TR>' -f $TDSubgraphIcon
                        $TRTemp += '<TR>{0}</TR>' -f $TDSubgraph
                        $TRTemp += $TR
                        $TR = $TRTemp
                    }
                }
            }
        } else {
            if ($IconDebug) {
                $TDSubgraph = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{5}" POINT-SIZE="{4}"><B>{3}</B></FONT></TD>' -f $Align, $columnSize, $fontName, [string]$SubgraphLabel, $SubgraphLabelFontSize, $fontColor
                if ($SubgraphLabelPos -eq 'down') {
                    $TR += '<TR>{0}</TR>' -f $TDSubgraph
                } else {
                    $TRTemp = '<TR>{0}</TR>' -f $TDSubgraph
                    $TRTemp += $TR
                    $TR = $TRTemp
                }
            } else {
                $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}">{2}</TD>' -f $Align, $columnSize, $FormattedSubGraphLabel

                if ($SubgraphLabelPos -eq 'down') {
                    $TR += '<TR>{0}</TR>' -f $TDSubgraph
                } else {
                    $TRTemp = '<TR>{0}</TR>' -f $TDSubgraph
                    $TRTemp += $TR
                    $TR = $TRTemp
                }
            }
        }
    }

    if ($IconDebug) {
        if ($SubgraphTableStyle) {
            if ($TableBackgroundColor) {
                if ($NodeObject) {
                    $HTML = '<TABLE STYLE="{2}" PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{3}" cellspacing="{4}" bgcolor="{5}">{1}</TABLE>' -f $Port, $TR, $SubgraphTableStyle, $CellPadding, $CellSpacing, $TableBackgroundColor

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes
                } else {
                    '<TABLE STYLE="{2}" PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{3}" cellspacing="{4}" bgcolor="{5}">{1}</TABLE>' -f $Port, $TR, $SubgraphTableStyle, $CellPadding, $CellSpacing, $TableBackgroundColor
                }
            } else {
                if ($NodeObject) {
                    $HTML = '<TABLE STYLE="{2}" PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{3}" cellspacing="{4}">{1}</TABLE>' -f $Port, $TR, $SubgraphTableStyle, $CellPadding, $CellSpacing

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes
                } else {
                    '<TABLE STYLE="{2}" PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{3}" cellspacing="{4}">{1}</TABLE>' -f $Port, $TR, $SubgraphTableStyle, $CellPadding, $CellSpacing
                }
            }
        } else {
            if ($TableBackgroundColor) {
                if ($NodeObject) {
                    $HTML = '<TABLE PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{2}" cellspacing="{3}" bgcolor="{4}">{1}</TABLE>' -f $Port, $TR, $CellPadding, $CellSpacing, $TableBackgroundColor

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes
                } else {
                    '<TABLE PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{2}" cellspacing="{3}" bgcolor="{4}">{1}</TABLE>' -f $Port, $TR, $CellPadding, $CellSpacing, $TableBackgroundColor
                }
            } else {
                if ($NodeObject) {
                    $HTML = '<TABLE PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{2}" cellspacing="{3}">{1}</TABLE>' -f $Port, $TR, $CellPadding, $CellSpacing

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes
                } else {
                    '<TABLE PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{2}" cellspacing="{3}">{1}</TABLE>' -f $Port, $TR, $CellPadding, $CellSpacing
                }
            }
        }
    } else {
        if ($SubgraphTableStyle) {
            if ($TableBackgroundColor) {
                if ($NodeObject) {
                    $HTML = '<TABLE bgcolor="{8}" COLOR="{5}" STYLE="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{6}" cellspacing="{7}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $SubgraphTableStyle, $TableBorderColor, $CellPadding, $CellSpacing, $TableBackgroundColor

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes
                } else {
                    '<TABLE bgcolor="{8}" COLOR="{5}" STYLE="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{6}" cellspacing="{7}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $SubgraphTableStyle, $TableBorderColor, $CellPadding, $CellSpacing, $TableBackgroundColor
                }
            } else {
                if ($NodeObject) {
                    $HTML = '<TABLE COLOR="{5}" STYLE="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{6}" cellspacing="{7}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $SubgraphTableStyle, $TableBorderColor, $CellPadding, $CellSpacing, $TableBackgroundColor

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes
                } else {
                    '<TABLE COLOR="{5}" STYLE="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{6}" cellspacing="{7}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $SubgraphTableStyle, $TableBorderColor, $CellPadding, $CellSpacing, $TableBackgroundColor
                }
            }
        } else {
            if ($TableBackgroundColor) {
                if ($NodeObject) {
                    $HTML = '<TABLE bgcolor="{7}" COLOR="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{5}" cellspacing="{6}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $TableBorderColor, $CellPadding, $CellSpacing, $TableBackgroundColor

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes
                } else {
                    '<TABLE bgcolor="{7}" COLOR="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{5}" cellspacing="{6}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $TableBorderColor, $CellPadding, $CellSpacing, $TableBackgroundColor
                }
            } else {
                if ($NodeObject) {
                    $HTML = '<TABLE COLOR="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{5}" cellspacing="{6}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $TableBorderColor, $CellPadding, $CellSpacing

                    Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes
                } else {
                    '<TABLE COLOR="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{5}" cellspacing="{6}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $TableBorderColor, $CellPadding, $CellSpacing
                }
            }
        }
    }
}
