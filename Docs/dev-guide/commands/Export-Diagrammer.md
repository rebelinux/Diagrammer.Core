---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: https://github.com/rebelinux/Diagrammer.Core
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Export-Diagrammer
---

# Export-Diagrammer

## SYNOPSIS

Exports a diagram to a specified format.

## SYNTAX

### __AllParameterSets

```
Export-Diagrammer [-GraphObj] <Object> [[-ErrorDebug] <bool>] [-Format] <array>
 [[-Filename] <string>] [[-OutputFolderPath] <FileInfo>] [[-IconPath] <FileInfo>]
 [[-WaterMarkText] <string>] [[-WaterMarkColor] <string>] [[-WaterMarkFontOpacity] <int>]
 [[-Rotate] <int>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Export-Diagrammer function exports a diagram in PDF, PNG, SVG, or base64 formats using PSgraph.
It supports adding watermarks to the output image (except for SVG and PDF formats) and allows for
rotating the diagram output image.

## EXAMPLES

## PARAMETERS

### -ErrorDebug

Enables error debugging.
This parameter is optional.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases: []
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

### -Filename

The output filename of the generated Graphviz diagram.
If not specified, the default filename is "Output"
with the appropriate extension based on the format.

```yaml
Type: System.String
DefaultValue: ''
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

### -Format

The output format of the generated Graphviz diagram.
Supported formats are PDF, PNG, SVG, and base64.
This parameter is mandatory.

```yaml
Type: System.Array
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -GraphObj

The Graphviz dot object to be exported.
This parameter is mandatory.

```yaml
Type: System.Object
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

### -IconPath

The path to the icons directory, used for the SVG format.
This parameter is optional but must be a valid
path if provided.

```yaml
Type: System.IO.FileInfo
DefaultValue: ''
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

### -OutputFolderPath

The path to the folder where the diagram output file will be saved.
This parameter is optional but must
be a valid path if provided.

```yaml
Type: System.IO.FileInfo
DefaultValue: '[system.io.path]::GetTempPath()'
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

### -Rotate

The degree to rotate the diagram output image.
Valid rotation degrees are 0 and 90.
This parameter is optional.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -WaterMarkColor

The color of the watermark text.
The default color is 'Red'.
This parameter is optional.

```yaml
Type: System.String
DefaultValue: Red
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

### -WaterMarkFontOpacity

The font opacity of the watermark text.
The default opacity is 30.
This parameter is optional.

```yaml
Type: System.Int32
DefaultValue: 30
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

### -WaterMarkText

The text to be used as a watermark on the output image.
This parameter is optional and not supported for
SVG and PDF formats.

```yaml
Type: System.String
DefaultValue: ''
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

{{ Fill in the Description }}

## NOTES

Version:        0.2.30
Author:         Jonathan Colon
Twitter:        @jcolonfzenpr
GitHub:         rebelinux


## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)
