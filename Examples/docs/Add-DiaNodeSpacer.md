---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Add-DiaNodeSpacer

## SYNOPSIS
Function to create a node share (rectangle) used as Spacer

## SYNTAX

```
Add-DiaNodeSpacer [-Name] <String> [[-IconDebug] <Boolean>] [[-ShapeWidth] <Single>] [[-ShapeHeight] <Single>]
 [[-ShapeOrientation] <Int32>] [[-Direction] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Function to create a node share (rectangle) used as Spacer

## EXAMPLES

### EXAMPLE 1
```
Add-DiaNodeSpacer -IconDebug:$true
            _________________
            |               |
            |      Icon     |
            _________________
```

## PARAMETERS

### -Direction
Direction of the icon.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Vertical
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug
Enables debug mode for icons, highlighting the table in red.

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
Name of the Node.

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

### -ShapeHeight
Shape Height.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 1
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
Position: 5
Default value: 0
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
Position: 3
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Version:        0.2.30
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux

## RELATED LINKS
