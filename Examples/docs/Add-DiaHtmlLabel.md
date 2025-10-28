---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Add-DiaHtmlLabel

## SYNOPSIS
Converts a string to an HTML table for the report main logo and title.

## SYNTAX

```
Add-DiaHtmlLabel [-Label] <String> [[-ImagesObj] <Hashtable>] [[-IconType] <String>] [[-IconPath] <FileInfo>]
 [[-IconHeight] <Int32>] [[-IconWidth] <Int32>] [[-IconDebug] <Boolean>] [[-Fontsize] <Int32>]
 [[-FontColor] <String>] [[-FontName] <String>] [-FontBold] [-FontItalic] [-FontUnderline] [-FontOverline]
 [-FontSubscript] [-FontSuperscript] [-FontStrikeThrough] [[-CellPadding] <Int32>] [[-CellSpacing] <Int32>]
 [[-SubgraphCellPadding] <Int32>] [[-SubgraphCellSpacing] <Int32>] [[-ImageSizePercent] <Int32>]
 [-SubgraphLabel] [[-TableBorder] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function takes a string and converts it into an HTML table format used for the report's main logo and title.
It supports customization of the logo, font, and debug options.

## EXAMPLES

### EXAMPLE 1
```
```powershell
    $script:Images = @{
        "Main_Logo" = "Diagrammer.png"
        "Server" = "Server.png"
    }
```

$CustomLogo = "Logo Path"
    $IconDebug = $false
    $RootPath = $PSScriptRoot
    \[System.IO.FileInfo\]$IconPath = Join-Path $RootPath 'Icons'

    # This will generate an HTML table with the specified label and logo.
    Add-DiaHTMLLabel -Label "Active Directory Forest Diagram" -IconType $CustomLogo -IconDebug $IconDebug -ImagesObj $Images
\`\`\`

!!!
example
    === "Example 1"

        \`\`\`graphviz dot ADDiaHTMLLabel.png
            digraph g {
                node \[shape=plain\];
                a \[label=\<\<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'\>\<TR\>\<TD ALIGN='center' colspan='1'\>\<img src='Docs/Icons/Diagrammer.png'/\>\</TD\>\</TR\>\<TR\>\<TD ALIGN='center'\>\<FONT FACE='Segoe Ui' Color='#565656' POINT-SIZE='14'\>Active Directory Forest Diagram\</FONT\>\</TD\>\</TR\>\</TABLE\>\>\];
            }
        \`\`\`
    === "Example 1 - DraftMode"

        \`\`\`graphviz dot ADDiaHTMLLabel_draftmode.png
            digraph g {
                node \[shape=plain\];
                a \[label=\<\<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='20'\>\<TR\>\<TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'\>Main Logo\</TD\>\</TR\>\<TR\>\<TD bgcolor='#FFCCCC' ALIGN='center' \>\<FONT FACE='Segoe Ui' Color='#565656' POINT-SIZE='14'\>Active Directory Forest Diagram\</FONT\>\</TD\>\</TR\>\<TR\>\<TD ALIGN='center'\>\<FONT color='red'\>DraftMode ON\</FONT\>\</TD\>\</TR\>\</TABLE\>\>\];
            }
        \`\`\`

## PARAMETERS

### -CellPadding
Specifies the padding inside the HTML table cells.
Default is 10.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 10
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellSpacing
Specifies the spacing between HTML table cells.
Default is 20.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 20
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontBold
Switch to render the label text in bold.

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
Specifies the font color for the cell text.
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
Switch to render the label text in italic.

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
Specifies the font family used for the label text.
Default is "Segoe Ui".

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
Switch to overline the label text.

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

### -Fontsize
Specifies the font size used for the label text.
Default is 14.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 14
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontStrikeThrough
Switch to render the label text with a strikethrough.

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
Switch to render the label text as subscript.

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
Switch to render the label text as superscript.

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
Switch to underline the label text.

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
Enables debug (draft) mode for icon rendering.
When set, a debug table row is included indicating DraftMode.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: DraftMode

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconHeight
Optional height for the icon in pixels.
When provided with IconWidth, a fixed-size image cell is used.

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

### -IconPath
Optional path (directory) containing icon image files.
Required when ImageSizePercent is less than 100.

```yaml
Type: System.IO.FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconType
The key or name of the icon to use.
If set to 'NoIcon' no icon is displayed.
Resolved from ImagesObj when available.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconWidth
Optional width for the icon in pixels.
When provided with IconHeight, a fixed-size image cell is used.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImageSizePercent
Percentage to scale the icon (1-100).
Default is 100.
When less than 100, IconPath is required and Get-DiaImagePercent is used.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImagesObj
Hashtable mapping icon keys to image file names or paths.
Default is an empty hashtable.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -Label
The text label used as the diagram title.
This parameter is mandatory.

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

### -SubgraphCellPadding
Padding inside HTML table cells when rendering subgraph labels.
Default is 5.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphCellSpacing
Spacing between HTML table cells when rendering subgraph labels.
Default is 5.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphLabel
Switch to produce a table formatted for a Graphviz subgraph label (icon and text side-by-side).

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

### -TableBorder
Border width for the generated HTML table.
Default is 0.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: 0
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
GitHub:         rebelinux

## RELATED LINKS
