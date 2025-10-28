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

```
Add-DiaHtmlSignatureTable [-Rows] <String[]> [[-Align] <String>] [[-TableBorder] <Int32>]
 [[-CellBorder] <Int32>] [[-CellSpacing] <Int32>] [[-CellPadding] <Int32>] [[-FontSize] <Int32>]
 [[-FontName] <String>] [[-FontColor] <String>] [-FontBold] [-FontItalic] [-FontUnderline] [-FontOverline]
 [-FontSubscript] [-FontSuperscript] [-FontStrikeThrough] [-ImagesObj] <Hashtable> [[-IconDebug] <Boolean>]
 [[-TableStyle] <String>] [-NoFontBold] [[-Label] <String>] [[-Logo] <String>] [[-TableBorderColor] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

The Add-DiaHtmlSignatureTable function generates an HTML table representation from a string array, suitable for use as a Signature table, such as in GraphViz labels.
It supports customization of table appearance, cell formatting, font styles, and inclusion of a logo image from a provided hashtable.
The function also offers debug mode and various style options.

## EXAMPLES

### EXAMPLE 1

```powershell
$Images = @{
    "Logo_Footer" = "Signature_Logo.png"
}

$DraftMode = $true

Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows "Author: Bugs Bunny", "Company: ACME Inc." -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -DraftMode:$DraftMode
```

!!! example
    === "Example 1"

        ```graphviz dot AddDiaHtmlSignatureTable.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE STYLE="rounded,dashed" border="2" cellborder="0" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="left" colspan="1" rowspan="4"><img src="Docs/Icons/Signature_Logo.png"/></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Author: Bugs Bunny</FONT></B></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Company: ACME Inc.</FONT></B></TD></TR></TABLE>>];
            }
        ```
    === "Example 1 - DraftMode"

        ```graphviz dot AddDiaHtmlSignatureTable_draftmode.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE STYLE="rounded,dashed" COLOR="red" border="2" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="left" colspan="1" rowspan="4">Logo</TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Author: Bugs Bunny</FONT></B></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Company: ACME Inc.</FONT></B></TD></TR></TABLE>>];
            }
        ```

## PARAMETERS

### -Align
Alignment of content inside table cells.
Default is 'Center'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Center
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellBorder
The table cell border thickness.
Default is 0.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellPadding
The table cell padding space.
Default is 5.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellSpacing
The table cell spacing.
Default is 5.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontBold
Allow to set the font bold

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
The text font color used inside the cell.
Default is "#000000".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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
The text font name used inside the cell.
Default is "Segoe Ui".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
The text font size used inside the cell.
Default is 14.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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

### -IconDebug
Enables table debug mode, highlighting table borders and logo cell.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: DraftMode

Required: False
Position: 11
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImagesObj
Hashtable mapping IconName to IconPath.
Required for logo image support.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 10
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -Label
Sets the SubGraph label.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Logo
Icon name used to represent the node type, resolved from ImagesObj.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoFontBold
Disables bold formatting for additional node info text.

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

### -Rows
An array of strings/objects to place in the table rows.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBorder
The table border thickness.
Default is 0.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBorderColor
Sets the subgraph table border color.
Default is "#000000".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: #000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableStyle
Sets the table style (e.g., "ROUNDED", "RADIAL", "SOLID", "INVISIBLE", "INVIS", "DOTTED", "DASHED").
Styles can be combined.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: Rounded,dashed
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### [System.String] - Returns the generated HTML table as a string.
## NOTES
```
Version:        0.2.30
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux
```

## RELATED LINKS
