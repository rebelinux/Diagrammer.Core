---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaVerticalLine
---

# Add-DiaVerticalLine

## SYNOPSIS

Adds a customizable vertical line between two nodes in a diagram.

Example:

    (VStart)o
            |
            |
            o(VEnd)

Demonstrates a vertical line connecting two nodes labeled 'VStart' and 'VEnd'.

## SYNTAX

### __AllParameterSets

```
Add-DiaVerticalLine [[-VStart] <string>] [[-VEnd] <string>] [[-Arrowtail] <string>]
 [[-Arrowhead] <string>] [[-LineStyle] <string>] [[-VStartLineLength] <int>] [[-LineWidth] <int>]
 [[-LineColor] <string>] [[-IconDebug] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Add-DiaVerticalLine function creates a vertical line connecting two specified nodes within a diagram,
supporting a variety of customization options.
You can control the line's style (solid, dashed, etc.),
length, width, and color, as well as the appearance of arrowheads or tails at either end.
This function
is ideal for visually representing relationships or connections between vertically aligned nodes in
diagramming scenarios, such as organizational charts, flow diagrams, or network topologies.

## EXAMPLES

### EXAMPLE 1

Add-DiaVerticalLine -VStart "NodeA" -VEnd "NodeB" -LineStyle "dashed" -LineColor "blue" -LineWidth 2

Draws a dashed blue vertical line of width 2 between nodes "NodeA" and "NodeB".

### EXAMPLE 2

Add-DiaVerticalLine -IconDebug $true

Draws a vertical line between the default nodes, highlighting the line and nodes in red for debugging.

## PARAMETERS

### -Arrowhead

Specifies the arrow style at the end (head) of the line.
Accepts Graphviz-supported arrow types
such as 'none', 'normal', 'dot', 'diamond', etc.

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

### -Arrowtail

Specifies the arrow style at the start (tail) of the line.
Accepts Graphviz-supported arrow types
such as 'none', 'normal', 'dot', 'diamond', etc.

```yaml
Type: System.String
DefaultValue: none
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

### -IconDebug

Switch to enable debug mode, which highlights the line and nodes for troubleshooting purposes.
When enabled, nodes and lines are rendered in red for visibility.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
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

Specifies the color of the vertical line.
Accepts any color name or code supported by Graphviz.
Defaults to 'black'.

```yaml
Type: System.String
DefaultValue: black
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

Sets the style of the line.
Valid values include 'solid', 'dashed', 'dotted', 'bold', 'invis',
'filled', and 'tapered'.

```yaml
Type: System.String
DefaultValue: solid
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

### -LineWidth

Sets the thickness of the vertical line (penwidth), in units from 1 to 10.

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

### -VEnd

The name of the ending node for the vertical line.
Defaults to 'VEnd'.

```yaml
Type: System.String
DefaultValue: VEnd
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

### -VStart

The name of the starting node for the vertical line.
Defaults to 'VStart'.

```yaml
Type: System.String
DefaultValue: VStart
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

### -VStartLineLength

Determines the minimum length of the vertical line (minlen), in units from 1 to 10.

```yaml
Type: System.Int32
DefaultValue: 1
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

Version:        0.6.30
Author:         Jonathan Colon
Twitter:        @jcolonfzenpr
GitHub:         rebelinux


## RELATED LINKS

- [](https://github.com/rebelinux/Diagrammer.Core)
