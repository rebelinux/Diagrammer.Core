function New-Diagrammer {
    <#
    .SYNOPSIS
        Diagram the configuration of IT infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.
    .DESCRIPTION
        Diagram the configuration of IT infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.
    .PARAMETER EdgeArrowSize
        Control edge arrow size (Default 1).
    .PARAMETER EdgeLineWidth
        Control edge linewidth (Default 3).
    .PARAMETER EdgeColor
        Control edge line color (RGB format Ex: #FFFFFF) (Default #71797E).
    .PARAMETER FontName
        Control diagram font name (Default 'Segoe Ui Black').
    .PARAMETER FontColor
        Control diagram font color (RGB format Ex: #FFFFFF) (Default #565656).
    .PARAMETER FontName
        Control diagram font name (Default 'Segoe Ui Black').
    .PARAMETER NodeFontSize
        Control Node font size (Default 14).
    .PARAMETER Format
        Specifies the output format of the diagram.
        The supported output formats are PDF, PNG, DOT & SVG.
        Multiple output formats may be specified, separated by a comma.
    .PARAMETER Direction
        Set the direction in which resource are plotted on the visualization
        The supported directions are:
            'top-to-bottom', 'left-to-right'
        By default, direction will be set to top-to-bottom.
    .PARAMETER NodeSeparation
        Controls Node separation ratio in visualization
        By default, NodeSeparation will be set to .60.
    .PARAMETER SectionSeparation
        Controls Section (Subgraph) separation ratio in visualization
        By default, NodeSeparation will be set to .75.
    .PARAMETER EdgeType
        Controls how edges lines appear in visualization
        The supported edge type are:
            'polyline', 'curved', 'ortho', 'line', 'spline'
        By default, EdgeType will be set to spline.
        References: https://graphviz.org/docs/attrs/splines/
    .PARAMETER OutputFolderPath
        Specifies the folder path to save the diagram.
    .PARAMETER Filename
        Specifies a filename for the diagram.
    .PARAMETER EnableEdgeDebug
        Control to enable edge debugging ( Dummy Edge and Node lines ).
    .PARAMETER EnableSubGraphDebug
        Control to enable subgraph debugging ( Subgraph Lines ).
    .PARAMETER EnableErrorDebug
        Control to enable error debugging.
    .PARAMETER AuthorName
        Allow to set footer signature Author Name.
    .PARAMETER CompanyName
        Allow to set footer signature Company Name.
    .PARAMETER Logo
        Allow to change the Main logo to a custom one.
        Image should be 400px x 100px or less in size.
    .PARAMETER LogoName
        Allow to change the Main logo to a custom one.
        Image should be 400px x 100px or less in size.
        Must be defined in $ImageObj
    .PARAMETER SignatureLogo
        Allow to change the signature logo to a custom one.
        Image should be 120px x 130px or less in size.
    .PARAMETER Signature
        Allow the creation of footer signature.
        AuthorName and CompanyName must be set to use this property.
    .PARAMETER ImagesObj
        Hashtable with the IconName > IconPath translation
    .PARAMETER MainGraphAttributes
        Hashtable with general graph attributes (fontname,fontcolor,imagepath,style,imagepath)
    .PARAMETER WaterMarkColor
        Control diagram WaterMark color (Default DarkGray).
    .PARAMETER WaterMarkText
        Control diagram WaterMark (Default empty).
    .NOTES
        Version:        0.2.5
        Author(s):      Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
        Credits:        Kevin Marquette (@KevinMarquette) -  PSGraph module
        Credits:        Prateek Singh (@PrateekKumarSingh) - AzViz module
    .LINK
        https://github.com/rebelinux/
        https://github.com/KevinMarquette/PSGraph
        https://github.com/PrateekKumarSingh/AzViz
    #>

    [Diagnostics.CodeAnalysis.SuppressMessage(
        'PSUseShouldProcessForStateChangingFunctions',
        ''
    )]

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
        [ValidateSet('pdf', 'svg', 'png', 'dot', 'base64')]
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
            HelpMessage = 'Please provide the diagram font color in RGB format (Ex: #FFFFFF)'
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
            HelpMessage = 'Allow to enable edge debugging ( Dummy Edge and Node lines)'
        )]
        [Switch] $EnableEdgeDebug = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to enable subgraph debugging ( Subgraph Lines )'
        )]
        [Switch] $EnableSubGraphDebug = $false,
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
        [string] $WaterMarkText = ''
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
            Write-Error "OutputFolderPath '$OutputFolderPath' is not a valid folder path."
            break
        }

        if ($Signature -and (([string]::IsNullOrEmpty($AuthorName)) -or ([string]::IsNullOrEmpty($CompanyName)))) {
            throw "New-Diagrammer: AuthorName and CompanyName must be defined if the Signature option is specified"
        }

        $IconDebug = $false

        if ($EnableEdgeDebug) {
            $EdgeDebug = @{style = 'filled'; color = 'red' }
            $IconDebug = $true
        } else { $EdgeDebug = @{style = 'invis'; color = 'red' } }

        if ($EnableSubGraphDebug) {
            $SubGraphDebug = @{style = 'dashed'; color = 'red' }
            $NodeDebug = @{color = 'black'; style = 'red'; shape = 'plain' }
            $NodeDebugEdge = @{color = 'black'; style = 'red'; shape = 'plain' }
            $IconDebug = $true
        } else {
            $SubGraphDebug = @{style = 'invis'; color = 'gray' }
            $NodeDebug = @{color = 'transparent'; style = 'transparent'; shape = 'point' }
            $NodeDebugEdge = @{color = 'transparent'; style = 'transparent'; shape = 'none' }
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
            overlap = 'false'
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
        }
    }

    process {

        # Graph default atrributes
        $script:Graph = Graph -Name Root -Attributes $MainGraphAttributes {
            # Node default theme
            Node @{
                label = ''
                shape = 'none'
                labelloc = 't'
                style = 'filled'
                fillColor = '#71797E'
                fontsize = $NodeFontSize
                imagescale = $true
            }
            # Edge default theme
            Edge @{
                style = 'dashed'
                dir = 'both'
                arrowtail = 'dot'
                color = $Edgecolor
                penwidth = $EdgeLineWidth
                arrowsize = $EdgeArrowSize
            }

            # Signature Section
            if ($Signature) {
                Write-Verbose "Generating diagram signature"
                if ($CustomSignatureLogo) {
                    $Signature = (Get-DiaHTMLTable -ImagesObj $Images -Rows "Author: $($AuthorName)", "Company: $($CompanyName)" -TableBorder 2 -CellBorder 0 -Align 'left' -Logo $CustomSignatureLogo -IconDebug $IconDebug)
                } else {
                    $Signature = (Get-DiaHTMLTable -ImagesObj $Images -Rows "Author: $($AuthorName)", "Company: $($CompanyName)" -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -IconDebug $IconDebug)
                }
            } else {
                Write-Verbose "No diagram signature specified"
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
                SubGraph MainGraph -Attributes @{Label = (Get-DiaHTMLLabel -ImagesObj $Images -Label $MainDiagramLabel -IconType $CustomLogo -IconDebug $IconDebug -IconWidth 250 -IconHeight 80); fontsize = 24; penwidth = 0; labelloc = 't'; labeljust = "c" } {
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
                Write-Verbose "No Graph object found. Disabling diagram section"
            }
        }
    }
}