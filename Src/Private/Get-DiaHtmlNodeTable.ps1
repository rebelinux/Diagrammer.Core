Function Get-DiaHTMLNodeTable {
    <#
    .SYNOPSIS
        Function to convert a array to a HTML Table. Graphviz Nodes split by Columns (Includes Icons)
    .DESCRIPTION
        Takes an array and converts it to a HTML table used for GraphViz Node label
    .Example

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

        Get-DiaHTMLNodeTable -ImagesObj $Images -inputObject $DCsArray -Columnsize 3 -Align 'Center' -IconType "AD_DC" -MultiIcon -IconDebug $True

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
        Version:        0.2.9
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
    .PARAMETER FontName
        The cell text font size
    .PARAMETER FontColor
        The text font color used inside the cell (Default #565656)
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
    .PARAMETER AditionalInfoOrdered
        Hashtable used to add more information to the table elements (Ordered)
    .PARAMETER Subgraph
        Allow to create a table used to add a logo to a Graphviz subgraph
    .PARAMETER SubgraphTableStyle
        Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
    #>

    <#
        TODO
        1. Add Icon to MultiColumns section
        2. Change hardcoded values (FontName, FontColor, FontSize)
        3. Document all parameters
    #>

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
        [int] $fontSize = 14,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font name'
        )]
        [string] $fontName = "Segoe Ui Black",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font color'
        )]
        [string] $fontColor = "#565656",
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
            HelpMessage = 'Hashtable used to add more information to the table elements'
        )]
        [hashtable[]]$AditionalInfo,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Hashtable used to add more information to the table elements (Ordered)'
        )]
        [PSCustomObject[]]$AditionalInfoOrdered,
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
            HelpMessage = 'Allow to set the subgraph table label position (top, down)'
        )]
        [ValidateSet('top', 'down')]
        [string]$SubgraphLabelPos = 'down',
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
        [string] $SubgraphIconHeight
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

    if ($AditionalInfoOrdered) {
        $Filter = $AditionalInfo.PSObject.Properties | Select-Object -Unique
        $RowsGroupHTs = @()

        foreach ($RepoObj in ($Filter | Sort-Object)) {
            $RowsGroupHTs += @{
                $RepoObj = $AditionalInfo.$RepoObj
            }
        }
    }

    if ($ImagesObj) {
        if ($iconType.Count -gt 1) {
            $Icon = @()
            foreach ($i in $iconType) {
                if ($ImagesObj[$i]) {
                    $Icon += $ImagesObj[$i]
                } else {
                    $Icon += $ImagesObj["VBR_No_Icon"]
                }
            }
        } else {
            if ($ImagesObj[$iconType[0]]) {
                $Icon = $ImagesObj[$iconType[0]]
            } else { $Icon = $false }
        }
    }

    If ($SubgraphIconType) {
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
                            #       Keys:        Values:
                            #       Path:          C:\Backup
                            #       OBjStor:       True$RowsGroupHTs
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

    # This part set the capability to emulate Graphviz Subgraph
    if ($Subgraph) {
        if ($SubgraphIcon) {
            if ($IconDebug) {
                $TDSubgraphIcon = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="18"><B>SubGraph Icon</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor
                $TDSubgraph = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="18"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$SubGraphLabel

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
                    $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="18"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$SubGraphLabel

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
                    $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="{3}" POINT-SIZE="18"><B>{4}</B></FONT></TD>' -f $Align, $columnSize, $fontName, $fontColor, [string]$SubGraphLabel

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
                $TDSubgraph = '<TD bgcolor="#FFCCCC" ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="#565656" POINT-SIZE="18"><B>{3}</B></FONT></TD>' -f $Align, $columnSize, $fontName, [string]$SubgraphLabel
                if ($SubgraphLabelPos -eq 'down') {
                    $TR += '<TR>{0}</TR>' -f $TDSubgraph
                } else {
                    $TRTemp = '<TR>{0}</TR>' -f $TDSubgraph
                    $TRTemp += $TR
                    $TR = $TRTemp
                }
            } else {
                $TDSubgraph = '<TD ALIGN="{0}" colspan="{1}"><FONT FACE="{2}" Color="#565656" POINT-SIZE="18"><B>{3}</B></FONT></TD>' -f $Align, $columnSize, $fontName, [string]$SubgraphLabel
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
            return '<TABLE STYLE="{2}" PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{3}" cellspacing="{4}">{1}</TABLE>' -f $Port, $TR, $SubgraphTableStyle, $CellPadding, $CellSpacing

        } else {
            return '<TABLE PORT="{0}" COLOR="red" border="1" cellborder="1" cellpadding="{2}" cellspacing="{3}">{1}</TABLE>' -f $Port, $TR, $CellPadding, $CellSpacing
        }
    } else {
        if ($SubgraphTableStyle) {
            return '<TABLE COLOR="{5}" STYLE="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{6}" cellspacing="{7}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $SubgraphTableStyle, $TableBorderColor, $CellPadding, $CellSpacing

        } else {
            return '<TABLE COLOR="{4}" PORT="{0}" border="{1}" cellborder="{2}" cellpadding="{5}" cellspacing="{6}">{3}</TABLE>' -f $Port, $tableBorder, $cellBorder, $TR, $TableBorderColor, $CellPadding, $CellSpacing
        }
    }
}
