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
Add-DiaNodeIcon [[-AditionalInfo] <Object>] [[-Align] <string>] [[-CellBorder] <int>]
 [[-CellPadding] <int>] [[-CellSpacing] <int>] [[-FontSize] <int>] [[-FontName] <string>]
 [[-FontColor] <string>] [-IconType] <string> [[-ImagesObj] <hashtable>] [[-IconDebug] <bool>]
 [-Name] <string> [[-TableBorder] <int>] [[-TableBackgroundColor] <string>]
 [[-CellBackgroundColor] <string>] [-NoFontBold] [<CommonParameters>]
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
                a [label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='14'>Server-DC-01v</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>CPU: 2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>Memory: 4GB</FONT></TD></TR></TABLE>>];
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
DefaultValue: Segoe Ui Black
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
Twitter:        @jcolonfzenpr
Github:         rebelinux
```

## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)

