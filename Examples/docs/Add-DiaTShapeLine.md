---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
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

```
Add-DiaTShapeLine [[-TShapeLeft] <String>] [[-TShapeRight] <String>] [[-TShapeMiddleUp] <String>]
 [[-TShapeMiddleDown] <String>] [[-Arrowtail] <String>] [[-Arrowhead] <String>] [[-LineStyle] <String>]
 [[-TShapeLeftLineLength] <Int32>] [[-TShapeRightLineLength] <Int32>] [[-TShapeMiddleDownLineLength] <Int32>]
 [[-LineWidth] <Int32>] [[-LineColor] <String>] [[-IconDebug] <Boolean>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

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
```
Add-DiaTShapeLine -TShapeLeft "A" -TShapeRight "B" -TShapeMiddleUp "C" -TShapeMiddleDown "D" -LineStyle "dashed" -LineColor "blue"
```

Creates a T-shaped connector with custom node names, dashed blue lines, and default arrow styles.

## PARAMETERS

### -Arrowhead
The style of the arrow head for the connecting lines.
Accepts Graphviz arrow types.
Default is 'none'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Arrowtail
The style of the arrow tail for the connecting lines.
Accepts Graphviz arrow types.
Default is 'none'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug
Switch to enable debug mode, which highlights the nodes and lines in red for easier troubleshooting.
Default is $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: DraftMode

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LineColor
The color of the lines.
Accepts any Graphviz-supported color.
Default is 'black'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: Black
Accept pipeline input: False
Accept wildcard characters: False
```

### -LineStyle
The style of the connecting lines (e.g., solid, dashed, dotted, bold).
Default is 'solid'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Solid
Accept pipeline input: False
Accept wildcard characters: False
```

### -LineWidth
The width (penwidth) of the lines.
Range: 1-10.
Default is 1.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: System.Management.Automation.ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TShapeLeft
The name of the starting node on the horizontal line (left side).
Default is 'TShapeLeft'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: TShapeLeft
Accept pipeline input: False
Accept wildcard characters: False
```

### -TShapeLeftLineLength
The minimum length (Graphviz minlen) of the left horizontal segment.
Range: 1-10.
Default is 1.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -TShapeMiddleDown
The name of the node at the bottom of the vertical line.
Default is 'TShapeMiddleDown'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: TShapeMiddleDown
Accept pipeline input: False
Accept wildcard characters: False
```

### -TShapeMiddleDownLineLength
The minimum length (Graphviz minlen) of the vertical segment.
Range: 1-10.
Default is 1.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -TShapeMiddleUp
The name of the node at the intersection of the T (top of the vertical line).
Default is 'TShapeMiddleUp'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: TShapeMiddleUp
Accept pipeline input: False
Accept wildcard characters: False
```

### -TShapeRight
The name of the ending node on the horizontal line (right side).
Default is 'TShapeRight'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: TShapeRight
Accept pipeline input: False
Accept wildcard characters: False
```

### -TShapeRightLineLength
The minimum length (Graphviz minlen) of the right horizontal segment.
Range: 1-10.
Default is 1.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Author: Jonathan Colon
Version: 0.2.31
GitHub: https://github.com/rebelinux/Diagrammer.Core

## RELATED LINKS

[https://github.com/rebelinux/Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)

