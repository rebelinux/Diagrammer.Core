---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Add-DiaNodeShape

## SYNOPSIS
Generates an Node with a specific shape and customizable attributes for diagramming purposes.

## SYNTAX

```
Add-DiaNodeShape [-Name] <String> [-Shape] <String> [[-IconDebug] <Boolean>]
 [[-GraphvizAttributes] <Hashtable>] [[-ShapeFillColor] <String>] [[-ShapeLineColor] <String>]
 [[-ShapeFontColor] <String>] [[-ShapeFontSize] <Int32>] [[-ShapeFontName] <String>] [[-ShapeStyle] <String>]
 [[-ShapeWidth] <Single>] [[-ShapeHeight] <Single>] [[-ShapeBorderSize] <Int32>] [[-ShapeOrientation] <Int32>]
 [[-ShapeLabelPosition] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Add-DiaNodeShape function creates an Node with a specific shape and customizable attributes for diagramming purposes.
It supports customization of the node's appearance, including border width, color, style, and image size percentage.
The function also allows for debug mode, which highlights the node for easier troubleshooting, and supports specifying the icon image via a hashtable object.

## EXAMPLES

### EXAMPLE 1
```
Add-DiaNodeShape -Name "MyNode" -ImagesObj $Images -IconType "ServerWindows" -ImageSizePercent 50 -TableBorder 1 -TableBorderColor "#FF0000" -TableBorderStyle "Solid"
```

** Generates an HTML table with a "ServerWindows" icon, 50% size, red solid border.
**
            _________________
            |               |
            |     Image     |
            |               |
            |_______________|

## PARAMETERS

### -GraphvizAttributes
Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug
Enables debug mode for icons.
When set to $true, the table border is highlighted in red to assist with visual debugging.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: DraftMode

Required: False
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the name of the node to be illustrated.
This is a required parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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

### -Shape
Set the shape of the node.
(https://graphviz.org/doc/info/shapes.html)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeBorderSize
Shape Border Size (1-10).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeFillColor
Shape Fill Color.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: Transparent
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeFontColor
Shape Font Color.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Black
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeFontName
Shape Font Name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: Times-Roman
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeFontSize
Shape Font Size.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 14
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeHeight
Shape Height.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0.5
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeLabelPosition
Shape Label Position (top, bottom, center).
Default is center.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: Center
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeLineColor
Shape Line Color.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Black
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeOrientation
Shape Orientation (0-360 degrees).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeStyle
Shape Style (e.g., filled, dashed, wedged, dotted, solid, striped, diagonals, rounded, bold, invisible; can be combined with commas Ex: dashed,rounded).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: Filled
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShapeWidth
Shape Width.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0.75
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
Version: 0.2.30
Twitter: @jcolonfzenpr
Github: rebelinux

## RELATED LINKS
