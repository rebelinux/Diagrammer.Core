# ** This example demonstrates how to use the Add-DiaHTMLSubGraph cmdlet to simulate Graphviz SubGraphs. (part of Diagrammer.Core) **

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
    'Main_Logo' = 'Diagrammer.png'
    'Server' = 'Server.png'
    'ServerRedhat' = 'Linux_Server_RedHat.png'
    'ServerUbuntu' = 'Linux_Server_Ubuntu.png'
    'Cloud' = 'Cloud.png'
    'Router' = 'Router.png'
    'Logo_Footer' = 'Signature_Logo.png'
}

<#
    The $MainGraphLabel variable sets the main title of the diagram.
#>

$MainGraphLabel = 'Web Application Diagram'

$advancedexample01 = & {
    <#
        A SubGraph allows you to group objects in a container, creating a graph within a graph.
        SubGraph, Node, and Edge have attributes for setting background color, label, border color, style, etc.
        (SubGraph is a reserved word in the PSGraph module)
        https://psgraph.readthedocs.io/en/latest/Command-SubGraph/
    #>

    SubGraph 3tier -Attributes @{Label = 'Advanced Diagram Concepts'; fontsize = 22; penwidth = 1.5; labelloc = 't'; style = 'dashed,rounded'; color = 'darkgray' } {
        <#
            Native Graphviz SubGraph has its issues when it comes to layout and connectivity.
            For example, nodes in a SubGraph are not always aligned properly, and edges connecting nodes inside
            and outside the SubGraph can be misaligned or not connect as expected. This can lead to diagrams that
            are difficult to read and understand. Additionally, Nodes inside SubGraphs cannot be split across multiple
            rows or columns, limiting the flexibility of the layout. This can be particularly problematic when trying to create
            complex diagrams with many nodes and connections.
        #>
        SubGraph Traditional -Attributes @{Label = 'Native Graphviz SubGraph'; bgcolor = '#c1cfe5ff'; fontsize = 22; penwidth = 1.5; labelloc = 't'; style = 'dashed,rounded'; color = 'darkgray' } {
            $index = 1

            while ($index -le 6) {

                $AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = '10.1'
                }

                Add-DiaNodeIcon -Name "Web-Server-0$index" -AdditionalInfo $AdditionalInfo -ImagesObj $Images -IconType 'ServerRedhat' -Align 'Center' -FontSize 18 -DraftMode:$DraftMode -NodeObject -TableBackgroundColor '#c1cfe5ff' -CellBackgroundColor '#c1cfe5ff'

                $index++
            }
        }

        <#
            Diagrammer.Core provides a workaround using HTML-like labels to simulate SubGraphs with enhanced layout
            and connectivity options.By using HTML-like labels, we can create more complex and flexible layouts for nodes within
            a SubGraph. This allows us to better organize and present information in the diagram.Additionally, HTML-like labels provide
            more control over the appearance and formatting of the nodes, allowing for a more polished and professional look. This approach
            can help to overcome some of the limitations of traditional Graphviz SubGraphs, making it easier to create clear and effective diagrams.
        #>

        <#
            Here I create a web server farm with 6 web servers using Add-DiaHTMLNodeTable. Each server will have an icon and additional information displayed in a table format.
            The servers will be arranged in a table with **3 columns** (This can't be done with Graphviz Native SubGraph).
        #>

        $WebServerFarm = @(
            @{
                Name = 'Web-Server-01';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = '10.1'
                }
                IconType = 'ServerRedhat'
            },
            @{
                Name = 'Web-Server-02';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = '10.1'
                }
                IconType = 'ServerRedhat'
            },
            @{
                Name = 'Web-Server-03';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = '10.1'
                }
                IconType = 'ServerRedhat'
            },
            @{
                Name = 'Web-Server-04';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = '10.1'
                }
                IconType = 'ServerRedhat'
            }, @{
                Name = 'Web-Server-05';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = '10.1'
                }
                IconType = 'ServerRedhat'
            },
            @{
                Name = 'Web-Server-06';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = '10.1'
                }
                IconType = 'ServerRedhat'
            }
        )

        <#
            The Add-DiaHTMLNodeTable cmdlet creates a HTML-like table with icons and additional information for each web server.
            The -columnSize parameter is set to 3, which arranges the servers in a table with 3 columns.
            The -MultiIcon switch allows multiple icons to be displayed in the table.
            The resulting HTML-like table is then used as the label for a Node representing the web server farm.
        #>

        $WebLabel = Add-DiaHtmlNodeTable -Name 'WebLabel' -ImagesObj $Images -inputObject $WebServerFarm.Name -iconType $WebServerFarm.IconType -ColumnSize 3 -AditionalInfo $WebServerFarm.AdditionalInfo -MultiIcon -DraftMode:$DraftMode -FontSize 18 -TableBackgroundColor '#a8c3b8ff' -CellBackgroundColor '#a8c3b8ff'

        <#
            The Add-DiaHTMLSubGraph cmdlet creates a HTML-like table that simulates a SubGraph with enhanced layout and connectivity options.
            The -columnSize parameter is set to 1, which arranges the web servers in a table with 1 column.
            The resulting HTML-like table is then used as the label for a Node representing the web server farm.
            The -NodeObject switch is used to create a Node with the HTML-like table as its label.
        #>

        Add-DiaHtmlSubGraph -Name 'USA-WebServers' -ImagesObj $Images -TableArray $WebLabel -Align 'Center' -Label 'Diagrammer SubGraph' -LabelPos 'top' -TableStyle 'dashed,rounded' -TableBorderColor 'darkgray' -TableBorder '1' -ColumnSize 1 -FontSize 22 -DraftMode:$DraftMode -TableBackgroundColor '#a8c3b8ff' -IconType 'Server' -NodeObject

    }
}
<#
    This command generates the diagram using the New-Diagrammer cmdlet (part of Diagrammer.Core).
#>

New-Diagrammer -InputObject $advancedexample01 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename AdvancedExample01 -LogoName 'Main_Logo' -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -DraftMode:$DraftMode