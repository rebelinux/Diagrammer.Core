---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Add-DiaNodeText

## SYNOPSIS
Generates an HTML representation of a text box for a diagram node.

## SYNTAX

```
Add-DiaNodeText [-Name] <String> [[-IconDebug] <Boolean>] [[-TableBorderColor] <String>]
 [[-TableBorderStyle] <String>] [[-TableBorder] <Int32>] [-Text] <String> [[-TextAlign] <String>]
 [[-FontColor] <String>] [[-FontSize] <Int32>] [-FontBold] [-FontItalic] [-FontUnderline]
 [[-FontName] <String>] [[-TableBackgroundColor] <String>] [[-GraphvizAttributes] <Hashtable>] [-NodeObject]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Add-DiaNodeText function creates an HTML representation of a text box for a diagram node.
It supports customization of the text box's appearance, including border width, color, style, and font properties.
The function also allows for debug mode, which highlights the text box for easier troubleshooting.

## EXAMPLES

### EXAMPLE 1
```
Add-DiaNodeText -Name "Server1" -TableBorder 2 -TableBorderColor "#FF0000" -TableBorderStyle "SOLID" -Text "This is a test text box." -FontColor "#0000FF" -FontSize 14 -FontBold $true -TableBackgroundColor "#FFFF00" -NodeObject
```

This command creates a text box node named "Server1" with a solid red border of 2 pixels, blue bold text of size 14, and a yellow background.
            _________________
            |               |
            |   Text Box    |
            |               |
            |_______________|

## PARAMETERS

### -FontBold
When set to $true, the text within the text box is rendered in bold.
Default is $false.

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

### -FontColor
Sets the color of the text within the text box using a hex color code.
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

### -FontItalic
When set to $true, the text within the text box is rendered in italic.
Default is $false.

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

### -FontName
The font face to use.
Default is 'Segoe Ui'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: Segoe Ui
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontSize
Specifies the font size of the text within the text box.
Default is 12.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 12
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontUnderline
When set to $true, the text within the text box is underlined.
Default is $false.

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

### -GraphvizAttributes
A hashtable of additional Graphviz attributes to apply to the node.
This allows for further customization of the node's appearance.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug
Enables debug mode for icons.
When set to $true, the table border is highlighted in red to assist with visual debugging.
Default is $false.

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
If specified, the function will return the node object instead of rendering it directly.

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

### -TableBackgroundColor
Sets the background color of the text box using a hex color code.
Default is "transparent".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: #FFFFFF
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
Position: 5
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
Position: 3
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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
The text content to be displayed within the text box.
This is a required parameter.
The text can include line breaks by using \`\n\` which will be converted to \`\<BR/\>\`.
Example: "Line1\nLine2\nLine3" will render as:
Line1
Line2
Line3

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

### -TextAlign
Specifies the alignment of the text within the text box.
Accepted values are: Left, Right, Center, and Justify.
Default is "Center".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Center
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
Version: 0.2.32
Twitter: @jcolonfzenpr
Github: rebelinux

## RELATED LINKS
