---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaNodeImage
---

# Add-DiaNodeImage

## SYNOPSIS

Generates an HTML table for visualizing an icon with customizable properties, such as border, style, and image size.

## SYNTAX

### __AllParameterSets

```
Add-DiaNodeImage [-Name] <string> [[-IconDebug] <bool>] [[-IconPath] <FileInfo>]
 [[-ImageSizePercent] <int>] [-ImagesObj] <hashtable> [-IconType] <string> [[-TableBorder] <int>]
 [[-TableBorderColor] <string>] [[-TableBorderStyle] <string>] [[-GraphvizAttributes] <hashtable>]
 [-NodeObject] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

- None

## DESCRIPTION

The Add-DiaNodeImage function creates an HTML table to display an icon image, typically used for diagramming nodes.
It supports customization of the icon's appearance, including border width, color, style, and image size percentage.
The function also allows for debug mode, which highlights the table for easier troubleshooting, and supports specifying the icon image via a hashtable object.

## EXAMPLES

### EXAMPLE 1

```powershell
# Generates an HTML table with a "ServerWindows" icon, 50% size, red solid border.

$RootPath = $PSScriptRoot
[System.IO.FileInfo]$IconPath = Join-Path $RootPath 'icons'

$Images = @{
    Internet = "Cloud.png"
}
Add-DiaNodeImage -Name "MyNode" -ImagesObj $Images -IconType "Internet" -ImageSizePercent 50 -TableBorder 1 -TableBorderColor "#FF0000" -TableBorderStyle "Solid" -IconPath $IconPath
```

!!! example
    === "Example 1"

        ```graphviz dot AddDiaNodeImage.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE STYLE='Solid' border='1' color='#FF0000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='Solid' ALIGN='Center' fixedsize='true' width='153.6' height='153.6' colspan='1'><img src='Docs/Icons/Cloud.png'/></TD></TR></TABLE>>];
            }
        ```
    === "Example 1 - DraftMode"

        ```graphviz dot AddDiaNodeImage_draftmode.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='SOLID' ALIGN='Center' colspan='1'>MyNode Image</TD></TR></TABLE>>];
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
  Position: 9
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
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IconPath

Optionally specifies the full path to the icon image file.
If not provided, the default image path is used.

```yaml
Type: System.IO.FileInfo
DefaultValue: ''
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

### -IconType

Specifies the type of icon to use from the ImagesObj hashtable.
This parameter is required and validates that ImagesObj is provided.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ImageSizePercent

Sets the size of the icon image as a percentage of its original size.
Accepts values from 10 to 100.
Default is 100%.

```yaml
Type: System.Int32
DefaultValue: 100
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

### -ImagesObj

A required hashtable object containing available images.
Used to retrieve the icon image for the node.

```yaml
Type: System.Collections.Hashtable
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: true
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

### -NodeObject

Allow to set the text align

```yaml
Type: System.Management.Automation.SwitchParameter
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TableBorder

Sets the width of the HTML table border in pixels.
Default is 0 (no border).

```yaml
Type: System.Int32
DefaultValue: 0
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

### -TableBorderColor

Specifies the color of the table border using a hex color code.
Default is "#000000" (black).

```yaml
Type: System.String
DefaultValue: '#000000'
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

### -TableBorderStyle

Defines the style of the table border.
Accepted values are: ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED.

```yaml
Type: System.String
DefaultValue: ''
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

HTML string representing the node with the specified icon and properties.

## NOTES

```
Author: Jonathan Colon
Version: 0.2.30
Twitter: @jcolonfzenpr
Github: rebelinux
```


## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)
