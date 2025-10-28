---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Add-DiaHtmlTable

## SYNOPSIS
Converts a string array to an HTML table with Graphviz nodes split by columns (No Icons).

## SYNTAX

```
Add-DiaHtmlTable [[-Name] <String>] [[-Rows] <String[]>] [[-Align] <String>] [[-TableBorder] <Int32>]
 [[-CellBorder] <Int32>] [[-CellSpacing] <Int32>] [[-CellPadding] <Int32>] [[-FontColor] <String>]
 [[-FontSize] <Int32>] [[-FontName] <String>] [-FontBold] [-FontItalic] [-FontUnderline] [-FontOverline]
 [-FontSubscript] [-FontSuperscript] [-FontStrikeThrough] [[-ColumnSize] <Int32>] [[-ImagesObj] <Hashtable>]
 [[-IconDebug] <Boolean>] [[-TableStyle] <String>] [-NoFontBold] [-Subgraph] [[-SubgraphIconType] <String>]
 [[-SubgraphLabel] <String>] [[-SubgraphFontName] <String>] [[-SubgraphLabelFontsize] <Int32>]
 [[-SubgraphFontColor] <String>] [-SubgraphFontBold] [-SubgraphFontItalic] [-SubgraphFontUnderline]
 [-SubgraphFontOverline] [-SubgraphFontSubscript] [-SubgraphFontSuperscript] [-SubgraphFontStrikeThrough]
 [[-SubgraphLabelPos] <String>] [[-SubgraphTableStyle] <String>] [[-TableBorderColor] <String>]
 [[-SubgraphIconWidth] <String>] [[-SubgraphIconHeight] <String>] [-NodeObject]
 [[-GraphvizAttributes] <Hashtable>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function takes an array and converts it to an HTML table used for Graphviz node labels.

## EXAMPLES

### EXAMPLE 1
```
$SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
Add-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -ColumnSize 2
    _________________________________
    |               |               |
    |192.168.5.0/24 |192.168.7.0/24 |
    ________________________________
    |               |               |
    |  10.0.0.0/24  |               |
    _________________________________
```

$SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
Add-DiaHTMLTable -Rows $SiteSubnets -Align "Center"
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
Specifies the alignment of content inside the table cell.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Center
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellBorder
Specifies the table cell border size.

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

### -CellPadding
Specifies the padding inside table cells.

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
Specifies the spacing between table cells.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -ColumnSize
Specifies the number of columns to split the objects inside the HTML table.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontBold
Sets the cell text to bold.

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
Specifies the font color used inside the cell (Default: #000000).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: #000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontItalic
Sets the cell text to italic.

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
Specifies the font name of the cell text.

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
Sets the cell text to overline.

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
Specifies the font size of the cell text.

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
Sets the cell text to strikethrough.

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
Sets the cell text to subscript.

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
Sets the cell text to superscript.

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
Sets the cell text to underline.

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
Additional Graphviz attributes to add to the node.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug
Enables the table debug mode.

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

### -ImagesObj
A hashtable with the IconName to IconPath translation.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The node name (required if NodeObject is set).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NodeObject
Indicates that the table should be formatted as a Graphviz node object.

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
Disables additional text bold configuration.

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

### -Rows
An array of strings/objects to place in the table.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subgraph
Allows creating a table used to add a logo to a Graphviz subgraph.

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

### -SubgraphFontBold
Sets the subgraph label text to bold.

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

### -SubgraphFontColor
Specifies the font color used inside the cell (Default: #000000).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: #000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphFontItalic
Sets the subgraph label text to italic.

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

### -SubgraphFontName
The cell text font name

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: Segoe Ui
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphFontOverline
Sets the subgraph label text to overline.

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

### -SubgraphFontStrikeThrough
Sets the subgraph label text to strikethrough.

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

### -SubgraphFontSubscript
Sets the subgraph label text to subscript.

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

### -SubgraphFontSuperscript
Sets the subgraph label text to superscript.

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

### -SubgraphFontUnderline
Sets the subgraph label text to underline.

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

### -SubgraphIconHeight
Specifies the subgraph icon height.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphIconType
Specifies the subgraph icon type (requires ImagesObj).

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

### -SubgraphIconWidth
Specifies the subgraph icon width.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphLabel
Specifies the subgraph table label.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphLabelFontsize
Specifies the font size for the subgraph label.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: 14
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphLabelPos
Sets the subgraph label position (top, down).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: Down
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphTableStyle
Allows setting a table style for the subgraph (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBorder
Specifies the table border line size.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBorderColor
Specifies the table border color.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: #000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableStyle
Allows setting a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: Rounded,dashed
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Version:        0.2.32
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux

## RELATED LINKS
