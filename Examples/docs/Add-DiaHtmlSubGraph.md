---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Add-DiaHtmlSubGraph

## SYNOPSIS
Function to convert a array to a HTML Table to mimic Graphviz Cluster (Subgraph).

## SYNTAX

```
Add-DiaHtmlSubGraph [-TableArray] <String[]> [[-ImagesObj] <Hashtable>] [[-ImageSizePercent] <Int32>]
 [[-Align] <String>] [[-TableBorder] <Int32>] [[-CellBorder] <Int32>] [[-CellPadding] <Int32>]
 [[-CellSpacing] <Int32>] [[-FontSize] <Int32>] [[-FontName] <String>] [[-FontColor] <String>] [-FontBold]
 [-FontItalic] [-FontUnderline] [-FontOverline] [-FontSubscript] [-FontSuperscript] [-FontStrikeThrough]
 [[-ColumnSize] <Int32>] [[-IconDebug] <Boolean>] [-NoFontBold] [[-IconType] <String>] [[-Label] <String>]
 [[-LabelPos] <String>] [[-TableStyle] <String>] [[-TableBorderColor] <String>]
 [[-TableBackgroundColor] <String>] [[-IconWidth] <Int32>] [[-IconHeight] <Int32>] [[-Name] <String>]
 [-NodeObject] [[-GraphvizAttributes] <Hashtable>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Takes a array and converts it to a HTML table to mimic Graphviz Subgraph

## EXAMPLES

### EXAMPLE 1
```
$SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
Add-DiaHtmlSubGraph -TableArray $SiteSubnets -Align "Center" -ColumnSize 2
    _________________________________
    |               |               |
    |192.168.5.0/24 |192.168.7.0/24 |
    ________________________________
    |               |               |
    |  10.0.0.0/24  |               |
    _________________________________
```

$SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
Add-DiaHTMLSubGraph -TableArray $SiteSubnets -Align "Center"
    _________________
    |               |
    |192.168.5.0/24 |
    _________________
    |               |
    |192.168.7.0/24 |
    _________________
    |               |
    |  10.0.0.0/24  |
    _________________

## PARAMETERS

### -Align
Align content inside table cell (Default: Center)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Center
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellBorder
The table cell border width (Default: 0)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellPadding
The table cell padding space (Default: 5)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellSpacing
The table cell spacing (Default: 5)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -ColumnSize
Number used to split objects inside the HTML table (Default: 1)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontBold
Allow to set the font bold

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
The text font color used inside the cell (Default: #000000)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: #000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontItalic
Allow to set the font italic

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontName
The text font name used inside the cell (Default: Segoe Ui)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: Segoe Ui
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontOverline
Allow to set the font overline

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontSize
The text font size used inside the cell (Default: 14)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 14
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontStrikeThrough
Allow to set the font strikethrough

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontSubscript
Allow to set the font subscript

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontSuperscript
Allow to set the font superscript

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontUnderline
Allow to set the font underline

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GraphvizAttributes
Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug
Enable the icon debug mode

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: DraftMode

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconHeight
The subgraph icon height (Default: 40)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: 40
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconType
The subgraph table icon type

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconWidth
The subgraph icon width (Default: 40)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: 40
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImageSizePercent
Set the image size in percent (Default: 100)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImagesObj
Hashtable with the IconName \> IconPath translation

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Label
The subgraph table label

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LabelPos
The subgraph table label position (top or down, Default: down)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: Down
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the name of the node.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NodeObject
Allow to set the text align

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoFontBold
Disable the additional text bold configuration

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: System.Management.Automation.ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableArray
An array of strings/objects to place in this record

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBackgroundColor
The subgraph table background color (Default: #ffffff)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: #ffffff
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBorder
The table border width (Default: 0)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBorderColor
The subgraph table border color (Default: #000000)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: #000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableStyle
Table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, DASHED)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Version:        0.2.30
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux

## RELATED LINKS
