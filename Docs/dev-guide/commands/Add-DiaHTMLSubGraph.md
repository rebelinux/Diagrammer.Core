---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaHTMLSubGraph
---

# Add-DiaHTMLSubGraph

## SYNOPSIS

Function to convert a array to a HTML Table to mimic Graphviz Cluster (Subgraph).

## SYNTAX

### __AllParameterSets

```
Add-DiaHtmlSubGraph [-TableArray] <String[]> [[-ImagesObj] <Hashtable>] [[-ImageSizePercent] <Int32>]
 [[-Align] <String>] [[-TableBorder] <Int32>] [[-CellBorder] <Int32>] [[-CellPadding] <Int32>]
 [[-CellSpacing] <Int32>] [[-FontSize] <Int32>] [[-FontName] <String>] [[-FontColor] <String>] [-FontBold]
 [-FontItalic] [-FontUnderline] [-FontOverline] [-FontSubscript] [-FontSuperscript] [-FontStrikeThrough]
 [[-ColumnSize] <Int32>] [[-IconDebug] <Boolean>] [-NoFontBold] [[-IconType] <String>] [[-Label] <String>]
 [[-LabelPos] <String>] [[-TableStyle] <String>] [[-TableBorderColor] <String>]
 [[-TableBackgroundColor] <String>] [[-IconWidth] <Int32>] [[-IconHeight] <Int32>] [[-Name] <String>]
 [-NodeObject] [[-GraphvizAttributes] <Hashtable>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

- None

## DESCRIPTION

Takes a array and converts it to a HTML table to mimic Graphviz Subgraph

## EXAMPLES

### EXAMPLE 1

```powershell
$SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
Add-DiaHTMLSubGraph -TableArray $SiteSubnets -Align "Center" -ColumnSize 2
```

!!! example
    === "Example 1"

        ```graphviz dot AddDiaHTMLSubGraph.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE BGColor="#ffffff" COLOR="#000000" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="2"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>SubGraph Emulation</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>>];
            }
        ```
    === "Example 1 - DraftMode"

        ```graphviz dot AddDiaHTMLSubGraph_draftmode.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE BGColor="#ffffff" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="2"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>SubGraph Emulation</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>>];
            }
        ```

### EXAMPLE 2

```powershell
$SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
Add-DiaHTMLSubGraph -TableArray $SiteSubnets -Align "Center"
```

!!! example
    === "Example 2"

        ```graphviz dot AddDiaHTMLSubGraph2.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE BGColor="#ffffff" COLOR="#000000" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>SubGraph Emulation</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>>];
            }
        ```
    === "Example 2 - DraftMode"

        ```graphviz dot AddDiaHTMLSubGraph2_draftmode.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE BGColor="#ffffff" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>SubGraph Emulation</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>>];
            }
        ```

## PARAMETERS

### -Align

Align content inside table cell

```yaml
Type: System.String
DefaultValue: Center
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

### -CellBorder

The table cell border (Default: 0)

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

### -CellPadding

The table cell padding space (Default: 5)

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

Allow to set the spacing of the html cell border

```yaml
Type: System.Int32
DefaultValue: 5
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

### -columnSize

This number is used to specified how to split the object inside the HTML table.

```yaml
Type: System.Int32
DefaultValue: 1
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

### -fontColor

The text font color used inside the cell (Default #565656)

```yaml
Type: System.String
DefaultValue: '#565656'
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

### -fontName

The text font name used inside the cell

```yaml
Type: System.String
DefaultValue: Segoe Ui
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

### -fontSize

The text font size used inside the cell

```yaml
Type: System.Int32
DefaultValue: 14
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

### -FontColor
The text font color used inside the cell (Default: #000000)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: #000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontItalic
Allow to set the font italic

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
The text font name used inside the cell (Default: Segoe Ui)

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

### -FontOverline
Allow to set the font overline

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

### -FontSize
The text font size used inside the cell (Default: 14)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 14
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontStrikeThrough
Allow to set the font strikethrough

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

### -FontSubscript
Allow to set the font subscript

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

### -FontSuperscript
Allow to set the font superscript

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

### -FontUnderline
Allow to set the font underline

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
Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug

Set the table debug mode

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
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

### -IconHeight

Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
styles can be combines ("rounded,dashed")

```yaml
Type: System.Int32
DefaultValue: 40
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 19
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IconType

Node Icon type

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

### -IconWidth

Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
styles can be combines ("rounded,dashed")

```yaml
Type: System.Int32
DefaultValue: 40
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 18
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ImagesObj

Hashtable with the IconName > IconPath translation

```yaml
Type: System.Collections.Hashtable
DefaultValue: ''
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

### -Label

Allow to set SubGraph Label

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

### -LabelPos

Allow to set SubGraph Label position.
Allowed values are top or down (Default: down)

```yaml
Type: System.String
DefaultValue: down
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

### -NoFontBold

Disable the node aditionalinfo bold in text

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

### -TableArray

An array of strings/objects to place in this record

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

### -TableBackgroundColor

Allow to set a table border color

```yaml
Type: System.String
DefaultValue: '#ffffff'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 17
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TableBorder

The table border (Default: 0)

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

### -TableBorderColor

Set the subgraph table border color

```yaml
Type: System.String
DefaultValue: '#000000'
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 16
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -TableStyle

Set the table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)
styles can be combines ("rounded,dashed")

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 15
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

The HTML table string to be used inside a node label.

## NOTES

```
Version:        0.2.30
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux
```


## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)

