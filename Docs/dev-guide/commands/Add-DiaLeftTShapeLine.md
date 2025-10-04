---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaLeftTShapeLine
---

# Add-DiaLeftTShapeLine

## SYNOPSIS

Adds a Left T-shaped connector to a diagram, representing a vertical line intersecting a horizontal line extending to the right.

Example:
                (LeftTShapeUp)
                        o
                        |
                        |
        (LeftTShapeEnd) o___o (RightTShapeEnd)
                        |
                        |
                        o
                (LeftTShapeDown)

## SYNTAX

### __AllParameterSets

```
Add-DiaLeftTShapeLine [[-LeftTShapeUp] <string>] [[-LeftTShapeDown] <string>]
 [[-LeftTShapeMiddleRight] <string>] [[-LeftTShapeMiddleLeft] <string>] [[-Arrowtail] <string>]
 [[-Arrowhead] <string>] [[-LineStyle] <string>] [[-LineWidth] <int>]
 [[-LeftTShapeUpLineLength] <int>] [[-LeftTShapeDownLineLength] <int>]
 [[-LeftTShapeMiddleLeftLineLength] <int>] [[-LineColor] <string>] [[-IconDebug] <bool>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Add-DiaLeftTShapeLine function creates a Left T-shaped connector in a diagram by defining four nodes and connecting them with edges.
This shape is commonly used to represent branching or intersection points in diagrams, such as flowcharts or network diagrams.
The function allows customization of node names, line styles, arrow types, line widths, and colors.
It also supports a debug mode for visualizing node placement.

## EXAMPLES

### EXAMPLE 1

Add-DiaLeftTShapeLine -LeftTShapeUp "Top" -LeftTShapeDown "Bottom" -LeftTShapeMiddleRight "Right" -LeftTShapeMiddleLeft "Center" -LineColor "blue" -LineStyle "dashed"

Creates a blue, dashed Left T-shaped connector with custom node names.

## PARAMETERS

### -Arrowhead

The style of the arrow head for the edges.
Accepts various Graphviz arrow types.
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

### -Arrowtail

The style of the arrow tail for the edges.
Accepts various Graphviz arrow types.
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

### -IconDebug

Switch to enable debug mode, which highlights the nodes and lines in red for easier visualization.
Default is $false.

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

### -LeftTShapeDown

The name of the lower node in the T-shape.
Default is 'LeftTShapeDown'.

```yaml
Type: System.String
DefaultValue: LeftTShapeDown
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

### -LeftTShapeDownLineLength

The minimum length of the line from the intersection to the lower node.
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

### -LeftTShapeMiddleLeft

The name of the left node at the intersection of the T-shape.
Default is 'LeftTShapeMiddleLeft'.

```yaml
Type: System.String
DefaultValue: LeftTShapeMiddleLeft
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

### -LeftTShapeMiddleLeftLineLength

Width of the line (minlen), from 1 to 10.

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

### -LeftTShapeMiddleRight

The name of the right node at the intersection of the T-shape.
Default is 'LeftTShapeMiddleRight'.

```yaml
Type: System.String
DefaultValue: LeftTShapeMiddleRight
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

### -LeftTShapeUp

The name of the up node in the T-shape.
Default is 'LeftTShapeUp'.

```yaml
Type: System.String
DefaultValue: LeftTShapeUp
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

### -LeftTShapeUpLineLength

The minimum length of the line from the up node to the intersection.
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

### -LineColor

The color of the connector lines.
Accepts any valid Graphviz color.
Default is 'black'.

```yaml
Type: System.String
DefaultValue: black
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

### -LineStyle

The style of the line connecting the nodes.
Options include 'dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered'.
Default is 'solid'.

```yaml
Type: System.String
DefaultValue: solid
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
  Position: 7
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
