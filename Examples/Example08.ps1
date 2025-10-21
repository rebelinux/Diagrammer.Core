#    ** This time, we'll demonstrate the use of the Add-DiaHTMLNodeTable cmdlet (Part of Diagrammer.Core module). **

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

$example8 = & {
    <#
        A SubGraph allows you to group objects in a container, creating a graph within a graph.
        SubGraph, Node, and Edge have attributes for setting background color, label, border color, style, etc.
        (SubGraph is a reserved word in the PSGraph module)
        https://psgraph.readthedocs.io/en/latest/Command-SubGraph/
    #>

    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 22; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "darkgray" } {

        $WebServerFarm = @(
            @{
                Name = 'Web-Server-01';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                    'Edition' = "Enterprise"
                }
            },
            @{
                Name = 'Web-Server-02';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                    'Edition' = "Enterprise"
                }
            },
            @{
                Name = 'Web-Server-03';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Ubuntu Linux'
                    'Version' = '24'
                    'Build' = "11"
                    'Edition' = "Enterprise"
                }
            }
        )

        <#

                                _________________________________ _______________
                                |               |               |               |
                                |               |     Icon      |               |
                                |_______________|_______________|_______________|
                                |               |               |               |
                                | Web-Server-01 | Web-Server-02 | Web-Server-03 |
                                |_______________|_______________|_______________|
                                |               |               |               |
                                |   Properties  |   Properties  |   Properties  |
                                |_______________|_______________|_______________|
                                |               |               |               |
                                | Web-Server-04 | Web-Server-05 | Web-Server-06 |
                                |_______________|_______________|_______________|
                                |               |               |               |
                                |   Properties  |   Properties  |   Properties  |
                                |_______________|_______________|_______________|

            ** The $Images object and IconType "Server" must be defined earlier in the script **

            -AdditionalInfo parameter accepts a custom object with properties to display in the node label.
            -columnSize parameter sets the number of columns in the table layout.
            -inputObject parameter accepts an array of names for the nodes in the table.
            -Subgraph parameter creates a subgraph container around the table.
            -SubgraphLabel parameter sets the label for the subgraph container.
            -SubgraphLabelPos parameter sets the position of the subgraph label (top, bottom).
            -SubgraphTableStyle parameter sets the style of the subgraph border (dashed, rounded, solid).
            -TableBorderColor parameter sets the color of the table border.
            -TableBorder sets the thickness of the table border.
        #>

        $Web01Label = Add-DiaHtmlNodeTable -ImagesObj $Images -inputObject $WebServerFarm.Name -iconType "Server" -ColumnSize 3 -AditionalInfo $WebServerFarm.AdditionalInfo -Subgraph -SubgraphLabel "Web Server Farm" -SubgraphLabelPos "top" -SubgraphTableStyle "dashed,rounded" -TableBorderColor "gray" -TableBorder "1" -SubgraphLabelFontSize 20 -FontSize 18  -DraftMode:$DraftMode -FontBold


        $App01Label = Add-DiaNodeIcon -Name 'App-Server-01' -AdditionalInfo $AppServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode
        $DB01Label = Add-DiaNodeIcon -Name 'Db-Server-01' -AdditionalInfo $DBServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

        Node -Name Web01 -Attributes @{Label = $Web01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
        Node -Name App01 -Attributes @{ Label = $App01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
        Node -Name DB01 -Attributes @{Label = $DB01Label; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

        <#
            This section creates connections between the nodes in a hierarchical layout.
            The Edge statements create connections between the nodes. (Edge is a reserved word in the PSGraph module)
            https://psgraph.readthedocs.io/en/latest/Command-Edge/
        #>

        Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 14; fontcolor = 'black'; minlen = 3 }
        Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 14; fontcolor = 'black'; minlen = 3 }

        <#
            The Rank cmdlet is used to place nodes at the same hierarchical level.
            In this example, App01 and DB01 are aligned horizontally.
        #>
        Rank -Nodes App01, DB01
    }
}

<#
    This command generates the diagram using the New-Diagrammer cmdlet (part of Diagrammer.Core).
#>

New-Diagrammer -InputObject $example8 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example8 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -DraftMode:$DraftMode

