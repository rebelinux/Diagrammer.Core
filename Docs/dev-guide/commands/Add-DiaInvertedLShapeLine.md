---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaInvertedLShapeLine
---

# Add-DiaInvertedLShapeLine

## SYNOPSIS

Adds an inverted L-shaped line to a diagram, connecting three nodes with customizable styles and attributes.

        (InvertedLShapeUp)  o___o (InvertedLShapeRight)
Example:                    |
                            o
                    (InvertedLShapeDown)

## SYNTAX

### __AllParameterSets

```
Add-DiaInvertedLShapeLine [[-InvertedLShapeUp] <string>] [[-InvertedLShapeDown] <string>]
 [[-InvertedLShapeRight] <string>] [[-Arrowtail] <string>] [[-Arrowhead] <string>]
 [[-LineStyle] <string>] [[-LineWidth] <int>] [[-InvertedLShapeUpLineLength] <int>]
 [[-InvertedLShapeRightLineLength] <int>] [[-LineColor] <string>] [[-IconDebug] <bool>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Add-DiaInvertedLShapeLine function creates an inverted L-shaped connector in a diagram by linking three nodes:
- The "Up" node (vertical start)
- The "Down" node (vertical end)
- The "Right" node (horizontal branch)

The function allows customization of arrow styles, line styles, widths, colors, and node appearance.
It is useful for visually representing relationships or flows in diagrams where an inverted L-shape is needed.

## EXAMPLES

### EXAMPLE 1

Add-DiaInvertedLShapeLine -InvertedLShapeUp "NodeA" -InvertedLShapeDown "NodeB" -InvertedLShapeRight "NodeC" -Arrowhead "normal" -LineStyle "dashed" -LineColor "blue"

Creates an inverted L-shaped line from NodeA down to NodeB and right to NodeC, with a normal arrowhead, dashed blue line.

## PARAMETERS

### -Arrowhead

The arrow style at the end of the line (head).
Accepts various Graphviz arrow styles.

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

The arrow style at the start of the line (tail).
Accepts various Graphviz arrow styles.

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

### -InvertedLShapeDown

The name of the ending node at the bottom of the inverted L-shape (vertical segment).

```yaml
Type: System.String
DefaultValue: InvertedLShapeDown
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

### -InvertedLShapeRight

The name of the node at the right end of the horizontal segment of the inverted L-shape.

```yaml
Type: System.String
DefaultValue: InvertedLShapeRight
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

### -InvertedLShapeRightLineLength

The minimum length of the horizontal segment (from Up to Right), from 1 to 10.

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

### -InvertedLShapeUp

The name of the starting node at the top of the inverted L-shape (vertical segment).

```yaml
Type: System.String
DefaultValue: InvertedLShapeUp
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

### -InvertedLShapeUpLineLength

The minimum length of the vertical segment (from Up to Down), from 1 to 10.

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

### -LineColor

The color of the line.
Accepts any color supported by Graphviz (see https://graphviz.org/doc/info/colors.html).

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

The style of the line connecting the nodes (e.g., solid, dashed, dotted, bold, etc.).

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

The width of the line (penwidth), from 1 to 10.

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
