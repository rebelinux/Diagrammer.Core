---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaRightLShapeLine
---

# Add-DiaRightLShapeLine

## SYNOPSIS

Adds a right-facing L-shaped connector to a diagram, composed of two lines and three nodes.

```
Example:
            (RightLShapeUp)
                    o_____o(RightLShapeRight)
                    |
  (RightLShapeDown) o
```

## SYNTAX

### __AllParameterSets

```
Add-DiaRightLShapeLine [[-RightLShapeUp] <string>] [[-RightLShapeDown] <string>]
 [[-RightLShapeRight] <string>] [[-Arrowtail] <string>] [[-Arrowhead] <string>]
 [[-LineStyle] <string>] [[-RightLShapeUpLineLength] <int>] [[-RightLShapeDownLineLength] <int>]
 [[-RightLShapeRightLineLength] <int>] [[-LineWidth] <int>] [[-LineColor] <string>]
 [[-IconDebug] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

- None

## DESCRIPTION

The Add-DiaRightLShapeLine function creates a right-facing L-shaped connector for use in diagram generation.
It defines three nodes (Up, Down, and Right) and connects them with two lines to form an L shape:

- A vertical line from the Up node to the Down node.
- A horizontal line from the Up node to the Right node.

The function allows customization of node names, line styles, arrow styles, colors, and lengths.
It is intended for use with diagramming tools that support node and edge definitions, such as Graphviz.

## EXAMPLES

### EXAMPLE 1

```powershell
# Creates a right-facing L-shaped connector with custom node names and a blue dashed line.

Add-DiaRightLShapeLine -RightLShapeUp "A" -RightLShapeDown "B" -RightLShapeRight "C" -LineColor "blue" -LineStyle "dashed"
```

!!! example
    === "Example 1"

        ```graphviz dot AddDiaRightLShapeLine.png
            digraph g {
                node [shape=plain];
                "A" [shape="point";fixedsize="true";fillcolor="transparent";color="blue";height="0.001";width="0.001";style="invis";]
                "B" [shape="point";fixedsize="true";fillcolor="transparent";color="blue";height="0.001";width="0.001";style="invis";]
                "C" [shape="point";fixedsize="true";fillcolor="transparent";color="blue";height="0.001";width="0.001";style="invis";]
                { rank=same;  "A"; "C"; }
                "A"->"B" [penwidth="1";arrowhead="none";arrowtail="none";color="blue";minlen="1";style="dashed";]
                "A"->"C" [penwidth="1";arrowhead="none";arrowtail="none";color="blue";minlen="";style="dashed";]
            }
        ```
    === "Example 1 - DraftMode"

        ```graphviz dot AddDiaRightLShapeLine_draftmode.png
            digraph g {
                node [shape=plain];
                "A" [color="black";fillcolor="red";shape="plain";style="filled";]
                "B" [color="black";fillcolor="red";shape="plain";style="filled";]
                "C" [color="black";fillcolor="red";shape="plain";style="filled";]
                { rank=same;  "A"; "C"; }
                "A"->"B" [penwidth="1";arrowhead="none";arrowtail="none";color="red";minlen="1";style="dashed";]
                "A"->"C" [penwidth="1";arrowhead="none";arrowtail="none";color="red";minlen="";style="dashed";]
            }
        ```


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

If set to $true, enables debug mode for icons, highlighting the nodes and lines in red for easier visualization.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
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

### -LineColor

The color of the lines.
Accepts any valid Graphviz color.
Default is 'black'.

```yaml
Type: System.String
DefaultValue: black
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

### -LineStyle

The style of the line (e.g., solid, dashed, dotted, bold, etc.).
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

The width of the lines (penwidth).
Range: 1 to 10.
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

### -RightLShapeDown

The name of the ending node at the bottom of the L shape (Down direction).
Default is 'RightLShapeDown'.

```yaml
Type: System.String
DefaultValue: RightLShapeDown
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

### -RightLShapeDownLineLength

The minimum length of the line from Down node (not used in current implementation).
Range: 1 to 10.
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

### -RightLShapeRight

The name of the rightmost node of the L shape (Right direction).
Default is 'RightLShapeRight'.

```yaml
Type: System.String
DefaultValue: RightLShapeRight
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

### -RightLShapeRightLineLength

The minimum length of the horizontal line from Up to Right.
Range: 1 to 10.
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

### -RightLShapeUp

The name of the starting node at the top of the L shape (Up direction).
Default is 'RightLShapeUp'.

```yaml
Type: System.String
DefaultValue: RightLShapeUp
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

### -RightLShapeUpLineLength

The minimum length of the vertical line from Up to Down.
Range: 1 to 10.
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

HTML string representing the right L-shaped connector with the specified nodes and properties.

## NOTES

```
Author: Jonathan Colon
Version: 0.6.30
GitHub: https://github.com/rebelinux/Diagrammer.Core
```


## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)
