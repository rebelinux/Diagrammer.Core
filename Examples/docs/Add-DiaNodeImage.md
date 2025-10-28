---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Add-DiaNodeImage

## SYNOPSIS
Generates an HTML table for visualizing an icon with customizable properties, such as border, style, and image size.

## SYNTAX

```
Add-DiaNodeImage [-Name] <String> [[-IconDebug] <Boolean>] [[-IconPath] <FileInfo>]
 [[-ImageSizePercent] <Int32>] [-ImagesObj] <Hashtable> [-IconType] <String> [[-TableBorder] <Int32>]
 [[-TableBorderColor] <String>] [[-TableBorderStyle] <String>] [-NodeObject]
 [[-GraphvizAttributes] <Hashtable>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Add-DiaNodeImage function creates an HTML table to display an icon image, typically used for diagramming nodes.
It supports customization of the icon's appearance, including border width, color, style, and image size percentage.
The function also allows for debug mode, which highlights the table for easier troubleshooting, and supports specifying the icon image via a hashtable object.

## EXAMPLES

### EXAMPLE 1
```
Add-DiaNodeImage -Name "MyNode" -ImagesObj $Images -IconType "ServerWindows" -ImageSizePercent 50 -TableBorder 1 -TableBorderColor "#FF0000" -TableBorderStyle "Solid"
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
Position: 10
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
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconPath
Optionally specifies the full path to the icon image file.
If not provided, the default image path is used.

```yaml
Type: System.IO.FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconType
Specifies the type of icon to use from the ImagesObj hashtable.
This parameter is required and validates that ImagesObj is provided.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImageSizePercent
Sets the size of the icon image as a percentage of its original size.
Accepts values from 10 to 100.
Default is 100%.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImagesObj
A required hashtable object containing available images.
Used to retrieve the icon image for the node.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
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

### -NodeObject
Allow to set the text align

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### -TableBorder
Sets the width of the HTML table border in pixels.
Default is 0 (no border).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBorderColor
Specifies the color of the table border using a hex color code.
Default is "#000000" (black).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: #000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBorderStyle
Defines the style of the table border.
Accepted values are: ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
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
