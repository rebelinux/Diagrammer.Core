<#
    Simple example of creating a 3-tier web application diagram using the Diagrammer module, without using object icons.

    ** In this example, servers are grouped in a cluster (SubGraph).
#>

[CmdletBinding()]
param (
    [System.IO.FileInfo] $Path = '~\Desktop\',
    [array] $Format = @('png'),
    [bool] $DraftMode = $false
)

<#
    From PowerShell v3 onwards, the module does not need to be explicitly imported. It is included here for clarity.
#>

Import-Module Diagrammer.Core -Force -Verbose:$false

<#
    As the diagram output is a file, specify the output folder path using $OutputFolderPath.
#>

$OutputFolderPath = Resolve-Path $Path

<#
    The $MainGraphLabel variable sets the main title of the diagram.
#>

$MainGraphLabel = 'Web Application Diagram'


$example4 = & {
    <#
        A SubGraph groups objects in a container, like a graph within a graph. SubGraph attributes allow you to set background color, label, border color, style, etc. (SubGraph is a reserved word in the PSGraph module)
        https://psgraph.readthedocs.io/en/latest/Command-SubGraph/
    #>

    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {
        <#
            This creates a diagram with three servers, custom node labels, and shapes (no object icons).
            Node statements create the nodes in the diagram. (Node is a reserved word in the PSGraph module)
            https://psgraph.readthedocs.io/en/latest/Command-Node/
        #>

        Node -Name Web01 -Attributes @{shape = 'rectangle'; fillColor = 'Green'; fontsize = 14 }
        Node -Name App01 -Attributes @{shape = 'rectangle'; fillColor = 'Blue'; fontsize = 14 }
        Node -Name DB01 -Attributes @{shape = 'rectangle'; fillColor = 'Red'; fontsize = 14 }

        <#
            This section creates connections between the nodes in a hierarchical layout.
            Edge statements create connections between nodes. (Edge is a reserved word in the PSGraph module)
            https://psgraph.readthedocs.io/en/latest/Command-Edge/
        #>

        Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
        Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
    }
}


<#
    This command generates the diagram using the New-Diagrammer cmdlet (part of Diagrammer.Core).
    -InputObject accepts the custom object created above.
    -OutputFolderPath specifies where to save the generated diagram.
    -Format sets the output format (png, jpg, svg, etc.).
    -ImagesObj passes a hashtable of images for custom icons.
    -MainDiagramLabel sets the diagram title.
    -Filename specifies the output file name (without extension).
    -LogoName selects which image from the hashtable to use as a logo in the diagram.
        - If the specified logo image is not found, the diagram uses no_icon.png [?].
    -Direction sets the diagram layout direction: left-to-right or top-to-bottom.
        - The layout is set to top-to-bottom using the Graphviz attribute (TB).
    -DraftMode, when set to $true, generates a draft version of the diagram for troubleshooting.
#>
New-Diagrammer -InputObject $example4 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example4 -LogoName "Main_Logo" -Direction top-to-bottom -DraftMode:$DraftMode
