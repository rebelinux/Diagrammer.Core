#     ** This time we will extend the edges size using the Graphviz minlen attribute. **
<#
    Simple example of how to create a 3 tier web application diagram using the Diagrammer module. Without using any object icons.
#>

[CmdletBinding()]
param (
    [System.IO.FileInfo] $Path = '~\Desktop\',
    [array] $Format = @('png'),
    [bool] $DraftMode = $false
)

<#
    From Powershell v3 onwards, the module should not need to be explicitly imported. It is included
    here to avoid any ambiguity.
#>

Import-Module Diagrammer.Core -Force -Verbose:$false

<#
    As the output of the diagram is a file, we need to specify the output folder path. In this example, $OutputFolderPath
#>

$OutputFolderPath = Resolve-Path $Path

<#
    The $MainGraphLabel variable is used to set the main title of the diagram.
#>

$MainGraphLabel = 'Web Application Diagram'


$example3 = & {
    <#
        This creates a 3 server diagram with custom node labels and shapes (No Object icons).
        The Node statements create the nodes in the diagram. (Node is a reserved word in PSGraph module)
        https://psgraph.readthedocs.io/en/latest/Command-Node/
    #>

    Node -Name Web01 -Attributes @{Label = 'Web01'; shape = 'rectangle'; fillColor = 'Green'; fontsize = 14 }
    Node -Name App01 -Attributes @{ Label = 'App01'; shape = 'rectangle'; fillColor = 'Blue'; fontsize = 14 }
    Node -Name DB01 -Attributes @{Label = 'DB01'; shape = 'rectangle'; fillColor = 'Red'; fontsize = 14 }

    <#
        This section creates connections between the nodes in a herarchical layout.
        The Edge statements create connections between the nodes. (Edge is a reserved word in PSGraph module)
        https://psgraph.readthedocs.io/en/latest/Command-Edge/

        ** The minlen attribute is used to increase the minimum length of the edge lines. **
    #>

    Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
    Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
}


<#
    This command generates the diagram using the New-Diagrammer cmdlet (Part of Diagrammer.Core).
    The -InputObject parameter accepts the custom object created above.
    The -OutputFolderPath parameter specifies where to save the generated diagram.
    The -Format parameter specifies the output format (png, jpg, svg, etc.).
    The -ImagesObj parameter passes the hashtable of images for custom icons.
    The -MainDiagramLabel parameter sets the title of the diagram.
    The -Filename parameter specifies the name of the output file (without extension).
    The -LogoName parameter specifies which image from the hashtable to use as a logo in the diagram.
    If the specified logo image is not found in the hashtable, the diagram will be generated using a no_icon.png [?].
    The -Direction parameter sets the layout direction of the diagram. Options are: left-to-right, top-to-bottom.
    The layout is set to top-to-bottom (Top to Bottom) using the Graph attribute.
    The -DraftMode parameter, when set to $true, generates a draft version of the diagram for troubleshooting.
#>
New-Diagrammer -InputObject $example3 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example3 -LogoName "Main_Logo" -Direction top-to-bottom -DraftMode:$DraftMode