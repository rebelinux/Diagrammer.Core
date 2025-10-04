---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaCrossShapeLine
---

# Add-DiaCrossShapeLine

## SYNOPSIS

Adds a customizable cross-shaped line (plus sign) to a diagram.

```
                    (CrossShapeMiddleTop)
Example:                    o
                            |
                            |
       (CrossShapeStart)o___o___o(CrossShapeEnd)
                            |
                            |
                            o
                    (CrossShapeMiddleDown)
```

## SYNTAX

### __AllParameterSets

```
Add-DiaCrossShapeLine [[-CrossShapeStart] <string>] [[-CrossShapeEnd] <string>]
 [[-CrossShapeMiddle] <string>] [[-CrossShapeMiddleTop] <string>] [[-CrossShapeMiddleDown] <string>]
 [[-Arrowtail] <string>] [[-Arrowhead] <string>] [[-LineStyle] <string>] [[-LineWidth] <int>]
 [[-CrossShapeStartLineLength] <int>] [[-CrossShapeEndLineLength] <int>]
 [[-CrossShapeMiddleTopLineLength] <int>] [[-CrossShapeMiddleDownLineLength] <int>]
 [[-LineColor] <string>] [[-IconDebug] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Add-DiaCrossShapeLine function creates a cross-shaped (plus sign) line object within a diagram, using configurable node names and visual properties.
The cross consists of a central node with lines extending vertically and horizontally, forming a symmetrical intersection.
This is useful for representing intersections, connection points, or central hubs in diagrammatic representations.

The function allows customization of:
- Node names for each segment of the cross (start, end, middle, top, down)
- Line style (solid, dashed, dotted, etc.)
- Line color and width
- Arrowhead and arrowtail styles
- Individual segment lengths
- Debug mode for visualizing node positions

## EXAMPLES

### EXAMPLE 1

```
# Adds a cross-shaped line to the diagram with default settings
Add-DiaCrossShapeLine

# Visual representation:
#         o
#         |
#         |
#  o------o------o
#         |
#         |
#         o
```

## PARAMETERS

### -Arrowhead

Style of the arrow head for the lines.
Accepts various Graphviz arrow styles.
Default is 'none'.

```yaml
Type: System.String
DefaultValue: none
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

### -Arrowtail

Style of the arrow tail for the lines.
Accepts various Graphviz arrow styles.
Default is 'none'.

```yaml
Type: System.String
DefaultValue: none
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

### -CrossShapeEnd

Name of the node at the right end of the horizontal line in the cross shape.
Default is 'CrossShapeEnd'.

```yaml
Type: System.String
DefaultValue: CrossShapeEnd
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

### -CrossShapeEndLineLength

Length of the line from CrossShapeMiddle to CrossShapeEnd.
Default is 1.

```yaml
Type: System.Int32
DefaultValue: 1
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

### -CrossShapeMiddle

Name of the central node where the vertical and horizontal lines intersect.
Default is 'CrossShapeMiddle'.

```yaml
Type: System.String
DefaultValue: CrossShapeMiddle
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

### -CrossShapeMiddleDown

Name of the node at the bottom end of the vertical line in the cross shape.
Default is 'CrossShapeMiddleDown'.

```yaml
Type: System.String
DefaultValue: CrossShapeMiddleDown
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

### -CrossShapeMiddleDownLineLength

Length of the line from CrossShapeMiddle to CrossShapeMiddleDown.
Default is 1.

```yaml
Type: System.Int32
DefaultValue: 1
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

### -CrossShapeMiddleTop

Name of the node at the top end of the vertical line in the cross shape.
Default is 'CrossShapeMiddleTop'.

```yaml
Type: System.String
DefaultValue: CrossShapeMiddleTop
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

### -CrossShapeMiddleTopLineLength

Length of the line from CrossShapeMiddleTop to CrossShapeMiddle.
Default is 1.

```yaml
Type: System.Int32
DefaultValue: 1
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

### -CrossShapeStart

Name of the node at the left end of the horizontal line in the cross shape.
Default is 'CrossShapeStart'.

```yaml
Type: System.String
DefaultValue: CrossShapeStart
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

### -CrossShapeStartLineLength

Length of the line from CrossShapeStart to CrossShapeMiddle.
Default is 1.

```yaml
Type: System.Int32
DefaultValue: 1
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

### -IconDebug

Switch to enable debug mode, which highlights the cross shape in red for easier visualization.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
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

### -LineColor

Color of the cross-shaped line.
Default is 'black'.
Supports Graphviz color names.

```yaml
Type: System.String
DefaultValue: black
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

### -LineStyle

Style of the line (e.g., solid, dashed, dotted, bold).
Default is 'solid'.

```yaml
Type: System.String
DefaultValue: solid
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

### -LineWidth

Width of the line (penwidth), from 1 to 10.
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

## NOTES

Version:        0.6.30
Author:         Jonathan Colon
Twitter:        @jcolonfzenpr
GitHub:         rebelinux


## RELATED LINKS

- [](https://github.com/rebelinux/Diagrammer.Core)
