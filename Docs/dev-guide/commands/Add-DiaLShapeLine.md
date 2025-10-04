---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaLShapeLine
---

# Add-DiaLShapeLine

## SYNOPSIS

Adds an L-shaped connector to a diagram, composed of two lines and three nodes.

Example:
            (LShapeUp)
                o
                |
    (LShapeDown)o___o(LShapeRight)

## SYNTAX

### __AllParameterSets

```
Add-DiaLShapeLine [[-LShapeUp] <string>] [[-LShapeDown] <string>] [[-LShapeRight] <string>]
 [[-Arrowtail] <string>] [[-Arrowhead] <string>] [[-LineStyle] <string>]
 [[-LShapeUpLineLength] <int>] [[-LShapeRightLength] <int>] [[-LineWidth] <int>]
 [[-LineColor] <string>] [[-IconDebug] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Add-DiaLShapeLine function creates an L-shaped connector for use in diagram generation, such as with Graphviz or similar tools.
The connector consists of two lines joined at a corner node, forming an "L" shape.
The function allows customization of node names,
arrow styles, line styles, lengths, widths, and colors.
It also supports a debug mode for visualizing node placement.

## EXAMPLES

### EXAMPLE 1

Add-DiaLShapeLine -LShapeUp "Start" -LShapeDown "Corner" -LShapeRight "End" -Arrowhead "normal" -LineStyle "dashed" -LineColor "blue"

Creates an L-shaped connector from node "Start" down to "Corner", then right to "End", with a normal arrowhead, dashed blue lines.

## PARAMETERS

### -Arrowhead

The arrow style at the end of each line (Graphviz 'arrowhead' attribute).
Accepts various styles such as 'none', 'normal', 'dot', etc.
Default is 'none'.

```yaml
Type: System.String
DefaultValue: none
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

### -Arrowtail

The arrow style at the start of each line (Graphviz 'arrowtail' attribute).
Accepts various styles such as 'none', 'normal', 'dot', etc.
Default is 'none'.

```yaml
Type: System.String
DefaultValue: none
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

### -IconDebug

If set to $true, enables debug mode for icons, highlighting the nodes and lines in red for easier visualization.
Default is $false.

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

### -LineColor

The color of the connector lines.
Accepts any color supported by Graphviz (see https://graphviz.org/doc/info/colors.html).
Default is 'black'.

```yaml
Type: System.String
DefaultValue: black
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

### -LineStyle

The style of the connector lines.
Valid values are 'dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered'.
Default is 'solid'.

```yaml
Type: System.String
DefaultValue: solid
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

### -LineWidth

The width of the connector lines (penwidth), from 1 to 10.
Default is 1.

```yaml
Type: System.Int32
DefaultValue: 1
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

### -LShapeDown

The name of the corner node (where the vertical and horizontal segments meet, "down" direction).
Default is 'LShapeDown'.

```yaml
Type: System.String
DefaultValue: LShapeDown
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

### -LShapeRight

The name of the ending node (horizontal segment, "right" direction) for the L shape.
Default is 'LShapeRight'.

```yaml
Type: System.String
DefaultValue: LShapeRight
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

### -LShapeRightLength

The length of the horizontal segment (minlen), from 1 to 10.
Default is 1.

```yaml
Type: System.Int32
DefaultValue: 1
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

### -LShapeUp

The name of the starting node (vertical segment, "up" direction) for the L shape.
Default is 'LShapeUp'.

```yaml
Type: System.String
DefaultValue: LShapeUp
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

### -LShapeUpLineLength

The length of the vertical segment (minlen), from 1 to 10.
Default is 1.

```yaml
Type: System.Int32
DefaultValue: 1
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

{{ Fill in the Description }}

## NOTES

Author: Jonathan Colon
Version: 0.6.30
GitHub: https://github.com/rebelinux/Diagrammer.Core


## RELATED LINKS

- [](https://github.com/rebelinux/Diagrammer.Core)
