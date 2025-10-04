---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaTShapeLine
---

# Add-DiaTShapeLine

## SYNOPSIS

Adds a T-shaped connector to a diagram, linking four nodes with customizable line styles, widths, and colors.
Example:
                        (TShapeMiddleUp)
        (TShapeLeft)o___o___o(TShapeRight)
                        |
                        o
                        (TShapeMiddleDown)

## SYNTAX

### __AllParameterSets

```
Add-DiaTShapeLine [[-TShapeLeft] <string>] [[-TShapeRight] <string>] [[-TShapeMiddleUp] <string>]
 [[-TShapeMiddleDown] <string>] [[-Arrowtail] <string>] [[-Arrowhead] <string>]
 [[-LineStyle] <string>] [[-TShapeLeftLineLength] <int>] [[-TShapeRightLineLength] <int>]
 [[-TShapeMiddleDownLineLength] <int>] [[-LineWidth] <int>] [[-LineColor] <string>]
 [[-IconDebug] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Add-DiaTShapeLine function creates a T-shaped (⊥) connector in a diagram by connecting four nodes:
- A horizontal line between a left node, a middle (top) node, and a right node.
- A vertical line extending down from the middle node to a lower node.

The function supports customization of:
- Node names for each point of the T-shape.
- Arrowhead and arrowtail styles (Graphviz types).
- Line style (solid, dashed, dotted, etc.).
- Individual line segment lengths for left, right, and vertical lines.
- Line width and color.
- Debug mode to visually highlight nodes and lines for troubleshooting.

## EXAMPLES

### EXAMPLE 1

Add-DiaTShapeLine -TShapeLeft "A" -TShapeRight "B" -TShapeMiddleUp "C" -TShapeMiddleDown "D" -LineStyle "dashed" -LineColor "blue"

Creates a T-shaped connector with custom node names, dashed blue lines, and default arrow styles.

## PARAMETERS

### -Arrowhead

The style of the arrow head for the connecting lines.
Accepts Graphviz arrow types.
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

The style of the arrow tail for the connecting lines.
Accepts Graphviz arrow types.
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
  Position: 12
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
Accepts any Graphviz-supported color.
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

The style of the connecting lines (e.g., solid, dashed, dotted, bold).
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

The width (penwidth) of the lines.
Range: 1-10.
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

### -TShapeLeft

The name of the starting node on the horizontal line (left side).
Default is 'TShapeLeft'.

```yaml
Type: System.String
DefaultValue: TShapeLeft
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

### -TShapeLeftLineLength

The minimum length (Graphviz minlen) of the left horizontal segment.
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

### -TShapeMiddleDown

The name of the node at the bottom of the vertical line.
Default is 'TShapeMiddleDown'.

```yaml
Type: System.String
DefaultValue: TShapeMiddleDown
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

### -TShapeMiddleDownLineLength

The minimum length (Graphviz minlen) of the vertical segment.
Range: 1-10.
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

### -TShapeMiddleUp

The name of the node at the intersection of the T (top of the vertical line).
Default is 'TShapeMiddleUp'.

```yaml
Type: System.String
DefaultValue: TShapeMiddleUp
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

### -TShapeRight

The name of the ending node on the horizontal line (right side).
Default is 'TShapeRight'.

```yaml
Type: System.String
DefaultValue: TShapeRight
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

### -TShapeRightLineLength

The minimum length (Graphviz minlen) of the right horizontal segment.
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
