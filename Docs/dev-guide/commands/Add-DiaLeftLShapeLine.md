---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaLeftLShapeLine
---

# Add-DiaLeftLShapeLine

## SYNOPSIS

Adds a left-oriented L-shaped connector to a diagram, composed of two lines and three nodes.

Example:
                (LeftLShapeUp)
(LeftLShapeLeft) o______o
                        |
                        |
                        o (LeftLShapeDown)

## SYNTAX

### __AllParameterSets

```
Add-DiaLeftLShapeLine [[-LeftLShapeUp] <string>] [[-LeftLShapeDown] <string>]
 [[-LeftLShapeLeft] <string>] [[-Arrowtail] <string>] [[-Arrowhead] <string>]
 [[-LineStyle] <string>] [[-LeftLShapeUpLineLength] <int>] [[-LeftLShapeLeftLineLength] <int>]
 [[-LineWidth] <int>] [[-LineColor] <string>] [[-IconDebug] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Add-DiaLeftLShapeLine function creates a left-facing L-shaped connector for use in diagram generation, such as with Graphviz.
The connector consists of two lines (vertical and horizontal) and three nodes, allowing for customizable styles, colors, arrowheads, and lengths.
This function is useful for visually representing relationships or flows in diagrams where an L-shaped connection is required.

## EXAMPLES

### EXAMPLE 1

Add-DiaLeftLShapeLine -LeftLShapeUp "StartNode" -LeftLShapeDown "EndNode" -LeftLShapeLeft "LeftNode" -LineColor "blue" -LineStyle "dashed"

Creates a blue, dashed, left-oriented L-shaped connector between the specified nodes.

## PARAMETERS

### -Arrowhead

The arrow style at the end of the line (arrowhead).
Accepts various Graphviz arrow styles.
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

The arrow style at the start of the line (arrowtail).
Accepts various Graphviz arrow styles.
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

If set to $true, enables debug mode, highlighting the nodes and lines in red for easier visualization during development.

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

### -LeftLShapeDown

The name of the ending node at the bottom of the L shape (vertical segment).
Default is 'LeftLShapeDown'.

```yaml
Type: System.String
DefaultValue: LeftLShapeDown
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

### -LeftLShapeLeft

The name of the node at the left end of the L shape (horizontal segment).
Default is 'LeftLShapeLeft'.

```yaml
Type: System.String
DefaultValue: LeftLShapeLeft
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

### -LeftLShapeLeftLineLength

The length (minlen) of the horizontal segment of the L shape, from 1 to 10.
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

### -LeftLShapeUp

The name of the starting node at the top of the L shape (vertical segment).
Default is 'LeftLShapeUp'.

```yaml
Type: System.String
DefaultValue: LeftLShapeUp
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

### -LeftLShapeUpLineLength

The length (minlen) of the vertical segment of the L shape, from 1 to 10.
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

### -LineColor

The color of the lines.
Accepts any color supported by Graphviz.
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

The style of the line (e.g., solid, dashed, dotted, etc.).
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

The width (penwidth) of the lines, from 1 to 10.
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
