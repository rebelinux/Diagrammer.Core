---
external help file: Diagrammer.Core-help.xml
Module Name: Diagrammer.Core
online version: https://github.com/rebelinux/
https://github.com/KevinMarquette/PSGraph
https://github.com/PrateekKumarSingh/AzViz
schema: 2.0.0
---

# New-Diagrammer

## SYNOPSIS
Diagram the configuration of IT infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.

## SYNTAX

```
New-Diagrammer [-InputObject] <Object> [[-Format] <Array>] [-Edgecolor <String>] [-EdgeArrowSize <String>]
 [-EdgeLineWidth <String>] [-Fontcolor <String>] [-Fontname <String>] [-MainDiagramLabelFontBold]
 [-MainDiagramLabelFontItalic] [-MainDiagramLabelFontUnderline] [-MainDiagramLabelFontOverline]
 [-MainDiagramLabelFontSubscript] [-MainDiagramLabelFontSuperscript] [-MainDiagramLabelFontStrikeThrough]
 [-NodeFontSize <String>] [-NodeFontcolor <String>] [[-IconPath] <FileInfo>] [[-ImagesObj] <Hashtable>]
 [-Direction <String>] [-OutputFolderPath <String>] [-SignatureLogo <String>] [-SignatureLogoName <String>]
 [-Logo <String>] [-LogoName <String>] [-Filename <String>] [-EdgeType <String>] [-NodeSeparation <String>]
 [-SectionSeparation <String>] [-DraftMode] [-EnableErrorDebug] [-DisableMainDiagramLogo]
 [-AuthorName <String>] [-CompanyName <String>] [-Signature] -MainDiagramLabel <String>
 [-MainDiagramLabelFontsize <Int32>] [-MainDiagramLabelFontname <String>] [-MainDiagramLabelFontColor <String>]
 [-MainGraphAttributes <Hashtable>] [-WaterMarkColor <String>] [-WaterMarkText <String>]
 [-WaterMarkFontOpacity <Int32>] [-MainGraphBGColor <String>] [-MainGraphSize <String>]
 [-MainGraphLogoSizePercent <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet generates diagrams of IT infrastructure configurations in various formats such as PDF, SVG, DOT, and PNG using PSGraph and Graphviz.
It provides extensive customization options for diagram appearance, including font settings, colors, node and edge properties, and more.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AuthorName
Author name used in the footer signature (required when -Signature is used).

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

### -CompanyName
Company name used in the footer signature (required when -Signature is used).

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

### -Direction
Layout direction for the graph.
Valid values: 'left-to-right', 'top-to-bottom'.
Default: 'top-to-bottom'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Top-to-bottom
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableMainDiagramLogo
Switch to disable rendering the main diagram logo.

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

### -DraftMode
Switch to enable debug visualization (styles/colors shown for subgraphs, nodes, and edges).

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

### -EdgeArrowSize
Size of edge arrows.
Default: 1.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Edgecolor
Edge line color (RGB hex or color name).
Default: '#71797E'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: #71797E
Accept pipeline input: False
Accept wildcard characters: False
```

### -EdgeLineWidth
Width (pen size) of edge lines.
Default: 3.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -EdgeType
Controls how edges are drawn.
Valid values: 'polyline', 'curved', 'ortho', 'line', 'spline'.
Default: 'line'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Line
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableErrorDebug
Switch to enable verbose and debug output for troubleshooting.

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

### -Filename
Base filename for exported diagrams (extension is appended per format).

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

### -Fontcolor
Default graph font color (RGB hex or color name).
Default: '#000000'.

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

### -Fontname
Default graph font name.
Default: 'Segoe Ui'.

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

### -Format
Output format(s) for the diagram.
Supported values: pdf, svg, png, dot, base64, jpg.
Default: pdf.

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Pdf
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconPath
Path used to resolve icon/image names referenced in $ImagesObj.
Default: Tools\Icons relative to the module.

