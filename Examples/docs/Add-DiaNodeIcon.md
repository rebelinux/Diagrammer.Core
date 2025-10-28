---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Add-DiaNodeIcon

## SYNOPSIS
Function to convert a Graphviz node label to a HTML Table with Icon

## SYNTAX

```
Add-DiaNodeIcon [[-AditionalInfo] <Object>] [[-Align] <String>] [[-CellBorder] <Int32>]
 [[-CellPadding] <Int32>] [[-CellSpacing] <Int32>] [[-FontSize] <Int32>] [[-FontName] <String>]
 [[-FontColor] <String>] [-FontBold] [-FontItalic] [-FontUnderline] [-FontOverline] [-FontSubscript]
 [-FontSuperscript] [-FontStrikeThrough] [-IconType] <String> [[-ImagesObj] <Hashtable>]
 [[-ImageSizePercent] <Int32>] [[-IconPath] <String>] [[-IconDebug] <Boolean>] [-Name] <String> [-NoFontBold]
 [[-TableBorder] <Int32>] [[-TableLayout] <String>] [[-TableBackgroundColor] <String>]
 [[-CellBackgroundColor] <String>] [-NodeObject] [[-GraphvizAttributes] <Hashtable>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Takes a string and converts it to a HTML table used for GraphViz Node label

## EXAMPLES

### EXAMPLE 1
```
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
```

## PARAMETERS

### -AditionalInfo
A hashtable, ordered dictionary, PSCustomObject, or array containing additional information about the node.
Each entry is rendered as an extra table row in the format "Key: Value".
(Note: parameter name is 'AditionalInfo'.)

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases: RowsOrdered, Rows, AdditionalInfo

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Align
Specifies the alignment of the content inside the table cell.
Acceptable values are 'Center', 'Right', or 'Left'.
Default is 'Center'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Center
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellBackgroundColor
Allows setting a cell background color (Hex format, e.g., #FFFFFF).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellBorder
Specifies the width of the HTML cell border.
Default is 0.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellPadding
Specifies the padding inside the HTML table cells.
Default is 5.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellSpacing
Specifies the spacing between HTML table cells.
Default is 5.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontBold
If specified, sets the font to bold for the text inside the table.

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
Specifies the font color for the text inside the table.
Default is '#000000'.

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
If specified, sets the font to italic for the text inside the table.

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
Specifies the font name for the text inside the table.
Default is 'Segoe Ui'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Segoe Ui
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontOverline
If specified, applies an overline to the font for the text inside the table.

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
Specifies the font size for the text inside the table.
Default is 14.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 14
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontStrikeThrough
If specified, applies a strikethrough to the font for the text inside the table.

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
If specified, sets the font to subscript for the text inside the table.

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
If specified, sets the font to superscript for the text inside the table.

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
If specified, underlines the font for the text inside the table.

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
A hashtable of additional Graphviz attributes to add to the node (for example: @{ style = 'filled'; color = 'lightgrey' }).
These are passed to Format-NodeObject when NodeObject is specified.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug
If set to $true, enables debug mode for icons, highlighting the table border/background in red for troubleshooting.

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

### -IconPath
Path to the folder containing the icon images.
Required when ImageSizePercent is less than 100.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconType
Specifies the type of icon to use for the node.
This parameter is required.
If set to 'NoIcon', no image is displayed.
Other values are resolved via ImagesObj or IconPath.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImageSizePercent
Sets the image size in percent (1-100).
Default is 100.
If less than 100, IconPath must be provided and Get-DiaImagePercent is used.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImagesObj
A hashtable mapping icon types to their corresponding image paths.
Used to resolve the icon image for the node.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the node to display in the table.
This parameter is required.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NodeObject
When specified, the function will register the generated HTML with the diagram engine by calling Format-NodeObject.
Use this to attach Graphviz node attributes and to have the node included in the internal node registry.
Note: the function validates that Name is present when NodeObject is used.

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
If specified, disables bold font for the text inside the table (overrides FontBold).

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

### -TableBackgroundColor
Allows setting a table background color (Hex format, e.g., #FFFFFF).

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

### -TableBorder
Specifies the width of the HTML table border.
Default is 0.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableLayout
Specifies the table layout, either 'Vertical' or 'Horizontal'.
Default is 'Vertical'.
Controls cell rowspan/colspan and positioning of the icon vs.
text rows.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: Vertical
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

Specifies the name of the node to process.

## RELATED LINKS
