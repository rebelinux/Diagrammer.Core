#    ** This example demonstrates how to use the Add-DiaNodeSpacer cmdlet to add spacer nodes that assist with diagram alignment. (part of Diagrammer.Core) **

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
    "Logo_Footer" = "Signature_Logo.png"
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

$example15 = & {
    <#
        A SubGraph allows you to group objects in a container, creating a graph within a graph.
        SubGraph, Node, and Edge have attributes for setting background color, label, border color, style, etc.
        (SubGraph is a reserved word in the PSGraph module)
        https://psgraph.readthedocs.io/en/latest/Command-SubGraph/
    #>

    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 22; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "darkgray" } {

        <#
            The Add-DiaHtmlSignatureTable cmdlet creates a signature table to be used as a footer in the diagram.
            It can include images, author name, company name, and other details.
            (Part of Diagrammer.Core module)
        #>

        $Signature = Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows "Author: Bugs Bunny", "Company: ACME Inc." -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -DraftMode:$DraftMode

        <#
            The Signature SubGraph contains the $Signature table created above.
            It is styled to be invisible and positioned at the bottom of the diagram.

            The SubGraph attributes set the label, font size, pen width, label location, label justification, style, and color.
            (Part of Graphviz attributes)
        #>

        SubGraph Signature -Attributes @{Label = $Signature; fontsize = 22; penwidth = 1.5; labelloc = 'b'; labeljust = 'right'; style = "invis"; color = "darkgray" } {

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

            <#
                The Add-DiaHTMLTable cmdlet is used to create a list table to display additional information about a object.

                In this example, we create a table to display the router's network interface information.
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

            <#
                The Add-DiaNodeShape cmdlet is used to create a node with a specific shape and various customizable attributes (Part of Diagrammer.Core module). Supported Shapes: https://graphviz.org/doc/info/shapes.html

                ** In this example, we create a rectangle to simulate a firewall presence in the network. **
            #>

            Add-DiaNodeShape -Name "Firewall" -Shape rectangle -ShapeStyle 'filled' -ShapeFillColor 'red:white' -ShapeFontSize 14 -ShapeFontColor 'black' -ShapeFontName 'Arial' -ShapeWidth 3 -ShapeLabelPosition center -ShapeLineColor 'black' -DraftMode:$DraftMode

            Edge -From WAN -To Firewall @{labeldistance = 5; headlabel = 'port1'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2; arrowhead = 'normal'; arrowtail = 'normal' }
            Edge -From Firewall -To Router01 @{labeldistance = 4; headlabel = 'Serial0/0'; taillabel = 'port2'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2; arrowhead = 'normal'; arrowtail = 'normal' }


            <#
                The Add-DiaNodeSpacer cmdlet is used to create invisible spacer nodes that help with diagram alignment (Part of Diagrammer.Core module).

                In this diagram there is a alignment issue with the Web01 node, as it is not centered with the App01 and DB01 nodes below it. To fix this,
                we create two spacer nodes (FillerRight and FillerLeft) on either side of the Web01 node.

                -Name parameter sets the name of the spacer node.
                -ShapeWidth parameter sets the width of the spacer node.
                -ShapeHeight parameter sets the height of the spacer node.
                -ShapeOrientation parameter sets the orientation of the spacer node (0 for horizontal, 1 for vertical).
                -DraftMode parameter specifies whether the node is in draft mode.

                The rank command is used to align the spacer nodes and the web server node horizontally.
                The edge commands create invisible edges between the spacer nodes and the web server node to maintain alignment.

                ** In this example, we create two spacer nodes to help align the web server node. **
            #>

            Add-DiaNodeSpacer -Name "SpaceRight" -ShapeWidth 2 -ShapeHeight 1 -ShapeOrientation 0 -DraftMode:$DraftMode
            Add-DiaNodeSpacer -Name "SpaceLeft" -ShapeWidth 2 -ShapeHeight 1 -ShapeOrientation 0 -DraftMode:$DraftMode

            Rank -Nodes SpaceLeft, Web01, SpaceRight

            $Style = if ($DraftMode) { 'filled' } else { 'invis' }
            $StyleColor = if ($DraftMode) { 'red' } else { 'transparent' }

            Edge -From SpaceLeft -To Web01 @{minlen = 2; style = $Style; color = $StyleColor; }
            Edge -From Web01 -To SpaceRight @{minlen = 2; style = $Style; color = $StyleColor; }
        }
    }
}
<#
    This command generates the diagram using the New-Diagrammer cmdlet (part of Diagrammer.Core).
#>

New-Diagrammer -InputObject $example15 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example15 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -DraftMode:$DraftMode