```yaml
Type: System.IO.FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) 'Tools\Icons')
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImagesObj
Hashtable mapping image identifiers to filenames (IconName -\> FileName).
Defaults include Diagrammer.png and Diagrammer_footer.png.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: @{
            "Main_Logo" = "Diagrammer.png"
            "Logo_Footer" = "Diagrammer_footer.png"
        }
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The PSGraph input object (graph/subgraphs/nodes) used to generate the diagram.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Logo
Path to a custom main diagram logo file.

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

### -LogoName
Name (key in $ImagesObj) to use as the main diagram logo.

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

### -MainDiagramLabel
Main label/title displayed at the top of the diagram.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MainDiagramLabelFontBold
Switch to render the main diagram label in bold.

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

### -MainDiagramLabelFontColor
Font color for the main diagram label (RGB hex or color name).
Default: '#000000'.

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

### -MainDiagramLabelFontItalic
Switch to render the main diagram label in italic.

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

### -MainDiagramLabelFontname
Font name for the main diagram label.
Default: 'Segoe Ui'.

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

### -MainDiagramLabelFontOverline
Switch to render the main diagram label with overline.

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

### -MainDiagramLabelFontsize
Font size for the main diagram label.
Default: 24.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 24
Accept pipeline input: False
Accept wildcard characters: False
```

### -MainDiagramLabelFontStrikeThrough
Switch to render the main diagram label with strikethrough.

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

### -MainDiagramLabelFontSubscript
Switch to render part of the main diagram label as subscript.

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

### -MainDiagramLabelFontSuperscript
Switch to render part of the main diagram label as superscript.

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

### -MainDiagramLabelFontUnderline
Switch to render the main diagram label with underline.

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

### -MainGraphAttributes
Hashtable of graph attributes to override or augment defaults (examples: fontname, fontcolor, imagepath, style, nodesep, ranksep, bgcolor).

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

### -MainGraphBGColor
Background color for the main graph.
Default: 'White'.

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

### -MainGraphLogoSizePercent
Scale percent for the main logo when rendered in the diagram.
Range: 1-100.
Default: 100.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -MainGraphSize
Graph size / image resolution hint (Graphviz size option), e.g.
"8,11!" for specific sizing.

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

### -NodeFontcolor
Node font color (RGB hex or color name).
Default: 'Black'.

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

### -NodeFontSize
Font size used for node labels.
Default: 14.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 14
Accept pipeline input: False
Accept wildcard characters: False
```

### -NodeSeparation
Node separation setting (rank/node separation ratio).
Accepts discrete values as configured.
Default: 0.60.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0.6
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFolderPath
Folder where exported diagram files will be written.
Default: system temp folder.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: [System.IO.Path]::GetTempPath()
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

### -SectionSeparation
Section (subgraph) separation setting (rank separation ratio).
Default: 0.75.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0.75
Accept pipeline input: False
Accept wildcard characters: False
```

### -Signature
Switch to include a footer signature (requires AuthorName and CompanyName).

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

### -SignatureLogo
Path to a custom signature logo file.

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

### -SignatureLogoName
Name (key in $ImagesObj) to use as the signature logo.

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

### -WaterMarkColor
Color used for watermark text.
Default: 'DarkGray'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: DarkGray
Accept pipeline input: False
Accept wildcard characters: False
```

### -WaterMarkFontOpacity
Opacity for the watermark text (0-100).
Default: 30.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -WaterMarkText
Text to render as a watermark on the exported diagram (empty to disable).

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Version:        0.2.32
Author(s):      Jonathan Colon
Bluesky:        @jcolonfpr.bsky.social
Github:         rebelinux
Credits:        Kevin Marquette (@KevinMarquette) - PSGraph module
                Prateek Singh (@PrateekKumarSingh) - AzViz module

## RELATED LINKS

[https://github.com/rebelinux/
https://github.com/KevinMarquette/PSGraph
https://github.com/PrateekKumarSingh/AzViz](https://github.com/rebelinux/
https://github.com/KevinMarquette/PSGraph
https://github.com/PrateekKumarSingh/AzViz)

[https://github.com/rebelinux/
https://github.com/KevinMarquette/PSGraph
https://github.com/PrateekKumarSingh/AzViz]()

