---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaNodeShape
---

# Add-DiaNodeShape

## SYNOPSIS

Generates an Node with a specific shape and customizable attributes for diagramming purposes.

## SYNTAX

### __AllParameterSets

```
Add-DiaNodeShape [-Name] <string> [-Shape] <string> [[-IconDebug] <bool>]
 [[-GraphvizAttributes] <hashtable>] [[-ShapeFillColor] <string>] [[-ShapeLineColor] <string>]
 [[-ShapeFontColor] <string>] [[-ShapeFontSize] <int>] [[-ShapeFontName] <string>]
 [[-ShapeStyle] <string>] [[-ShapeWidth] <float>] [[-ShapeHeight] <float>]
 [[-ShapeBorderSize] <int>] [[-ShapeOrientation] <int>] [[-ShapeLabelPosition] <string>]
 [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

- None

## DESCRIPTION

The Add-DiaNodeShape function creates an Node with a specific shape and customizable attributes for diagramming purposes.
It supports customization of the node's appearance, including border width, color, style, and image size percentage.
The function also allows for debug mode, which highlights the node for easier troubleshooting, and supports specifying the icon image via a hashtable object.

## EXAMPLES

### EXAMPLE 1

```
# Generates an HTML table with a Node of shape "box", red solid border.

$DraftMode = $false

Add-DiaNodeShape -Name "Firewall" -Shape rectangle -ShapeStyle 'filled' -ShapeFillColor 'red:white' -ShapeFontSize 14 -ShapeFontColor 'black' -ShapeFontName 'Arial' -ShapeWidth 3 -ShapeLabelPosition center -ShapeLineColor 'black' -DraftMode:$DraftMode
```


!!! example
    === "Example 1"

        ```graphviz dot AddDiaNodeShape.png
            digraph g {
                node [shape=plain];
                "Firewall" [fontcolor="black";fillcolor="red:white";fontsize="14";penwidth="1";height="0.5";style="filled";label="Firewall";labelloc="c";fontname="Arial";width="3";orientation="0";shape="rectangle";color="black";]
            }
        ```
    === "Example 1 - DraftMode"

        ```graphviz dot AddDiaNodeShape_draftmode.png
            digraph g {
                node [shape=plain];
                "Firewall" [fontcolor="black";fillcolor="red:white";fontsize="14";penwidth="1";height="0.5";style="filled";label="Firewall";labelloc="c";fontname="Arial";width="3";orientation="0";shape="rectangle";color="red";]
            }
        ```

## PARAMETERS

### -GraphvizAttributes

Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)

```yaml
Type: System.Collections.Hashtable
DefaultValue: '@{}'
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

Enables debug mode for icons.
When set to $true, the table border is highlighted in red to assist with visual debugging.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
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

### -Name

Specifies the name of the node to be illustrated.
This is a required parameter.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Shape

Set the shape of the node. (https://graphviz.org/doc/info/shapes.html)

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ShapeBorderSize

Shape Border Size (1-10).

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

### -ShapeFillColor

Shape Fill Color.

```yaml
Type: System.String
DefaultValue: transparent
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

### -ShapeFontColor

Shape Font Color.

```yaml
Type: System.String
DefaultValue: black
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

### -ShapeFontName

Shape Font Name.

```yaml
Type: System.String
DefaultValue: Times-Roman
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

### -ShapeFontSize

Shape Font Size.

```yaml
Type: System.Int32
DefaultValue: 14
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

### -ShapeHeight

Shape Height.

```yaml
Type: System.Single
DefaultValue: 0.5
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

### -ShapeLabelPosition

Shape Label Position (top, bottom, center). Default is center.

```yaml
Type: System.String
DefaultValue: center
SupportsWildcards: false
Aliases: []
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

### -ShapeLineColor

Shape Line Color.

```yaml
Type: System.String
DefaultValue: black
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

### -ShapeOrientation

Shape Orientation (0-360 degrees).

```yaml
Type: System.Int32
DefaultValue: 0
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

### -ShapeStyle

Shape Style (e.g., filled, dashed, wedged, dotted, solid, striped, diagonals, rounded, bold, invisible; can be combined with commas Ex: dashed,rounded).

```yaml
Type: System.String
DefaultValue: filled
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

### -ShapeWidth

Shape Width.

```yaml
Type: System.Single
DefaultValue: 0.75
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

HTML string representing the node with the specified shape and properties.

## NOTES

```
Author: Jonathan Colon
Version: 0.2.30
Twitter: @jcolonfzenpr
Github: rebelinux
```


## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)
