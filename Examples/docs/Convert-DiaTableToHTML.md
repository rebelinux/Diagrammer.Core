---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/Diagrammer.Core
schema: 2.0.0
---

# Convert-DiaTableToHTML

## SYNOPSIS
Creates a html table object

## SYNTAX

### Script (Default)
```
Convert-DiaTableToHTML [-Name] <String> [[-ScriptBlock] <ScriptBlock>] [[-RowScript] <ScriptBlock>]
 [-Label <String>] [-FontName <String>] [-FontSize <Int32>] [-Style <String>] [-Fillcolor <String>]
 [-HeaderColor <String>] [-HeaderFontColor <String>] [-BorderColor <String>] [-HTMLOutput <Boolean>]
 [-IconDebug <Boolean>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Strings
```
Convert-DiaTableToHTML [-Name] <String> [[-Row] <Object[]>] [[-RowScript] <ScriptBlock>] [-Label <String>]
 [-FontName <String>] [-FontSize <Int32>] [-Style <String>] [-Fillcolor <String>] [-HeaderColor <String>]
 [-HeaderFontColor <String>] [-BorderColor <String>] [-HTMLOutput <Boolean>] [-IconDebug <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a table object that contains rows of data.

## EXAMPLES

### EXAMPLE 1
```

```

## PARAMETERS

### -BorderColor
The table border color.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: White
Accept pipeline input: False
Accept wildcard characters: False
```

### -Fillcolor
The table fill color.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: White
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontName
The table shape based on: https://graphviz.org/doc/info/shapes.html.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Segoe UI
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontSize
The table font size.

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

### -HeaderColor
The table header cell color.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Black
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeaderFontColor
The table header font color.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: White
Accept pipeline input: False
Accept wildcard characters: False
```

### -HTMLOutput
Set to output HTML.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconDebug
Set the table debug mode

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Label
The label to use for the headder of the table.

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

### -Name
The table name for this record

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ID, Node

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

### -Row
An array of strings/objects to place in this record

```yaml
Type: System.Object[]
Parameter Sets: Strings
Aliases: Rows

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -RowScript
A script to run on each row

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock
A sub expression that contains Row commands

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: Script
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Style
The table drawing style based on: https://graphviz.org/docs/attr-types/style/.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Filled
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES
Early release version of this command.
A lot of stuff is hard coded that should be exposed as attributes

## RELATED LINKS
