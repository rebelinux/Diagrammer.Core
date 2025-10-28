---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: ''
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: Add-DiaHTMLNodeTable
---

# Add-DiaHtmlNodeTable

## SYNOPSIS
Converts an array to an HTML table for Graphviz node labels, including icons.

## SYNTAX

```
Add-DiaHtmlNodeTable -inputObject <String[]> [-ImagesObj <Hashtable>] -iconType <String[]> [-Align <String>]
 [-TableBorder <Int32>] [-CellBorder <Int32>] [-CellPadding <Int32>] [-CellSpacing <Int32>] [-FontSize <Int32>]
 [-FontName <String>] [-FontColor <String>] [-FontBold] [-FontItalic] [-FontUnderline] [-FontOverline]
 [-FontSubscript] [-FontSuperscript] [-FontStrikeThrough] [-ColumnSize <Int32>] [-Port <String>] [-MultiIcon]
 [-IconDebug <Boolean>] [-AditionalInfo <Object>] [-Subgraph] [-SubgraphIconType <String>]
 [-SubgraphLabel <String>] [-SubgraphFontName <String>] [-SubgraphLabelFontSize <Int32>]
 [-SubgraphLabelFontColor <String>] [-SubgraphFontBold] [-SubgraphFontItalic] [-SubgraphFontUnderline]
 [-SubgraphFontOverline] [-SubgraphFontSubscript] [-SubgraphFontSuperscript] [-SubgraphFontStrikeThrough]
 [-SubgraphLabelPos <String>] [-SubgraphTableStyle <String>] [-TableBorderColor <String>]
 [-SubgraphIconWidth <String>] [-SubgraphIconHeight <String>] [-TableBackgroundColor <String>]
 [-CellBackgroundColor <String>] [-Name <String>] [-NodeObject] [-GraphvizAttributes <Hashtable>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

This function takes an array and converts it into an HTML table, which can be used as a label for Graphviz nodes.
The table can include icons and additional information for each element.

## EXAMPLES

### EXAMPLE 1

```powershell
# Array of String *6 Objects*
$DCsArray = @("Server-dc-01v","Server-dc-02v","Server-dc-03v","Server-dc-04v","Server-dc-05v","Server-dc-06v")

$Images = @{
    "Microsoft_Logo" = "Microsoft_Logo.png"
    "ForestRoot" = "Forrest_Root.png"
    "AD_LOGO_Footer" = "DMAD_Logo.png"
    "AD_DC" = "Server.png"
    "AD_Domain" = "ADDomain.png"
    "AD_Site" = "Site.png"
    "AD_Site_Subnet" = "SubNet.png"
    "AD_Site_Node" = "SiteNode.png"
}

Add-DiaHTMLNodeTable -ImagesObj $Images -inputObject $DCsArray -Columnsize 3 -Align 'Center' -IconType "AD_DC" -MultiIcon -IconDebug $True
```

!!! example
    === "Example 1"

        ```graphviz dot ADDDiaHTMLNodeTable.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE COLOR="#000000" PORT="EdgeDot" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Server.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Server.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Server.png"/></TD></TR><TR><TD PORT="Server-dc-01v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-01v</B></FONT></TD><TD PORT="Server-dc-02v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-02v</B></FONT></TD><TD PORT="Server-dc-03v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-03v</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Server.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Server.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Server.png"/></TD></TR><TR><TD PORT="Server-dc-04v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-04v</B></FONT></TD><TD PORT="Server-dc-05v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-05v</B></FONT></TD><TD PORT="Server-dc-06v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-06v</B></FONT></TD></TR></TABLE>>];
            }
        ```
    === "Example 1 - DraftMode"

        ```graphviz dot ADDDiaHTMLNodeTable_draftmode.png
            digraph g {
                node [shape=plain];
                a [label=<<TABLE PORT="EdgeDot" COLOR="red" border="1" cellborder="1" cellpadding="5" cellspacing="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>Icon</B></FONT></TD></TR><TR><TD PORT="Server-dc-01v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-01v</B></FONT></TD><TD PORT="Server-dc-02v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-02v</B></FONT></TD><TD PORT="Server-dc-03v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-03v</B></FONT></TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>Icon</B></FONT></TD></TR><TR><TD PORT="Server-dc-04v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-04v</B></FONT></TD><TD PORT="Server-dc-05v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-05v</B></FONT></TD><TD PORT="Server-dc-06v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-06v</B></FONT></TD></TR></TABLE>>];
            }
        ```

## PARAMETERS

### -AditionalInfo
Hashtable used to add more information to the table elements.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases: RowsOrdered, Rows, AditionalInfoOrdered

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Align
Align content inside table cell.
Default is 'Center'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Center
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellBackgroundColor
Allow to set a cell background color (Hex format EX: #FFFFFF).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellBorder
The width of the table cell border.
Default is 0.

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

### -CellPadding
The padding inside the table cell.
Default is 5.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -CellSpacing
The spacing between table cells.
Default is 5.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -ColumnSize
The number of columns to split the object inside the HTML table.
Default is 1.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
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
Default is #000000.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
The cell text font name.
Default is "Segoe Ui".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
The cell text font size.
Default is 14.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug
Enable the icon debug mode.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: DraftMode

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -iconType
Node Icon type.
This parameter is mandatory if ImagesObj is specified.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImagesObj
Hashtable with the IconName to IconPath translation.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inputObject
The array of objects to process.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MultiIcon
Allow to draw an icon for each table element.
If not set, the table shares a single icon.

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

### -Name
Specifies the name of the node.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
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

### -Port
Used inside Graphviz to modify the head or tail of an edge, so that the end attaches directly to the object.
Default is "EdgeDot".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: EdgeDot
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

### -Subgraph
Create the table that can be used as a Subgraph replacement with the hashtable inside it.

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

### -SubgraphFontBold
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

### -SubgraphFontItalic
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

### -SubgraphFontName
The cell text font name

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Segoe Ui
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphFontOverline
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

### -SubgraphFontStrikeThrough
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

### -SubgraphFontSubscript
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

### -SubgraphFontSuperscript
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

### -SubgraphFontUnderline
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

### -SubgraphIconHeight
Allow to set a subgraph icon height.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphIconType
Allow to set the subgraph table icon.
This parameter is mandatory if ImagesObj is specified.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphIconWidth
Allow to set a subgraph icon width.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphLabel
Allow to set the subgraph table label.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphLabelFontColor
Allow to set the subgraph table label font size

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: #000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphLabelFontSize
Allow to set the subgraph table label font size.
Default is 14.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 14
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphLabelPos
Allow to set the subgraph label position.
Valid values are 'top' and 'down'.
Default is 'down'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Top
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubgraphTableStyle
Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBackgroundColor
Allow to set a table background color (Hex format EX: #FFFFFF).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TableBorder
The width of the table border line.
Default is 0.

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

### -TableBorderColor
Allow to set a table border color.
Default is #000000.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

### System.String
## NOTES

```
Version:        0.2.29
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux
```

## RELATED LINKS
