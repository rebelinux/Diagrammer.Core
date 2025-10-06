---
document type: cmdlet
external help file: Diagrammer.Core-Help.xml
HelpUri: >-
  https://github.com/rebelinux/

  https://github.com/KevinMarquette/PSGraph

  https://github.com/PrateekKumarSingh/AzViz
Locale: en-US
Module Name: Diagrammer.Core
ms.date: 10/04/2025
PlatyPS schema version: 2024-05-01
title: New-Diagrammer
---

# New-Diagrammer

## SYNOPSIS

Diagram the configuration of IT infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.

## SYNTAX

### Credential (Default)

```
New-Diagrammer [-InputObject] <Object> [[-Format] <array>] [[-IconPath] <FileInfo>]
 [[-ImagesObj] <hashtable>] -MainDiagramLabel <string> [-Edgecolor <string>]
 [-EdgeArrowSize <string>] [-EdgeLineWidth <string>] [-Fontcolor <string>] [-Fontname <string>]
 [-NodeFontSize <string>] [-NodeFontcolor <string>] [-Direction <string>]
 [-OutputFolderPath <string>] [-SignatureLogo <string>] [-SignatureLogoName <string>]
 [-Logo <string>] [-LogoName <string>] [-Filename <string>] [-EdgeType <string>]
 [-NodeSeparation <string>] [-SectionSeparation <string>] [-DraftMode] [-EnableErrorDebug]
 [-AuthorName <string>] [-CompanyName <string>] [-Signature] [-MainDiagramLabelFontsize <int>]
 [-MainDiagramLabelFontname <string>] [-MainDiagramLabelFontColor <string>]
 [-MainGraphAttributes <hashtable>] [-WaterMarkColor <string>] [-WaterMarkText <string>]
 [-WaterMarkFontOpacity <int>] [-MainGraphBGColor <string>] [-MainGraphSize <string>]
 [-MainGraphLogoSizePercent <int>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,

- None

## DESCRIPTION

This cmdlet generates diagrams of IT infrastructure configurations in various formats such as PDF, SVG, DOT, and PNG using PSGraph and Graphviz.
It provides extensive customization options for diagram appearance, including font settings, colors, node and edge properties, and more.

## EXAMPLES

### Example 1

```powershell
New-Diagrammer -InputObject $myObject -Format PDF -OutputFolderPath "C:\Diagrams"
```

This command generates a new diagram from the specified input object and saves it as a PDF file in the specified output folder.

## PARAMETERS

### -AuthorName

Sets the footer signature author name.

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

### -CompanyName

Sets the footer signature company name.

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

### -Direction

Specifies the direction in which resources are plotted on the visualization.
Supported values are 'left-to-right' and 'top-to-bottom'.
Default is 'top-to-bottom'.

```yaml
Type: System.String
DefaultValue: top-to-bottom
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

### -DraftMode

Enables subgraph visualization debugging of subgraph, edges & nodes.

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

### -EdgeArrowSize

Specifies the size of the edge arrows.
Default is 1.

```yaml
Type: System.String
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

### -Edgecolor

Specifies the color of the edge lines in RGB format (e.g., #FFFFFF).
Default is #71797E.

```yaml
Type: System.String
DefaultValue: '#71797E'
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

### -EdgeLineWidth

Specifies the width of the edge lines.
Default is 3.

```yaml
Type: System.String
DefaultValue: 3
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

### -EdgeType

Specifies how edge lines appear in the visualization.
Supported values are 'polyline', 'curved', 'ortho', 'line', and 'spline'.
Default is 'line'.

```yaml
Type: System.String
DefaultValue: line
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

### -EnableErrorDebug

Enables error debugging.

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

### -Filename

Specifies a filename for the diagram.

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

### -Fontcolor

