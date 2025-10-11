#    ** This time we will add icons and additional information to Node objects.**

<#
    This example demonstrates how to create a 3-tier web application diagram using the Diagrammer module.
#>

[CmdletBinding()]
param (
    [System.IO.FileInfo] $Path = '~\Desktop\',
    [array] $Format = @('png'),
    [bool] $DraftMode = $false
)

<#
    Starting with PowerShell v3, modules do not need to be explicitly imported.
    It is included here for clarity.
#>

# Import-Module Diagrammer.Core -Force -Verbose:$false

<#
    The diagram output is a file, so we need to specify the output folder path. In this example, $OutputFolderPath is used.
#>

$OutputFolderPath = Resolve-Path $Path

<#
    If the diagram uses custom icons, specify the path to the icons directory. This is a Graphviz requirement.
#>

$RootPath = $PSScriptRoot
[System.IO.FileInfo]$IconPath = Join-Path $RootPath 'Icons'

<#
    The $Images variable is a hashtable containing the names of image files used in the diagram.
    The image files must be located in the directory specified by $IconPath.
    ** Image sizes should be around 100x100, 150x150 pixels for optimal display. **
#>

$script:Images = @{
    "Main_Logo" = "Diagrammer.png"
    "Server" = "Server.png"
}

<#
    The $MainGraphLabel variable sets the main title of the diagram.
#>

$MainGraphLabel = 'Web Application Diagram'

<#
    This section creates custom objects to hold server information, which are used to set node labels in the diagram.
#>

$WebServerInfo = [PSCustomObject][ordered]@{
    'OS' = 'Redhat Linux'
    'Version' = '10'
    'Build' = "10.1"
    'Edition' = "Enterprise"
}

$AppServerInfo = [PSCustomObject][ordered]@{
    'OS' = 'Windows Server'
    'Version' = '2019'
    'Build' = "17763.3163"
    'Edition' = "Datacenter"
}

$DBServerInfo = [PSCustomObject][ordered]@{
    'OS' = 'Oracle Server'
    'Version' = '8'
    'Build' = "8.2"
    'Edition' = "Enterprise"
}

$example5 = & {
    <#
        A SubGraph allows you to group objects in a container, creating a graph within a graph.
        SubGraph, Node, and Edge have attributes for setting background color, label, border color, style, etc.
        (SubGraph is a reserved word in the PSGraph module)
        https://psgraph.readthedocs.io/en/latest/Command-SubGraph/
    #>

    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {

        <#
            This time, we enhance the diagram by adding images to the Node objects and embedding information to describe server properties.
            Graphviz supports HTML tables to extend object labels, allowing images, text, and tables within Node, Edge, and Subgraph @{Label=} script blocks attributes.
            Add-DiaNodeIcon extends PSGraph to improve the appearance of the generated Node objects (Add-DiaNodeIcon is part of Diagrammer.Core).
            ** The $Images object and IconType "Server" must be defined earlier in the script **

            -AditionalInfo parameter accepts a custom object with properties to display in the node label.
            -Align parameter sets the alignment of the icon and text (Left, Right, Center).
            -ImagesObj parameter passes the hashtable of images defined earlier in the script.
            -FontSize 18 sets the font size for the node label text.
        #>

        $Web01Label = Add-DiaNodeIcon -Name 'Web-Server-01' -AditionalInfo $WebServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode
        $App01Label = Add-DiaNodeIcon -Name 'App-Server-01' -AditionalInfo $AppServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode
        $DB01Label = Add-DiaNodeIcon -Name 'Db-Server-01' -AditionalInfo $DBServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

        Node -Name Web01 -Attributes @{Label = $Web01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
        Node -Name App01 -Attributes @{ Label = $App01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
        Node -Name DB01 -Attributes @{Label = $DB01Label; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

        <#
            This section creates connections between the nodes in a hierarchical layout.
            The Edge statements create connections between the nodes. (Edge is a reserved word in the PSGraph module)
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
    -ImagesObj passes the hashtable of images for custom icons.
    -MainDiagramLabel sets the diagram title.
    -Filename specifies the output file name (without extension).
    -LogoName selects which image from the hashtable to use as the diagram logo.
        - If the specified logo image is not found, the diagram uses no_icon.png [?].
    -Direction sets the diagram layout direction: left-to-right or top-to-bottom.
        - The layout is set to top-to-bottom using the Graph attribute.
    -DraftMode, when set to $true, generates a draft version of the diagram for troubleshooting.

    -IconPath and -ImagesObj allow Diagrammer.Core to locate the png icon files.
#>

New-Diagrammer -InputObject $example5 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example5 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -DraftMode:$DraftMode
