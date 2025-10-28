---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaNodeIcon
---

# Add-DiaNodeIcon

## SYNOPSIS

Function to convert a Graphviz node label to a HTML Table with Icon

## SYNTAX

### __AllParameterSets

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

## ALIASES

This cmdlet has the following aliases,

None

## DESCRIPTION

Takes a string and converts it to a HTML table used for GraphViz Node label

## EXAMPLES

### EXAMPLE 1

```powershell
$Images = @{
    Server = "Server.png"
}
$DC = "Server-DC-01v"
$DCRows = @{
    Memory = "4GB"
    CPU = "2"
}
Add-DiaNodeIcon -Name $DC -IconType "Server" -Align "Center" -Rows $DCRows -ImagesObj $Images
```

!!! example
    === "Example 1"

        ```graphviz dot AddDiaLeftTShapeLine.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='14'>Server-DC-01v</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>CPU: 2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>Memory: 4GB</FONT></TD></TR></TABLE>>];
            }
        ```
    === "Example 1 - DraftMode"

        ```graphviz dot AddDiaLeftTShapeLine_draftmode.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui' Color='#565656' POINT-SIZE='14'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='14'>Server-DC-01v</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>CPU: 2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>Memory: 4GB</FONT></TD></TR></TABLE>>];
            }
        ```

## PARAMETERS

### -AditionalInfo

A hashtable or ordered hashtable containing additional information about the node.
This data is displayed as extra rows in the table.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
Aliases:
- RowsOrdered
- Rows
- AdditionalInfo
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Align

Specifies the alignment of the content inside the table cell.
Acceptable values are 'Center', 'Right', or 'Left'.
Default is 'Center'.

```yaml
Type: System.String
DefaultValue: Center
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CellBackgroundColor

Allow to set a cell background color (Hex format EX: #FFFFFF).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 14
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CellBorder

Specifies the width of the HTML cell border.
Default is 0.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CellPadding

Specifies the padding inside the HTML table cells.
Default is 5.

```yaml
Type: System.Int32
DefaultValue: 5
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CellSpacing

Specifies the spacing between HTML table cells.
Default is 5.

```yaml
Type: System.Int32
DefaultValue: 5
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FontColor

The cell text font color

```yaml
Type: System.String
DefaultValue: '#565656'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 7
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FontName

The cell text font name

```yaml
Type: System.String
DefaultValue: Segoe Ui
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 6
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -FontSize

Specifies the font size for the text inside the table.
Default is 14.

```yaml
Type: System.Int32
DefaultValue: 14
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
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

If set to $true, enables debug mode for icons, highlighting the table border in red for troubleshooting.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
ParameterSets:
- Name: (All)
  Position: 10
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IconType

Specifies the type of icon to use for the node.
This parameter is required.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 8
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ImagesObj

A hashtable mapping icon types to their corresponding image paths.
Used to resolve the icon image for the node.

```yaml
Type: System.Collections.Hashtable
DefaultValue: '@{}'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 9
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

The name of the node to display in the table.
This parameter is required.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 11
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
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

If specified, disables bold font for the text inside the table.

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TableBackgroundColor

Allow to set a table background color (Hex format EX: #FFFFFF).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 13
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TableBorder

Specifies the width of the HTML table border.
Default is 0.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 12
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

A string representing the HTML table for the node label.

## NOTES

```
Version:        0.2.30
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux
```

## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)

