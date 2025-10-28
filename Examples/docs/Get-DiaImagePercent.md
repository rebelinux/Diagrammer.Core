---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version:
schema: 2.0.0
---

# Get-DiaImagePercent

## SYNOPSIS
Used by As Built Report to get base64 image percentage calculated from image width.

## SYNTAX

```
Get-DiaImagePercent [[-GraphObj] <String>] [[-ImageInput] <String>] [-Percent <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This allow the diagram image to fit the report page margins

## EXAMPLES

### EXAMPLE 1
```

```

## PARAMETERS

### -GraphObj
Please provide Graphviz object

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImageInput
Please provide image file path

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Percent
Set the image size in percent (100% is default)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Collections.Hashtable
## NOTES
Version:        0.2.30
Author:         Jonathan Colon

## RELATED LINKS
