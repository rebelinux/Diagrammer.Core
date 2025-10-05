---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaInvertedTShapeLine
---

# Add-DiaInvertedTShapeLine

## SYNOPSIS

Creates an inverted T-shaped ( _|_ ) connector in a diagram, linking four nodes with customizable line styles, colors, and attributes.

```
Example:
                    (InvertedTMiddleTop)
                            o
                            |
        (InvertedTStart)o___|___o(InvertedTEnd)
                            o
                    (InvertedTMiddleDown)
```

## SYNTAX

### __AllParameterSets

```
Add-DiaInvertedTShapeLine [[-InvertedTStart] <string>] [[-InvertedTEnd] <string>]
 [[-InvertedTMiddleTop] <string>] [[-InvertedTMiddleDown] <string>] [[-Arrowtail] <string>]
 [[-Arrowhead] <string>] [[-LineStyle] <string>] [[-InvertedTStartLineLength] <int>]
 [[-InvertedTEndLineLength] <int>] [[-InvertedTMiddleTopLength] <int>] [[-LineWidth] <int>]
 [[-LineColor] <string>] [[-IconDebug] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

- None

## DESCRIPTION

The Add-DiaInvertedTShapeLine function generates an inverted T-shaped structure in a diagram by connecting four specified nodes:
    - InvertedTStart: The left endpoint of the horizontal line.
    - InvertedTEnd: The right endpoint of the horizontal line.
    - InvertedTMiddleTop: The top endpoint of the vertical line.
    - InvertedTMiddleDown: The intersection point (center of the T).

The function allows customization of line style, color, width, and arrowheads/tails for each segment.
It also supports a debug mode to visually highlight the nodes for troubleshooting.

## EXAMPLES

### EXAMPLE 1

```powershell
# Creates an inverted T-shaped connector with custom node names, blue dashed lines, and default arrow styles.

Add-DiaInvertedTShapeLine -InvertedTStart "A" -InvertedTEnd "B" -InvertedTMiddleTop "C" -InvertedTMiddleDown "D" -LineColor "blue" -LineStyle "dashed"
```


!!! example
    === "Example 1"

        ```graphviz dot AddDiaInvertedTShapeLine.png
            digraph g {
                "A" [shape="point";fixedsize="true";fillcolor="transparent";height="0.001";width="0.001";style="invis";]
                "C" [shape="point";fixedsize="true";fillcolor="transparent";height="0.001";width="0.001";style="invis";]
                "B" [shape="point";fixedsize="true";fillcolor="transparent";height="0.001";width="0.001";style="invis";]
                "D" [shape="point";fixedsize="true";fillcolor="transparent";height="0.001";width="0.001";style="invis";]
                { rank=same;  "A"; "D"; "B"; }
                "A"->"D" [penwidth="1";arrowhead="none";arrowtail="none";color="blue";minlen="1";style="dashed";]
                "D"->"B" [penwidth="1";arrowhead="none";arrowtail="none";color="blue";minlen="1";style="dashed";]
                "C"->"D" [penwidth="1";arrowhead="none";arrowtail="none";color="blue";minlen="1";style="dashed";]
            }
        ```
    === "Example 1 - DraftMode"

        ```graphviz dot AddDiaInvertedTShapeLine_draftmode.png
            digraph g {
                "A" [fillcolor="red";style="filled";shape="plain";scolor="black";]
                "C" [fillcolor="red";style="filled";shape="plain";scolor="black";]
                "B" [fillcolor="red";style="filled";shape="plain";scolor="black";]
                "D" [fillcolor="red";style="filled";shape="plain";scolor="black";]
                { rank=same;  "A"; "D"; "B"; }
                "A"->"D" [penwidth="1";arrowhead="none";arrowtail="none";color="red";minlen="1";style="dashed";]
                "D"->"B" [penwidth="1";arrowhead="none";arrowtail="none";color="red";minlen="1";style="dashed";]
                "C"->"D" [penwidth="1";arrowhead="none";arrowtail="none";color="red";minlen="1";style="dashed";]
            }
        ```

## PARAMETERS

### -Arrowhead

The style of the arrow head for the lines.
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

The style of the arrow tail for the lines.
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

### -InvertedTEnd

The name of the node at the end (right) of the horizontal line.
Default is 'InvertedTEnd'.

```yaml
Type: System.String
DefaultValue: InvertedTEnd
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

### -InvertedTEndLineLength

The minimum length of the line from InvertedTMiddleDown to InvertedTEnd (1-10).
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

### -InvertedTMiddleDown

The name of the node at the intersection (center) of the T.
Default is 'InvertedTMiddleDown'.

```yaml
Type: System.String
DefaultValue: InvertedTMiddleDown
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

### -InvertedTMiddleTop

The name of the node at the top of the vertical line.
Default is 'InvertedTMiddleTop'.

```yaml
Type: System.String
DefaultValue: InvertedTMiddleTop
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

### -InvertedTMiddleTopLength

The minimum length of the line from InvertedTMiddleTop to InvertedTMiddleDown (1-10).
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

### -InvertedTStart

The name of the node at the start (left) of the horizontal line.
Default is 'InvertedTStart'.

```yaml
Type: System.String
DefaultValue: InvertedTStart
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

### -InvertedTStartLineLength

The minimum length of the line from InvertedTStart to InvertedTMiddleDown (1-10).
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

The width of the lines (penwidth), from 1 to 10.
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

The cmdlet returns the names of the nodes that were connected by the inverted T-shaped line.

## NOTES

```
Author: Jonathan Colon
Version: 0.6.30
GitHub: https://github.com/rebelinux/Diagrammer.Core
```


## RELATED LINKS

- [Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)
