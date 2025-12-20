function New-Diagrammer {
    <#
    .SYNOPSIS
        Diagram the configuration of IT infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.

    .DESCRIPTION
        This cmdlet generates diagrams of IT infrastructure configurations in various formats such as PDF, SVG, DOT, and PNG using PSGraph and Graphviz. It provides extensive customization options for diagram appearance, including font settings, colors, node and edge properties, and more.

    .PARAMETER InputObject
        The PSGraph input object (graph/subgraphs/nodes) used to generate the diagram.

    .PARAMETER Format
        Output format(s) for the diagram. Supported values: pdf, svg, png, dot, base64, jpg. Default: pdf.

    .PARAMETER Edgecolor
        Edge line color (RGB hex or color name). Default: '#71797E'.

    .PARAMETER EdgeArrowSize
        Size of edge arrows. Default: 1.

    .PARAMETER EdgeLineWidth
        Width (pen size) of edge lines. Default: 3.

    .PARAMETER Fontcolor
        Default graph font color (RGB hex or color name). Default: '#000000'.

    .PARAMETER Fontname
        Default graph font name. Default: 'Segoe Ui'.

    .PARAMETER MainDiagramLabelFontBold
        Switch to render the main diagram label in bold.

    .PARAMETER MainDiagramLabelFontItalic
        Switch to render the main diagram label in italic.

    .PARAMETER MainDiagramLabelFontUnderline
        Switch to render the main diagram label with underline.

    .PARAMETER MainDiagramLabelFontOverline
        Switch to render the main diagram label with overline.

    .PARAMETER MainDiagramLabelFontSubscript
        Switch to render part of the main diagram label as subscript.

    .PARAMETER MainDiagramLabelFontSuperscript
        Switch to render part of the main diagram label as superscript.

    .PARAMETER MainDiagramLabelFontStrikeThrough
        Switch to render the main diagram label with strikethrough.

    .PARAMETER NodeFontSize
        Font size used for node labels. Default: 14.

    .PARAMETER NodeFontcolor
        Node font color (RGB hex or color name). Default: 'Black'.

    .PARAMETER IconPath
        Path used to resolve icon/image names referenced in $ImagesObj. Default: Tools\Icons relative to the module.

    .PARAMETER ImagesObj
        Hashtable mapping image identifiers to filenames (IconName -> FileName). Defaults include Diagrammer.png and Diagrammer_footer.png.

    .PARAMETER Direction
        Layout direction for the graph. Valid values: 'left-to-right', 'top-to-bottom'. Default: 'top-to-bottom'.

    .PARAMETER OutputFolderPath
        Folder where exported diagram files will be written. Default: system temp folder.

    .PARAMETER SignatureLogo
        Path to a custom signature logo file.

    .PARAMETER SignatureLogoName
        Name (key in $ImagesObj) to use as the signature logo.

    .PARAMETER Logo
        Path to a custom main diagram logo file.

    .PARAMETER LogoName
        Name (key in $ImagesObj) to use as the main diagram logo.

    .PARAMETER Filename
        Base filename for exported diagrams (extension is appended per format).

    .PARAMETER EdgeType
        Controls how edges are drawn. Valid values: 'polyline', 'curved', 'ortho', 'line', 'spline'. Default: 'line'.

    .PARAMETER NodeSeparation
        Node separation setting (rank/node separation ratio). Accepts discrete values as configured. Default: 0.60.

    .PARAMETER SectionSeparation
        Section (subgraph) separation setting (rank separation ratio). Default: 0.75.

    .PARAMETER DraftMode
        Switch to enable debug visualization (styles/colors shown for subgraphs, nodes, and edges).

    .PARAMETER EnableErrorDebug
        Switch to enable verbose and debug output for troubleshooting.

    .PARAMETER DisableMainDiagramLogo
        Switch to disable rendering the main diagram logo.

    .PARAMETER AuthorName
        Author name used in the footer signature (required when -Signature is used).

    .PARAMETER CompanyName
        Company name used in the footer signature (required when -Signature is used).

    .PARAMETER Signature
        Switch to include a footer signature (requires AuthorName and CompanyName).

    .PARAMETER MainDiagramLabel
        Main label/title displayed at the top of the diagram.

    .PARAMETER MainDiagramLabelFontsize
        Font size for the main diagram label. Default: 24.

    .PARAMETER MainDiagramLabelFontname
        Font name for the main diagram label. Default: 'Segoe Ui'.

    .PARAMETER MainDiagramLabelFontColor
        Font color for the main diagram label (RGB hex or color name). Default: '#000000'.

    .PARAMETER MainGraphAttributes
        Hashtable of graph attributes to override or augment defaults (examples: fontname, fontcolor, imagepath, style, nodesep, ranksep, bgcolor).

    .PARAMETER WaterMarkColor
        Color used for watermark text. Default: 'DarkGray'.

    .PARAMETER WaterMarkText
        Text to render as a watermark on the exported diagram (empty to disable).

    .PARAMETER WaterMarkFontOpacity
        Opacity for the watermark text (0-100). Default: 30.

    .PARAMETER MainGraphBGColor
        Background color for the main graph. Default: 'White'.

    .PARAMETER MainGraphSize
        Graph size / image resolution hint (Graphviz size option), e.g. "8,11!" for specific sizing.

    .PARAMETER MainGraphLogoSizePercent
        Scale percent for the main logo when rendered in the diagram. Range: 1-100. Default: 100.

    .NOTES
        Version:        0.2.32
        Author(s):      Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux
        Credits:        Kevin Marquette (@KevinMarquette) - PSGraph module
                        Prateek Singh (@PrateekKumarSingh) - AzViz module

    .LINK
        https://github.com/rebelinux/
        https://github.com/KevinMarquette/PSGraph
        https://github.com/PrateekKumarSingh/AzViz
    #>


    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "", Scope = "Function")]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPassWordParams", "", Scope = "Function")]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "", Scope = "Function")]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "", Scope = "Function")]

    [CmdletBinding(
        PositionalBinding = $false,
        DefaultParameterSetName = 'Credential'
    )]
    param (

        [Parameter(
            Position = 1,
            Mandatory = $true,
            HelpMessage = 'Please provide the psgraph input'
        )]
        $InputObject,

        [Parameter(
            Position = 2,
            Mandatory = $false,
            HelpMessage = 'Please provide the diagram output format'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('pdf', 'svg', 'png', 'dot', 'base64', 'jpg')]
        [Array] $Format = 'pdf',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the diagram font color in RGB format (Ex: #FFFFFF)'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $Edgecolor = '#71797E',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the edge arrow size (Int)'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $EdgeArrowSize = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the edge line width (Int)'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $EdgeLineWidth = 3,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the diagram font color in RGB format (Ex: #FFFFFF) or color string'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $Fontcolor = '#000000',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the diagram font name'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $Fontname = 'Segoe Ui',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font bold'
        )]
        [switch] $MainDiagramLabelFontBold,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font italic'
        )]
        [switch] $MainDiagramLabelFontItalic,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font underline'
        )]
        [switch] $MainDiagramLabelFontUnderline,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font overline'
        )]
        [switch] $MainDiagramLabelFontOverline,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font subscript'
        )]
        [switch] $MainDiagramLabelFontSubscript,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font superscript'
        )]
        [switch] $MainDiagramLabelFontSuperscript,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font strikethrough'
        )]
        [switch] $MainDiagramLabelFontStrikeThrough,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the node font size (Int)'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $NodeFontSize = 14,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the node font color in RGB format (Ex: #FFFFFF) or color string'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $NodeFontcolor = 'Black',

        [Parameter(
            Position = 3,
            Mandatory = $false,
            HelpMessage = 'Please provide the diagram output format'
        )]
        [ValidateScript( {
                if (Test-Path -Path $_) {
                    $true
                } else {
                    throw "Path $_ not found!"
                }
            })]
        [System.IO.FileInfo] $IconPath = (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) 'Tools\Icons'),

        [Parameter(
            Position = 4,
            Mandatory = $false,
            HelpMessage = 'Please provide the icons hashtable'
        )]
        [ValidateNotNullOrEmpty()]
        [Hashtable] $ImagesObj = @{
            "Main_Logo" = "Diagrammer.png"
            "Logo_Footer" = "Diagrammer_footer.png"
        },

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Direction in which resource are plotted on the visualization'
        )]
        [ValidateSet('left-to-right', 'top-to-bottom')]
        [string] $Direction = 'top-to-bottom',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the diagram output file'
        )]
        [ValidateScript( {
                if (Test-Path -Path $_) {
                    $true
                } else {
                    throw "Path $_ not found!"
                }
            })]
        [string] $OutputFolderPath = [System.IO.Path]::GetTempPath(),

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the custom logo used for Signature'
        )]
        [ValidateScript( {
                if (Test-Path -Path $_) {
                    $true
                } else {
                    throw "File $_ not found!"
                }
            })]
        [string] $SignatureLogo,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the name of the signature logo (Must be defined in $ImageObj)'
        )]
        [string] $SignatureLogoName,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the path to the custom logo'
        )]
        [ValidateScript( {
                if (Test-Path -Path $_) {
                    $true
                } else {
                    throw "File $_ not found!"
                }
            })]
        [string] $Logo,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the name of the main diagram logo (Must be defined in $ImageObj)'
        )]
        [string] $LogoName,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specify the Diagram filename'
        )]
        [ValidateNotNullOrEmpty()]
        [String] $Filename,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Controls how edges lines appear in visualization'
        )]
        [ValidateSet('polyline', 'curved', 'ortho', 'line', 'spline')]
        [string] $EdgeType = 'line',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Controls Node separation ratio in visualization'
        )]
        [ValidateSet(0, 1, 2, 3)]
        [string] $NodeSeparation = .60,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Controls Section (Subgraph) separation ratio in visualization'
        )]
        [ValidateSet(0, 1, 2, 3)]
        [string] $SectionSeparation = .75,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to enable visualization debugging of subgraph, edges and nodes'
        )]
        [Switch] $DraftMode = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to enable error debugging'
        )]
        [Switch] $EnableErrorDebug = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Disable the Main Diagram Logo'
        )]
        [Switch] $DisableMainDiagramLogo,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set footer signature Author Name'
        )]
        [string] $AuthorName,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set footer signature Company Name'
        )]
        [string] $CompanyName,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow the creation of footer signature'
        )]
        [Switch] $Signature = $false,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Set the Main Label used at the top of the diagram'
        )]
        [string] $MainDiagramLabel,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the Main Label font size used at the top of the diagram'
        )]
        [int] $MainDiagramLabelFontsize = 24,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the Main Label font name used at the top of the diagram'
        )]
        [string] $MainDiagramLabelFontname = "Segoe Ui",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the Main Label font color used at the top of the diagram'
        )]
        [string] $MainDiagramLabelFontColor = "#000000",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Provide a Hashtable with general graph attributes (fontname,fontcolor,imagepath,style,imagepath)'
        )]
        [ValidateNotNullOrEmpty()]
        [Hashtable] $MainGraphAttributes,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Provide a System.Drawing.Color compatible color for the WaterMark text (Ex. Red, Green, Blue, Black)'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $WaterMarkColor = 'DarkGray',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow the creation of a watermark in the diagram'
        )]
        [string] $WaterMarkText = '',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the font opacity of the watermark text (0 to 100)'
        )]
        [int] $WaterMarkFontOpacity = 30,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set diagram backgroud color'
        )]
        [string] $MainGraphBGColor = 'White',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set image resolution size (Ex: 8,11! = 800x1100 pixels)'
        )]
        [string] $MainGraphSize,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the image size in percent (100% is default)'
        )]
        [ValidateRange(1, 100)]
        [int] $MainGraphLogoSizePercent = 100
    )

    begin {

        if ($EnableErrorDebug) {
            $global:VerbosePreference = 'Continue'
            $global:DebugPreference = 'Continue'
        } else {
            $global:VerbosePreference = 'SilentlyContinue'
            $global:DebugPreference = 'SilentlyContinue'
        }

        if (($Format -ne "base64") -and !(Test-Path $OutputFolderPath)) {
            Write-Error -Message "OutputFolderPath '$OutputFolderPath' is not a valid folder path."
            break
        }

        if ($Signature -and (([string]::IsNullOrEmpty($AuthorName)) -or ([string]::IsNullOrEmpty($CompanyName)))) {
            throw "New-Diagrammer: AuthorName and CompanyName must be defined if the Signature option is specified"
        }

        $IconDebug = $false

        if ($DraftMode) {
            $SubGraphDebug = @{style = 'dashed'; color = 'red' }
            $NodeDebug = @{color = 'black'; style = 'red'; shape = 'plain' }
            $NodeDebugEdge = @{color = 'black'; style = 'red'; shape = 'plain' }
            $EdgeDebug = @{style = 'filled'; color = 'red' }
            $IconDebug = $true
        } else {
            $SubGraphDebug = @{style = 'invis'; color = 'gray' }
            $NodeDebug = @{color = 'transparent'; style = 'transparent'; shape = 'point' }
            $NodeDebugEdge = @{color = 'transparent'; style = 'transparent'; shape = 'none' }
            $EdgeDebug = @{style = 'invis'; color = 'red' }
        }

        $Dir = switch ($Direction) {
            'top-to-bottom' { 'TB' }
            'left-to-right' { 'LR' }
        }

        # Validate Custom logo
        if ($Logo -and (-not $LogoName)) {
            $CustomLogo = Test-Logo -LogoPath (Get-ChildItem -Path $Logo).FullName -IconPath $IconPath -ImagesObj $ImagesObj
        } elseif ($LogoName) {
            $CustomLogo = $LogoName
        } else {
            $CustomLogo = "Diagrammer.png"
        }
        # Validate Custom Signature Logo
        if ($SignatureLogo -and (-not $SignatureLogoName )) {
            $CustomSignatureLogo = Test-Logo -LogoPath (Get-ChildItem -Path $SignatureLogo).FullName -IconPath $IconPath -ImagesObj $ImagesObj
        } elseif ($SignatureLogoName) {
            $CustomSignatureLogo = $SignatureLogoName
        } else {
            $CustomSignatureLogo = "Diagrammer.png"
        }

        $MainGraphAttributes = @{
            pad = 1
            rankdir = $Dir
            splines = $EdgeType
            penwidth = 1.5
            fontname = $Fontname
            fontcolor = $Fontcolor
            fontsize = 32
            style = "dashed"
            labelloc = 't'
            imagepath = $IconPath
            nodesep = $NodeSeparation
            ranksep = $SectionSeparation
            bgcolor = $MainGraphBGColor
            compound = $true
        }

        if ($MainGraphSize) {
            $MainGraphAttributes['size'] = $MainGraphSize
        }
    }

    process {

        # Graph default atrributes
        $script:Graph = Graph -Name Root -Attributes $MainGraphAttributes {
            # Node default theme
            Node @{
                # label = ''
                shape = 'none'
                labelloc = 't'
                style = 'filled'
                fillColor = '#71797E'
                fontsize = $NodeFontSize
                imagescale = $true
                fontcolor = $NodeFontcolor
            }
            # Edge default theme
            Edge @{
                style = 'dashed'
                dir = 'both'
                arrowtail = 'dot'
                color = $Edgecolor
                penwidth = $EdgeLineWidth
                arrowsize = $EdgeArrowSize
                fontcolor = $Edgecolor
            }

            # Signature Section
            if ($Signature) {
                Write-Verbose -Message "Generating diagram signature"
                if ($CustomSignatureLogo) {
                    $Signature = (Add-DiaHtmlSignatureTable -ImagesObj $ImagesObj -Rows "Author: $($AuthorName)", "Company: $($CompanyName)" -TableBorder 2 -CellBorder 0 -Align 'left' -Logo $CustomSignatureLogo -IconDebug $IconDebug)
                } else {
                    $Signature = (Add-DiaHtmlSignatureTable -ImagesObj $ImagesObj -Rows "Author: $($AuthorName)", "Company: $($CompanyName)" -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -IconDebug $IconDebug)
                }
            } else {
                Write-Verbose -Message "No diagram signature specified"
                $Signature = " "
            }

            #---------------------------------------------------------------------------------------------#
            #                             Graphviz Clusters (SubGraph) Section                            #
            #               SubGraph can be use to bungle the Nodes together like a single entity         #
            #                     SubGraph allow you to have a graph within a graph                       #
            #                PSgraph: https://psgraph.readthedocs.io/en/latest/Command-SubGraph/          #
            #                      Graphviz: https://graphviz.org/docs/attrs/cluster/                     #
            #---------------------------------------------------------------------------------------------#

            # Subgraph OUTERDRAWBOARD1 used to draw the footer signature (bottom-right corner)
            SubGraph OUTERDRAWBOARD1 -Attributes @{Label = $Signature; fontsize = 24; penwidth = 1.5; labelloc = 'b'; labeljust = "r"; style = $SubGraphDebug.style; color = $SubGraphDebug.color } {
                # Subgraph MainGraph used to draw the main drawboard.
                if ($DisableMainDiagramLogo) {
                    $FormatedMainLogo = ""
                } else {
                    $FormatedMainLogo = (Add-DiaHtmlLabel -ImagesObj $ImagesObj -Label $MainDiagramLabel -IconType $CustomLogo -IconDebug $IconDebug -ImageSizePercent $MainGraphLogoSizePercent -Fontsize $MainDiagramLabelFontsize -FontColor  $MainDiagramLabelFontColor -FontName $MainDiagramLabelFontname -FontBold:$MainDiagramLabelFontBold -FontItalic:$MainDiagramLabelFontItalic -FontUnderline:$MainDiagramLabelFontUnderline -FontOverline:$MainDiagramLabelFontOverline -FontSubscript:$MainDiagramLabelFontSubscript -FontSuperscript:$MainDiagramLabelFontSuperscript -FontStrikeThrough:$MainDiagramLabelFontStrikeThrough -IconPath $IconPath)
                }

                SubGraph MainGraph -Attributes @{Label = $FormatedMainLogo; fontsize = 24; penwidth = 0; labelloc = 't'; labeljust = "c" } {
                    $InputObject
                }
            }
        }
    }
    end {
        foreach ($OutputFormat in $Format) {
            #Export the Diagram
            if ($Graph) {
                Export-Diagrammer -GraphObj ($Graph | Select-String -Pattern '"\w+"\s\[label="";style="invis";shape="point";]' -NotMatch) -ErrorDebug $EnableErrorDebug -Format $OutputFormat -Filename "$Filename.$OutputFormat" -OutputFolderPath $OutputFolderPath -WaterMarkText $WaterMarkText -WaterMarkColor $WaterMarkColor -IconPath $IconPath -WaterMarkFontOpacity $WaterMarkFontOpacity
            } else {
                Write-Verbose -Message "No Graph object found. Disabling diagram section"
            }
        }
    }
}