---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaRightTShapeLine
---

# Add-DiaRightTShapeLine

## SYNOPSIS

Adds a Right T-shaped connector to a diagram, representing a vertical line intersecting a horizontal line to the right.
Example:
                        (RightTShapeUp)
                                o
                                |
    (RightTShapeMiddleLeft)o___o(RightTShapeMiddleRight)
                                |
                                o
                        (RightTShapeDown)

## SYNTAX

### __AllParameterSets

```
Add-DiaRightTShapeLine [[-RightTShapeUp] <string>] [[-RightTShapeDown] <string>]
 [[-RightTShapeMiddleRight] <string>] [[-RightTShapeMiddleLeft] <string>] [[-Arrowtail] <string>]
 [[-Arrowhead] <string>] [[-LineStyle] <string>] [[-LineSize] <int>]
 [[-RightTShapeUpLineLength] <int>] [[-RightTShapeDownLineLength] <int>]
 [[-RightTShapeMiddleRightLineLength] <int>] [[-LineWidth] <int>] [[-LineColor] <string>]
 [[-IconDebug] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Add-DiaRightTShapeLine function creates a Right T-shaped connector in a diagram, typically used for visualizing relationships or flows in diagrams such as Graphviz.
The connector consists of a vertical line intersecting a horizontal line to the right, forming a "T" shape.
The function allows customization of node names, line styles, arrowheads, colors, and lengths, and supports a debug mode for visual troubleshooting.

## EXAMPLES

### EXAMPLE 1

Add-DiaRightTShapeLine -RightTShapeUp "TopNode" -RightTShapeDown "BottomNode" -LineColor "blue" -LineStyle "dashed"

Creates a Right T-shaped connector with custom node names, blue dashed lines.

## PARAMETERS

### -Arrowhead

The style of the arrow head for the connector.
Supports various Graphviz arrow types.
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

The style of the arrow tail for the connector.
Supports various Graphviz arrow types.
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

Switch to enable debug mode, which highlights the nodes and lines in red for easier troubleshooting.
Default is $false.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
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

### -LineColor

The color of the connector line.
Accepts any color supported by Graphviz.
Default is 'black'.

```yaml
Type: System.String
DefaultValue: black
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

### -LineSize

The size of the connector line.
Range: 1-10.
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

### -LineStyle

The style of the connector line.
Valid values: 'dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered'.
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

The width of the connector line (penwidth).
Range: 1-10.
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

### -RightTShapeDown

The name of the bottom node in the T-shape.
Default is 'RightTShapeDown'.

```yaml
Type: System.String
DefaultValue: RightTShapeDown
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

### -RightTShapeDownLineLength

Length of the line (minlen), from 1 to 10.

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

### -RightTShapeMiddleLeft

The name of the left node at the intersection of the T-shape.
Default is 'RightTShapeMiddleLeft'.

```yaml
Type: System.String
DefaultValue: RightTShapeMiddleLeft
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

### -RightTShapeMiddleRight

The name of the right node at the intersection of the T-shape.
Default is 'RightTShapeMiddleRight'.

```yaml
Type: System.String
DefaultValue: RightTShapeMiddleRight
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

### -RightTShapeMiddleRightLineLength

Length of the line (minlen), from 1 to 10.

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

### -RightTShapeUp

The name of the top node in the T-shape.
Default is 'RightTShapeUp'.

```yaml
Type: System.String
DefaultValue: RightTShapeUp
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

### -RightTShapeUpLineLength

The length of the vertical line from the top node to the intersection.
Range: 1-10.
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
