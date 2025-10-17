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

# Add-DiaHTMLNodeTable

## SYNOPSIS

Converts an array to an HTML table for Graphviz node labels, including icons.

## SYNTAX

### AdditionalInfo

```
Add-DiaHTMLNodeTable -inputObject <string[]> -iconType <string[]> [-ImagesObj <hashtable>]
 [-Align <string>] [-TableBorder <int>] [-CellBorder <int>] [-CellPadding <int>]
 [-CellSpacing <int>] [-fontSize <int>] [-fontName <string>] [-fontColor <string>]
 [-columnSize <int>] [-Port <string>] [-MultiIcon] [-IconDebug <bool>] [-AditionalInfo <Object>]
 [-Subgraph] [-SubgraphIconType <string>] [-SubgraphLabel <string>] [-SubgraphLabelFontsize <int>]
 [-SubgraphLabelPos <string>] [-SubgraphTableStyle <string>] [-TableBorderColor <string>]
 [-SubgraphIconWidth <string>] [-SubgraphIconHeight <string>] [-TableBackgroundColor <string>]
 [-CellBackgroundColor <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

- None

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
DefaultValue: ''
SupportsWildcards: false
Aliases:
- RowsOrdered
- Rows
- AditionalInfoOrdered
ParameterSets:
- Name: AdditionalInfo
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Align

Align content inside table cell.
Default is 'Center'.

```yaml
Type: System.String
DefaultValue: Center
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

### -CellBackgroundColor

Allow to set a cell background color (Hex format EX: #FFFFFF).

```yaml
Type: System.String
DefaultValue: ''
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

### -CellBorder

The width of the table cell border.
Default is 0.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -CellPadding

The padding inside the table cell.
Default is 5.

```yaml
Type: System.Int32
DefaultValue: 5
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

### -CellSpacing

The spacing between table cells.
Default is 5.

```yaml
Type: System.Int32
DefaultValue: 5
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

### -columnSize

The number of columns to split the object inside the HTML table.
Default is 1.

```yaml
Type: System.Int32
DefaultValue: 1
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

### -fontColor

The text font color used inside the cell.
Default is #565656.

```yaml
Type: System.String
DefaultValue: '#565656'
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

### -fontName

The cell text font name.
Default is "Segoe Ui".

```yaml
Type: System.String
DefaultValue: Segoe Ui
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

### -fontSize

The cell text font size.
Default is 14.

```yaml
Type: System.Int32
DefaultValue: 14
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

### -IconDebug

Enable the icon debug mode.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases:
- DraftMode
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

### -iconType

Node Icon type.
This parameter is mandatory if ImagesObj is specified.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ImagesObj

Hashtable with the IconName to IconPath translation.

```yaml
Type: System.Collections.Hashtable
DefaultValue: ''
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

### -inputObject

The array of objects to process.

```yaml
Type: System.String[]
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: Named
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -MultiIcon

Allow to draw an icon for each table element.
If not set, the table shares a single icon.

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

### -Port

Used inside Graphviz to modify the head or tail of an edge, so that the end attaches directly to the object.
Default is "EdgeDot".

```yaml
Type: System.String
DefaultValue: EdgeDot
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

### -Subgraph

Create the table that can be used as a Subgraph replacement with the hashtable inside it.

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

### -SubgraphIconHeight

Allow to set a subgraph icon height.

```yaml
Type: System.String
DefaultValue: ''
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

### -SubgraphIconType

Allow to set the subgraph table icon.
This parameter is mandatory if ImagesObj is specified.

```yaml
Type: System.String
DefaultValue: ''
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

### -SubgraphIconWidth

Allow to set a subgraph icon width.

```yaml
Type: System.String
DefaultValue: ''
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

### -SubgraphLabel

Allow to set the subgraph table label.

```yaml
Type: System.String
DefaultValue: ''
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

### -SubgraphLabelFontsize

Allow to set the subgraph table label font size.
Default is 14.

```yaml
Type: System.Int32
DefaultValue: 14
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

### -SubgraphLabelPos

Allow to set the subgraph label position.
Valid values are 'top' and 'down'.
Default is 'down'.

```yaml
Type: System.String
DefaultValue: down
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

### -SubgraphTableStyle

Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED).

```yaml
Type: System.String
DefaultValue: ''
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

### -TableBackgroundColor

Allow to set a table background color (Hex format EX: #FFFFFF).

```yaml
Type: System.String
DefaultValue: ''
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

### -TableBorder

The width of the table border line.
Default is 0.

```yaml
Type: System.Int32
DefaultValue: 0
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

### -TableBorderColor

Allow to set a table border color.
Default is #000000.

```yaml
Type: System.String
DefaultValue: '#000000'
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

A string representing the HTML table.

## NOTES

```
Version:        0.2.29
Author:         Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux
```

## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)

