---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaHTMLTable
---

# Add-DiaHTMLTable

## SYNOPSIS

Converts a string array to an HTML table with Graphviz nodes split by columns (No Icons).

## SYNTAX

### __AllParameteSets

```
Add-DiaHTMLTable [[-Name] <string>] [[-Rows] <string[]>] [[-Align] <string>] [[-TableBorder] <int>]
 [[-CellBorder] <int>] [[-CellSpacing] <int>] [[-CellPadding] <int>] [[-fontColor] <string>]
 [[-FontSize] <int>] [[-fontName] <string>] [[-ColumnSize] <int>] [[-ImagesObj] <hashtable>]
 [[-IconDebug] <bool>] [[-TableStyle] <string>] [[-SubgraphIconType] <string>]
 [[-SubgraphLabel] <string>] [[-SubgraphLabelFontsize] <int>] [[-SubgraphLabelPos] <string>]
 [[-SubgraphTableStyle] <string>] [[-TableBorderColor] <string>] [[-SubgraphIconWidth] <string>]
 [[-SubgraphIconHeight] <string>] [[-GraphvizAttributes] <hashtable>] [-NoFontBold] [-Subgraph]
 [-NodeObject] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

- None

## DESCRIPTION

This function takes an array and converts it to an HTML table used for Graphviz node labels.

## EXAMPLES

### EXAMPLE 1

```powershell
$SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
Add-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -ColumnSize 3
```

!!! example
    === "Example 1"

        ```graphviz dot AddDiaHTMLTable.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE STYLE="rounded,dashed" COLOR="#000000" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>>];
            }
        ```
    === "Example 1 - DraftMode"

        ```graphviz dot AddDiaHTMLTable_draftmode.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>>];
            }
        ```

```powershell
$SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
Add-DiaHTMLTable -Rows $SiteSubnets -Align "Center"
```

!!! example
    === "Example 2"

        ```graphviz dot AddDiaHTMLTable2.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE STYLE="rounded,dashed" COLOR="#000000" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>>];
            }
        ```
    === "Example 2 - DraftMode"

        ```graphviz dot AddDiaHTMLTable2_draftmode.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>>];
            }
        ```

## PARAMETERS

### -Align

Specifies the alignment of content inside the table cell.

```yaml
Type: System.String
DefaultValue: center
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

### -CellBorder

Specifies the table cell border size.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -CellPadding

Allow to set the padding of the html cell border

```yaml
Type: System.Int32
DefaultValue: 5
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

### -CellSpacing

Allow to set the spacing of the html cell border

```yaml
Type: System.Int32
DefaultValue: 5
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

### -ColumnSize

Specifies the number of columns to split the objects inside the HTML table.

```yaml
Type: System.Int32
DefaultValue: 2
SupportsWildcards: false
Aliases: []
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

### -fontColor

Specifies the font color used inside the cell (Default: #565656).

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

### -fontName

Specifies the font name of the cell text.

```yaml
Type: System.String
DefaultValue: Segoe Ui Black
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

### -FontSize

Specifies the font size of the cell text.

```yaml
Type: System.Int32
DefaultValue: 14
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 8
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -GraphvizAttributes

Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)

```yaml
Type: System.Collections.Hashtable
DefaultValue: '@{}'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 22
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IconDebug

Sets the table debug mode.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
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

### -ImagesObj

A hashtable with the IconName to IconPath translation.

```yaml
Type: System.Collections.Hashtable
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 11
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

The node name (optional

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
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

### -NodeObject

Allow to set the text align

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

### -NoFontBold

Disable the aditional text bold configuration

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

### -Rows

An array of strings/objects to place in the table.

```yaml
Type: System.String[]
DefaultValue: ''
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

### -Subgraph

Allows creating a table used to add a logo to a Graphviz subgraph.

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

### -SubgraphIconHeight

Allow to set a subgraph icon height

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 21
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SubgraphIconType

Allow to set the subgraph table icon

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

### -SubgraphIconWidth

Allow to set a subgraph icon width

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 20
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SubgraphLabel

Allow to set the subgraph table label

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 15
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SubgraphLabelFontsize

Allow to set the subgraph table label font size

```yaml
Type: System.Int32
DefaultValue: 14
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 16
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SubgraphLabelPos

Allow to set the subgraph table label position (top, down)

```yaml
Type: System.String
DefaultValue: down
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 17
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SubgraphTableStyle

Allows setting a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 18
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TableBorder

Specifies the table border line size.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -TableBorderColor

Allow to set a table border color

```yaml
Type: System.String
DefaultValue: '#000000'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 19
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TableStyle

Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)

```yaml
Type: System.String
DefaultValue: rounded,dashed
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

A string that can be used as a Graphviz node label.

## NOTES

```
Version:        0.2.30
Author:         Jonathan Colon
Twitter:        @jcolonfzenpr
Github:         rebelinux
```


## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)