Specifies the color of the diagram font in RGB format (e.g., #FFFFFF) or color string.
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

### -Fontname

Specifies the name of the font used in the diagram.
Default is 'Segoe Ui Black'.

```yaml
Type: System.String
DefaultValue: Segoe Ui Black
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

### -Format

Specifies the output format of the diagram.
Supported formats are PDF, PNG, DOT, SVG, and base64.
Default is 'pdf'.

```yaml
Type: System.Array
DefaultValue: pdf
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

### -IconPath

Specifies the path to the icon file.

```yaml
Type: System.IO.FileInfo
DefaultValue: (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) 'icons')
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

### -ImagesObj

Hashtable with the IconName > IconPath translation.

```yaml
Type: System.Collections.Hashtable
DefaultValue: >-
  @{
              "Main_Logo" = "Diagrammer.png"
              "Logo_Footer" = "Diagrammer_footer.png"
          }
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

### -InputObject

The PSGraph input object to be used for generating the diagram.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Logo

Specifies the path to the custom logo.

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

### -LogoName

Specifies the name of the main diagram logo (must be defined in $ImageObj).

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

### -MainDiagramLabel

Sets the main label used at the top of the diagram.

```yaml
Type: System.String
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

### -MainDiagramLabelFontColor

Sets the font color of the main label used at the top of the diagram.
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

### -MainDiagramLabelFontname

Sets the font name of the main label used at the top of the diagram.
Default is 'Segoe Ui Black'.

```yaml
Type: System.String
DefaultValue: Segoe Ui Black
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

### -MainDiagramLabelFontsize

Sets the font size of the main label used at the top of the diagram.
Default is 24.

```yaml
Type: System.Int32
DefaultValue: 24
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

### -MainGraphAttributes

Provides a hashtable with general graph attributes (fontname, fontcolor, imagepath, style, imagepath).

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

### -MainGraphBGColor

Specifies the background color of the diagram.
Default is 'White'.

```yaml
Type: System.String
DefaultValue: White
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

### -MainGraphLogoSizePercent

Set the image size in percent (100% is default)

```yaml
Type: System.Int32
DefaultValue: 100
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

### -MainGraphSize

Specifies the image resolution size.
(e.g., 8,11! = 800x1100 pixels) Default = None.

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

### -NodeFontcolor

Specifies the color of the node font in RGB format (e.g., #FFFFFF) or color string.
Default is 'Black'.

```yaml
Type: System.String
DefaultValue: Black
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

### -NodeFontSize

Specifies the font size of the nodes.
Default is 14.

```yaml
Type: System.String
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

### -NodeSeparation

Controls the node separation ratio in the visualization.
Default is 0.60.

```yaml
Type: System.String
DefaultValue: 0.6
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

### -OutputFolderPath

Specifies the folder path to save the diagram.
Default is the system temporary path.

```yaml
Type: System.String
DefaultValue: '[System.IO.Path]::GetTempPath()'
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

### -SectionSeparation

Controls the section (subgraph) separation ratio in the visualization.
Default is 0.75.

```yaml
Type: System.String
DefaultValue: 0.75
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

### -Signature

Enables the creation of a footer signature.
AuthorName and CompanyName must be set to use this property.

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

### -SignatureLogo

Specifies the path to the custom logo used for the signature.

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

### -SignatureLogoName

Specifies the name of the signature logo (must be defined in $ImageObj).

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

### -WaterMarkColor

Specifies the color of the watermark text.
Default is 'DarkGray'.

```yaml
Type: System.String
DefaultValue: DarkGray
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
  Position: Named
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -WaterMarkText

Specifies the text for the watermark.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Object

A representation of the newly created diagram.

## NOTES

```
Version:        0.2.30
Author(s):      Jonathan Colon
Twitter:        @jcolonfzenpr
Github:         rebelinux
Credits:        Kevin Marquette (@KevinMarquette) - PSGraph module
                Prateek Singh (@PrateekKumarSingh) - AzViz module
```


## RELATED LINKS

[Diagrammer.Core](https://github.com/rebelinux/Diagrammer.Core)
