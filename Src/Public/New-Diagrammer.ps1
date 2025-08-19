function New-Diagrammer {
    <#
    .SYNOPSIS
        Diagram the configuration of IT infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.

    .DESCRIPTION
        This cmdlet generates diagrams of IT infrastructure configurations in various formats such as PDF, SVG, DOT, and PNG using PSGraph and Graphviz. It provides extensive customization options for diagram appearance, including font settings, colors, node and edge properties, and more.

    .PARAMETER InputObject
        The PSGraph input object to be used for generating the diagram.

    .PARAMETER Format
        Specifies the output format of the diagram. Supported formats are PDF, PNG, DOT, SVG, and base64. Default is 'pdf'.

    .PARAMETER EdgeColor
        Specifies the color of the edge lines in RGB format (e.g., #FFFFFF). Default is #71797E.

    .PARAMETER EdgeArrowSize
        Specifies the size of the edge arrows. Default is 1.

    .PARAMETER EdgeLineWidth
        Specifies the width of the edge lines. Default is 3.

    .PARAMETER FontColor
        Specifies the color of the diagram font in RGB format (e.g., #FFFFFF) or color string. Default is #565656.

    .PARAMETER FontName
        Specifies the name of the font used in the diagram. Default is 'Segoe Ui Black'.

    .PARAMETER NodeFontSize
        Specifies the font size of the nodes. Default is 14.

    .PARAMETER NodeFontColor
        Specifies the color of the node font in RGB format (e.g., #FFFFFF) or color string. Default is 'Black'.

    .PARAMETER IconPath
        Specifies the path to the icon file.

    .PARAMETER ImagesObj
        Hashtable with the IconName > IconPath translation.

    .PARAMETER Direction
        Specifies the direction in which resources are plotted on the visualization. Supported values are 'left-to-right' and 'top-to-bottom'. Default is 'top-to-bottom'.

    .PARAMETER OutputFolderPath
        Specifies the folder path to save the diagram. Default is the system temporary path.

    .PARAMETER SignatureLogo
        Specifies the path to the custom logo used for the signature.

    .PARAMETER SignatureLogoName
        Specifies the name of the signature logo (must be defined in $ImageObj).

    .PARAMETER Logo
        Specifies the path to the custom logo.

    .PARAMETER LogoName
        Specifies the name of the main diagram logo (must be defined in $ImageObj).

    .PARAMETER Filename
        Specifies a filename for the diagram.

    .PARAMETER EdgeType
        Specifies how edge lines appear in the visualization. Supported values are 'polyline', 'curved', 'ortho', 'line', and 'spline'. Default is 'line'.

    .PARAMETER NodeSeparation
        Controls the node separation ratio in the visualization. Default is 0.60.

    .PARAMETER SectionSeparation
        Controls the section (subgraph) separation ratio in the visualization. Default is 0.75.

    .PARAMETER DraftMode
        Enables subgraph visualization debugging of subgraph, edges & nodes.

    .PARAMETER EnableErrorDebug
        Enables error debugging.

    .PARAMETER AuthorName
        Sets the footer signature author name.

    .PARAMETER CompanyName
        Sets the footer signature company name.

    .PARAMETER Signature
        Enables the creation of a footer signature. AuthorName and CompanyName must be set to use this property.

    .PARAMETER MainDiagramLabel
        Sets the main label used at the top of the diagram.

    .PARAMETER MainDiagramLabelFontSize
        Sets the font size of the main label used at the top of the diagram. Default is 24.

    .PARAMETER MainDiagramLabelFontName
        Sets the font name of the main label used at the top of the diagram. Default is 'Segoe Ui Black'.

    .PARAMETER MainDiagramLabelFontColor
        Sets the font color of the main label used at the top of the diagram. Default is #565656.

    .PARAMETER MainGraphAttributes
        Provides a hashtable with general graph attributes (fontname, fontcolor, imagepath, style, imagepath).

    .PARAMETER WaterMarkColor
        Specifies the color of the watermark text. Default is 'DarkGray'.

    .PARAMETER WaterMarkText
        Specifies the text for the watermark.

    .PARAMETER MainGraphBGColor
        Specifies the background color of the diagram. Default is 'White'.

    .NOTES
        Version:        0.2.24
        Author(s):      Jonathan Colon
        Twitter:        @jcolonfzenpr
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
        [string] $Fontcolor = '#565656',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the diagram font name'
        )]
        [ValidateNotNullOrEmpty()]
        [string] $Fontname = 'Segoe Ui Black',

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
        [System.IO.FileInfo] $IconPath,

        [Parameter(
            Position = 4,
            Mandatory = $false,
            HelpMessage = 'Please provide the icons hashtable'
        )]
        [ValidateNotNullOrEmpty()]
        [Hashtable] $ImagesObj,

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
        [string] $MainDiagramLabelFontname = "Segoe Ui Black",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the Main Label font color used at the top of the diagram'
        )]
        [string] $MainDiagramLabelFontColor = "#565656",

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
            HelpMessage = 'Allow to set diagram backgroud color'
        )]
        [string] $MainGraphBGColor = 'White'
    )


    begin {

        if ($EnableErrorDebug) {
            $global:VerbosePreference = 'Continue'
            $global:DebugPreference = 'Continue'
        } else {
            $global:VerbosePreference = 'SilentlyContinue'
            $global:DebugPreference = 'SilentlyContinue'
        }

        # Variable translating Icon to Image Path ($IconPath)
        if ($ImagesObj) {
            $script:Images = $ImagesObj
        } else {
            $script:Images = @{
                "Main_Logo" = "Diagrammer.png"
                "Logo_Footer" = "Diagrammer_footer.png"
            }
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
        if ($Logo -and (-Not $LogoName)) {
            $CustomLogo = Test-Logo -LogoPath (Get-ChildItem -Path $Logo).FullName -IconPath $IconPath -ImagesObj $Images
        } elseif ($LogoName) {
            $CustomLogo = $LogoName
        } else {
            $CustomLogo = "Diagrammer.png"
        }
        # Validate Custom Signature Logo
        if ($SignatureLogo -and (-Not $SignatureLogoName )) {
            $CustomSignatureLogo = Test-Logo -LogoPath (Get-ChildItem -Path $SignatureLogo).FullName -IconPath $IconPath -ImagesObj $Images
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
                    $Signature = (Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows "Author: $($AuthorName)", "Company: $($CompanyName)" -TableBorder 2 -CellBorder 0 -Align 'left' -Logo $CustomSignatureLogo -IconDebug $IconDebug)
                } else {
                    $Signature = (Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows "Author: $($AuthorName)", "Company: $($CompanyName)" -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -IconDebug $IconDebug)
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
                SubGraph MainGraph -Attributes @{Label = (Add-DiaHTMLLabel -ImagesObj $Images -Label $MainDiagramLabel -IconType $CustomLogo -IconDebug $IconDebug -IconWidth 250 -IconHeight 80 -Fontsize $MainDiagramLabelFontsize -fontColor  $MainDiagramLabelFontColor -fontName  $MainDiagramLabelFontname); fontsize = 24; penwidth = 0; labelloc = 't'; labeljust = "c" } {
                    $InputObject
                }
            }
        }
    }
    end {
        foreach ($OutputFormat in $Format) {
            #Export the Diagram
            if ($Graph) {
                Export-Diagrammer -GraphObj ($Graph | Select-String -Pattern '"([A-Z])\w+"\s\[label="";style="invis";shape="point";]' -NotMatch) -ErrorDebug $EnableErrorDebug -Format $OutputFormat -Filename "$Filename.$OutputFormat" -OutputFolderPath $OutputFolderPath -WaterMarkText $WaterMarkText -WaterMarkColor $WaterMarkColor -IconPath $IconPath
            } else {
                Write-Verbose -Message "No Graph object found. Disabling diagram section"
            }
        }
    }
}