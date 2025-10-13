#    ** This time, we'll demonstrate the use of the Add-DiaHTMLTable to add a list table to the diagram (Part of Diagrammer.Core module). **

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

$OutputFolderPath = Resolve-Path -Path $Path

<#
    If the diagram uses custom icons, specify the path to the icons directory. This is a Graphviz requirement.
#>

$RootPath = $PSScriptRoot
[System.IO.FileInfo]$IconPath = Join-Path -Path $RootPath -ChildPath 'Icons'

<#
    The $Images variable is a hashtable containing the names of image files used in the diagram.
    The image files must be located in the directory specified by $IconPath.
    ** Image sizes should be around 100x100, 150x150 pixels for optimal display. **
#>

$script:Images = @{
    "Main_Logo" = "Diagrammer.png"
    "Server" = "Server.png"
    "ServerRedhat" = "Linux_Server_RedHat.png"
    "ServerUbuntu" = "Linux_Server_Ubuntu.png"
    "Cloud" = "Cloud.png"
    "Router" = "Router.png"
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

$example11 = & {
    <#
        A SubGraph allows you to group objects in a container, creating a graph within a graph.
        SubGraph, Node, and Edge have attributes for setting background color, label, border color, style, etc.
        (SubGraph is a reserved word in the PSGraph module)
        https://psgraph.readthedocs.io/en/latest/Command-SubGraph/
    #>

    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 22; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "darkgray" } {

        <#
            The $WebServerFarm variable is an array of hashtables, each representing a web server node with its properties.
            Each hashtable contains:
            - Name: The name of the web server.
            - AdditionalInfo: A custom object with properties to display in the node label.
            - IconType: The type of icon to use for the node (must match a key in the $Images hashtable).
        #>

        $WebServerFarm = @(
            @{
                Name = 'Web-Server-01';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                    'Edition' = "Enterprise"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-02';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                    'Edition' = "Enterprise"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-03';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Ubuntu Linux'
                    'Version' = '24'
                    'Build' = "11"
                    'Edition' = "Enterprise"
                }
                IconType = "ServerUbuntu"
            }
        )

        <#
            This time, we will simulate a Web Server Farm with multiple web server node. While the Add-DiaNodeIcon cmdlet is typically used to add icons/properties to nodes, it lack the ability to create multiple nodes with distinct properties.

            Add-DiaHTMLNodeTable has the capability to create a table layout for the nodes simulting a web server farm. It also allows the addition of icons and properties to each node in the table.

            ** The $Images object and IconType "Server" must be defined earlier in the script **

            -MultiIcon parameter allows multiple icons to be displayed in the table. (IconType must be specified in the inputObject)
            -iconType parameter sets the type of icon to use for the nodes. In this case the $WebServerFarm.IconType hashtable value is used
            (must match a key in the $Images hashtable).
        #>

        $Web01Label = Add-DiaHTMLNodeTable -ImagesObj $Images -inputObject $WebServerFarm.Name -iconType $WebServerFarm.IconType -columnSize 3 -AditionalInfo $WebServerFarm.AdditionalInfo -Subgraph -SubgraphLabel "Web Server Farm" -SubgraphLabelPos "top" -SubgraphTableStyle "dashed,rounded" -TableBorderColor "gray" -TableBorder "1" -SubgraphLabelFontsize 20 -fontSize 18 -MultiIcon -DraftMode:$DraftMode


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

        <#
            In this section, we add a network router and a cloud icon to represent internet connectivity.
        #>

        $RouterInfo = [PSCustomObject][ordered]@{
            'OS' = 'Cisco IOS'
            'Version' = '15.2'
        }

        $RouterLabel = Add-DiaNodeIcon -Name 'Core-Router' -AdditionalInfo $RouterInfo -ImagesObj $Images -IconType "Router" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

        Node -Name Router01 -Attributes @{label = $RouterLabel ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

        Edge -From Router01 -To Web01 @{label = 'GE0/0'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2 }

        <#
            This section demonstrates the use of the Add-DiaNodeImage to add a custom image to the diagram (Part of Diagrammer.Core module).

            -Name parameter sets the name of the node (WAN in this case).
            -ImageSizePercent parameter sets the size of the image as a percentage (30% in this case).
        #>

        Add-DiaNodeImage -Name "WAN" -ImagesObj $Images -IconType "Cloud" -IconPath $IconPath -ImageSizePercent 30 -NodeObject -DraftMode:$DraftMode

        Edge -From WAN -To Router01 @{label = 'Serial0/0'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2 }

        <#
            The Add-DiaHTMLTable cmdlet is used to create a list table to display additional information about a object.
            -Name parameter sets the name of the node (RouterNetworkInfo in this case).
            -Rows parameter takes an array of strings to populate the table rows.
            -NodeObject switch indicates that the table is to be used as a Graphviz Node in the diagram.
                - If this parameter is omitted, the table will be created as a standalone HTML file.
                - If this parameter is omitted, a Node must be created separately and the table assigned to the node's Label attribute.
            -ColumnSize parameter sets the number of columns in the table (2 in this case).
            -Subgraph switch creates a container around the table with a label.
            -SubgraphLabel parameter sets the label for the subgraph container.
            -GraphvizAttributes parameter allows setting additional Graphviz attributes for the node container.

           ** In this example, we create a table to display the router's network interface information. **
        #>

        $RouterNetworkInfo = @(
            "S0/0:"
            "164.42.203.10/30"
            "G0/0:"
            "192.168.5.10/24"
        )

        Add-DiaHTMLTable -Name 'RouterNetworkInfo' -Rows $RouterNetworkInfo -NodeObject -ColumnSize 2 -TableBorder 1 -TableBorderColor "black" -FontSize 14 -Subgraph -SubgraphLabel "Interfaces Table" -SubgraphLabelPos "top" -SubgraphTableStyle "solid,rounded" -SubgraphLabelFontsize 20 -GraphvizAttributes @{style = 'filled,rounded'; fillcolor = 'lightblue' } -DraftMode:$DraftMode

        Edge -From Router01 -To RouterNetworkInfo @{color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 1; style = 'filled'; arrowhead = 'none'; arrowtail = 'none' }

        Rank Router01, RouterNetworkInfo
    }
}

<#
    This command generates the diagram using the New-Diagrammer cmdlet (part of Diagrammer.Core).
#>

New-Diagrammer -InputObject $example11 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example11 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -DraftMode:$DraftMode