---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaHtmlSignatureTable
---

# Add-DiaHtmlSignatureTable

## SYNOPSIS

Converts a string array to an HTML table for use in a Signature table.

## SYNTAX

### __AllParameterSets

```
Add-DiaHtmlSignatureTable [-Rows] <string[]> [[-Align] <string>] [[-TableBorder] <int>]
 [[-CellBorder] <int>] [[-CellSpacing] <int>] [[-CellPadding] <int>] [[-fontSize] <int>]
 [[-fontName] <string>] [[-fontColor] <string>] [-ImagesObj] <hashtable> [[-IconDebug] <bool>]
 [[-TableStyle] <string>] [[-Label] <string>] [[-Logo] <string>] [[-TableBorderColor] <string>]
 [-NoFontBold] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

The Add-DiaHtmlSignatureTable function generates an HTML table representation from a string array, suitable for use as a Signature table, such as in GraphViz labels.
It supports customization of table appearance, cell formatting, font styles, and inclusion of a logo image from a provided hashtable.
The function also offers debug mode and various style options.

## EXAMPLES

### EXAMPLE 1

Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows "Author: Bugs Bunny", "Company: ACME Inc." -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -DraftMode:$DraftMode

## PARAMETERS

### -Align

Alignment of content inside table cells.
Default is 'Center'.

```yaml
Type: System.String
DefaultValue: Center
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

### -CellBorder

The table cell border thickness.
Default is 0.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -CellPadding

The table cell padding space.
Default is 5.

```yaml
Type: System.Int32
DefaultValue: 5
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

### -CellSpacing

The table cell spacing.
Default is 5.

```yaml
Type: System.Int32
DefaultValue: 5
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

### -fontColor

The text font color used inside the cell.
Default is "#565656".

```yaml
Type: System.String
DefaultValue: '#565656'
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

### -fontName

The text font name used inside the cell.
Default is "Segoe Ui Black".

```yaml
Type: System.String
DefaultValue: Segoe Ui Black
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

### -fontSize

The text font size used inside the cell.
Default is 14.

```yaml
Type: System.Int32
DefaultValue: 14
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

### -IconDebug

Enables table debug mode, highlighting table borders and logo cell.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
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

### -ImagesObj

Hashtable mapping IconName to IconPath.
Required for logo image support.

```yaml
Type: System.Collections.Hashtable
DefaultValue: '@{}'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 9
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Label

Sets the SubGraph label.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 12
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Logo

Icon name used to represent the node type, resolved from ImagesObj.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 13
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -NoFontBold

Disables bold formatting for additional node info text.

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

### -Rows

An array of strings/objects to place in the table rows.

```yaml
Type: System.String[]
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

### -TableBorder

The table border thickness.
Default is 0.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -TableBorderColor

Sets the subgraph table border color.
Default is "#000000".

```yaml
Type: System.String
DefaultValue: '#000000'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 14
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TableStyle

Sets the table style (e.g., "ROUNDED", "RADIAL", "SOLID", "INVISIBLE", "INVIS", "DOTTED", "DASHED").
Styles can be combined.

```yaml
Type: System.String
DefaultValue: rounded,dashed
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 11
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

### [System.String] - Returns the generated HTML table as a string.

{{ Fill in the Description }}

### System.String

{{ Fill in the Description }}

## NOTES

Version:        0.2.30
Author:         Jonathan Colon
Twitter:        @jcolonfzenpr
Github:         rebelinux


## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)

