function New-Diagrammer {
    <#
    .SYNOPSIS
        Diagram the configuration of IT infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.
    .DESCRIPTION
        Diagram the configuration of IT infrastructure in PDF/SVG/DOT/PNG formats using PSGraph and Graphviz.
    .PARAMETER DiagramType
        Specifies the type of veeam vbr diagram that will be generated.
        The supported output diagrams are:
            Backup-to-All'
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
        Allow to change the Veeam logo to a custom one.
        Image should be 400px x 100px or less in size.
    .PARAMETER SignatureLogo
        Allow to change the Vb365.Diagrammer signature logo to a custom one.
        Image should be 120px x 130px or less in size.
    .PARAMETER Signature
        Allow the creation of footer signature.
        AuthorName and CompanyName must be set to use this property.
    .NOTES
        Version:        0.1.8
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
            Position = 4,
            Mandatory = $false,
            HelpMessage = 'Please provide the diagram output format'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('pdf', 'svg', 'png', 'dot', 'base64', 'jpg')]
        [Array] $Format = 'pdf',

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
            HelpMessage = 'Specify the Diagram output filename'
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if (($Format | Measure-Object).count -lt 2) {
                    $true
                } else {
                    throw "Format value must be unique if Filename is especified."
                }
            })]
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
            Mandatory = $true,
            HelpMessage = 'Controls type of Veeam VB365 generated diagram'
        )]
        [ValidateSet('Backup-to-All')]
        [string] $DiagramType,

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
        [Switch] $Signature = $false
    )


    begin {

        $script:Images = @{
            "Default_Logo" = "Diagrammer.png"
        }

        if (($Format -ne "base64") -and !(Test-Path $OutputFolderPath)) {
            Write-Error "OutputFolderPath '$OutputFolderPath' is not a valid folder path."
            break
        }

        if ($Signature -and (([string]::IsNullOrEmpty($AuthorName)) -or ([string]::IsNullOrEmpty($CompanyName)))) {
            throw "New-Diagram: AuthorName and CompanyName must be defined if the Signature option is specified"
        }

        $MainGraphLabel = Switch ($DiagramType) {
            'Backup-to-All' { 'Backup for Microsoft 365' }
        }

        $URLIcon = $false

        if ($EnableEdgeDebug) {
            $EdgeDebug = @{style = 'filled'; color = 'red' }
            $URLIcon = $true
        } else { $EdgeDebug = @{style = 'invis'; color = 'red' } }

        if ($EnableSubGraphDebug) {
            $SubGraphDebug = @{style = 'dashed'; color = 'red' }
            $NodeDebug = @{color = 'black'; style = 'red'; shape = 'plain' }
            $NodeDebugEdge = @{color = 'black'; style = 'red'; shape = 'plain' }
            $URLIcon = $true
        } else {
            $SubGraphDebug = @{style = 'invis'; color = 'gray' }
            $NodeDebug = @{color = 'transparent'; style = 'transparent'; shape = 'point' }
            $NodeDebugEdge = @{color = 'transparent'; style = 'transparent'; shape = 'none' }
        }

        $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
        $IconPath = Join-Path $RootPath 'icons'
        $Dir = switch ($Direction) {
            'top-to-bottom' { 'TB' }
            'left-to-right' { 'LR' }
        }

        # Validate Custom logo
        if ($Logo) {
            $CustomLogo = Test-Logo -LogoPath (Get-ChildItem -Path $Logo).FullName -IconPath $IconPath -ImagesObj $Images
        } else {
            $CustomLogo = "Default_Logo"
        }
        # Validate Custom Signature Logo
        if ($SignatureLogo) {
            $CustomSignatureLogo = Test-Logo -LogoPath (Get-ChildItem -Path $SignatureLogo).FullName -IconPath $IconPath -ImagesObj $Images
        }

        $MainGraphAttributes = @{
            pad = 1
            rankdir = $Dir
            overlap = 'false'
            splines = $EdgeType
            penwidth = 1.5
            fontname = "Tahoma Black"
            fontcolor = '#005f4b'
            fontsize = 32
            style = "dashed"
            labelloc = 't'
            imagepath = $IconPath
            nodesep = $NodeSeparation
            ranksep = $SectionSeparation
        }
    }

    process {

        $script:Graph = Graph -Name VeeamVB365 -Attributes $MainGraphAttributes {
            # Node default theme
            Node @{
                label = ''
                shape = 'none'
                labelloc = 't'
                style = 'filled'
                fillColor = '#71797E'
                fontsize = 14;
                imagescale = $true
            }
            # Edge default theme
            Edge @{
                style = 'dashed'
                dir = 'both'
                arrowtail = 'dot'
                color = '#71797E'
                penwidth = 2
                arrowsize = 1
            }

            if ($Signature) {
                if ($CustomSignatureLogo) {
                    $Signature = (Get-HtmlTable -Rows "Author: $($AuthorName)", "Company: $($CompanyName)" -TableBorder 2 -CellBorder 0 -align 'left' -Logo $CustomSignatureLogo)
                } else {
                    $Signature = (Get-HtmlTable -Rows "Author: $($AuthorName)", "Company: $($CompanyName)" -TableBorder 2 -CellBorder 0 -align 'left' -Logo "VB365_LOGO_Footer")
                }
            } else {
                $Signature = " "
            }

            SubGraph OUTERDRAWBOARD1 -Attributes @{Label = $Signature; fontsize = 24; penwidth = 1.5; labelloc = 'b'; labeljust = "r"; style = $SubGraphDebug.style; color = $SubGraphDebug.color } {
                SubGraph MainGraph -Attributes @{Label = (Get-DiaHTMLLabel -ImagesObj $Images -Label $MainGraphLabel -IconType $CustomLogo -URLIcon $URLIcon -IconWidth 250 -IconHeight 80); fontsize = 24; penwidth = 0; labelloc = 't'; labeljust = "c" } {



                }
            }
        }
    }
    end {
        #Export Diagram
        Out-Diagram -GraphObj ($Graph | Select-String -Pattern '"([A-Z])\w+"\s\[label="";style="invis";shape="point";]' -NotMatch) -ErrorDebug $EnableErrorDebug -Rotate $Rotate -Format $Format -Filename $Filename -OutputFolderPath $OutputFolderPath
    }
}