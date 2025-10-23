---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Export-Diagrammer

## SYNOPSIS
Exports a diagram to a specified format.

## SYNTAX

```
Export-Diagrammer [-GraphObj] <Object> [[-ErrorDebug] <Boolean>] [-Format] <Array> [[-Filename] <String>]
 [[-OutputFolderPath] <FileInfo>] [[-IconPath] <FileInfo>] [[-WaterMarkText] <String>]
 [[-WaterMarkColor] <String>] [[-WaterMarkFontOpacity] <Int32>] [[-Rotate] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Export-Diagrammer function exports a diagram in PDF, PNG, SVG, or base64 formats using PSgraph.
It supports adding watermarks to the output image (except for SVG and PDF formats) and allows for
rotating the diagram output image.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ErrorDebug
Enables error debugging.
This parameter is optional.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filename
The output filename of the generated Graphviz diagram.
If not specified, the default filename is "Output"
with the appropriate extension based on the format.

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

### -Format
The output format of the generated Graphviz diagram.
Supported formats are PDF, PNG, SVG, and base64.
This parameter is mandatory.

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GraphObj
The Graphviz dot object to be exported.
This parameter is mandatory.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconPath
The path to the icons directory, used for the SVG format.
This parameter is optional but must be a valid
path if provided.

```yaml
Type: System.IO.FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFolderPath
The path to the folder where the diagram output file will be saved.
This parameter is optional but must
be a valid path if provided.

```yaml
Type: System.IO.FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: [system.io.path]::GetTempPath()
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

### -Rotate
The degree to rotate the diagram output image.
Valid rotation degrees are 0 and 90.
This parameter is optional.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WaterMarkColor
The color of the watermark text.
The default color is 'Red'.
This parameter is optional.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: Red
Accept pipeline input: False
Accept wildcard characters: False
```

### -WaterMarkFontOpacity
The font opacity of the watermark text.
The default opacity is 30.
This parameter is optional.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -WaterMarkText
The text to be used as a watermark on the output image.
This parameter is optional and not supported for
SVG and PDF formats.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Version:        0.2.31
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
GitHub:         rebelinux

## RELATED LINKS

[https://github.com/rebelinux/Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)

