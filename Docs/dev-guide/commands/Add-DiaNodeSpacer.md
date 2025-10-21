---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaNodeSpacer
---

# Add-DiaNodeSpacer

## SYNOPSIS

Function to create a node share (rectangle) used as Spacer

## SYNTAX

### __AllParameterSets

```
Add-DiaNodeSpacer [-Name] <string> [[-IconDebug] <bool>] [[-ShapeWidth] <float>]
 [[-ShapeHeight] <float>] [[-ShapeOrientation] <int>] [[-Direction] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

- None

## DESCRIPTION

Function to create a node shape (rectangle) used as Spacer

## EXAMPLES

### EXAMPLE 1

```powershell
## Add a Spacer node with a specific name
Add-DiaNodeSpacer -Name 'SpacerLeft'
```

!!! example
    === "Example 1 - DraftMode"

        ```graphviz dot AddDiaNodeSpacer_draftmode.png
            digraph g {
                node [shape=plain];
                "SpacerLeft" [orientation="0";height="1";penwidth="1";shape="rectangle";labelloc="c";style="filled";color="red";label="SpacerLeft";fillcolor="#FFCCCC";width="2";]
            }
        ```

## PARAMETERS

### -Direction

Direction of the icon.

```yaml
Type: System.String
DefaultValue: Vertical
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

### -IconDebug

Enables debug mode for icons, highlighting the table in red.

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

### -Name

Name of the Node.

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

### -ShapeHeight

Shape Height.

```yaml
Type: System.Single
DefaultValue: 1
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

### -ShapeOrientation

Shape Orientation (0-360 degrees).

```yaml
Type: System.Int32
DefaultValue: 0
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

### -ShapeWidth

Shape Width.

```yaml
Type: System.Single
DefaultValue: 2
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
Version:        0.2.30
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux
```


## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)
