---
comments: true
hide:
  - toc
---
This example demonstrates how to use the Add-DiaHTMLSubGraph cmdlet to simulate Graphviz SubGraphs (part of Diagrammer.Core).

The diagram below visually compares a traditional Graphviz SubGraph with a Diagrammer.Core HTML-like SubGraph, highlighting the enhanced layout and connectivity options available in Diagrammer.Core.


```powershell title="PowerShell: Example1.ps1 - param block"
[CmdletBinding()]
param (
    [System.IO.FileInfo] $Path = '~\Desktop\',
    [array] $Format = @('png'),
    [bool] $DraftMode = $false
)
```

Starting with PowerShell v3, modules are auto-imported when needed. Importing the module here ensures clarity and avoids ambiguity.


```powershell
Import-Module Diagrammer.Core -Force -Verbose:$false
```
Since the diagram output is a file, specify the output folder path using $OutputFolderPath.

```powershell
$OutputFolderPath = Resolve-Path $Path
```

The $MainGraphLabel variable sets the main title of the diagram.

```powershell
$MainGraphLabel = 'Web Application Diagram'
```

If the diagram uses custom icons, specify the path to the icons directory. This is a Graphviz requirement.

```powershell
$RootPath = $PSScriptRoot
[System.IO.FileInfo]$IconPath = Join-Path $RootPath 'icons'
```
The $Images variable is a hashtable containing the names of image files used in the diagram.The image files must be located in the directory specified by $IconPath.

** Image sizes should be around 100x100, 150x150 pixels for optimal display. **

```powershell
$script:Images = @{
    "Main_Logo" = "Diagrammer.png"
    "Server" = "Server.png"
    "ServerRedhat" = "Linux_Server_RedHat.png"
    "ServerUbuntu" = "Linux_Server_Ubuntu.png"
    "Cloud" = "Cloud.png"
    "Router" = "Router.png"
    "Logo_Footer" = "Signature_Logo.png"
}
```

This section creates custom objects to hold server information, which are used to set node labels in the diagram.

```powershell
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
```

Native Graphviz SubGraph has its issues when it comes to layout and connectivity. For example, nodes in a SubGraph are not always aligned properly, and edges connecting nodes inside and outside the SubGraph can be misaligned or not connect as expected. This can lead to diagrams that are difficult to read and understand.

Additionally, Nodes inside SubGraphs cannot be split across multiple rows or columns, limiting the flexibility of the layout. This can be particularly problematic when trying to create complex diagrams with many nodes and connections.

Diagrammer.Core provides a workaround using HTML-like labels to simulate SubGraphs with enhanced layout and connectivity options.By using HTML-like labels, we can create more complex and flexible layouts for nodes within
a SubGraph. This allows us to better organize and present information in the diagram.Additionally, HTML-like labels provide more control over the appearance and formatting of the nodes, allowing for a more polished and professional look. This approach can help to overcome some of the limitations of traditional Graphviz SubGraphs, making it easier to create clear and effective diagrams.

```powershell
$advancedexample01 = & {

    SubGraph 3tier -Attributes @{Label = 'Advanced Diagram Concepts'; fontsize = 22; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "darkgray" } {

        # Here I create a web server farm with 6 web servers using a traditional Graphviz SubGraph.
        SubGraph Traditional -Attributes @{Label = 'Native Graphviz SubGraph'; bgcolor = '#c1cfe5ff'; fontsize = 22; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "darkgray" } {
            $index = 1

            while ($index -le 6) {

                $AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }

                $WebLabel = Add-DiaNodeIcon -Name "Web-Server-0$index" -AdditionalInfo $AdditionalInfo -ImagesObj $Images -IconType "ServerRedhat" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

                Node -Name "UK-WebServer-0$index" -Attributes @{Label = $WebLabel ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

                $index++
            }
        }

        <#
            Here I create a web server farm with 6 web servers using Add-DiaHTMLNodeTable.
            Each server will have an icon and additional information displayed in a table format.
            The servers will be arranged in a table with **3 columns** (This can't be done with Graphviz Native SubGraph).
        #>

        $WebServerFarm = @(
            @{
                Name = 'Web-Server-01';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-02';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-03';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-04';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            }, @{
                Name = 'Web-Server-05';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-06';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            }
        )

        <#
            The Add-DiaHTMLNodeTable cmdlet creates a HTML-like table with icons and additional information for each web server.
            The -columnSize parameter is set to 3, which arranges the servers in a table with 3 columns.
            The -MultiIcon switch allows multiple icons to be displayed in the table.
            The resulting HTML-like table is then used as the label for a Node representing the web server farm.
        #>

        $WebLabel = Add-DiaHTMLNodeTable -ImagesObj $Images -inputObject $WebServerFarm.Name -iconType $WebServerFarm.IconType -columnSize 3 -AditionalInfo $WebServerFarm.AdditionalInfo -MultiIcon -DraftMode:$DraftMode -fontSize 18

        <#
            The Add-DiaHTMLSubGraph cmdlet creates a HTML-like table that simulates a SubGraph with enhanced layout and connectivity options.
            The -columnSize parameter is set to 1, which arranges the web servers in a table with 1 column.
            The resulting HTML-like table is then used as the label for a Node representing the web server farm.
        #>

        $WebNodeObj = Add-DiaHTMLSubGraph -ImagesObj $Images -TableArray $WebLabel -Align 'Center' -Label 'Diagrammer SubGraph' -LabelPos "top" -TableStyle "dashed,rounded" -TableBorderColor "darkgray" -TableBorder "1" -columnSize 1 -fontSize 22 -DraftMode:$DraftMode -TableBackgroundColor '#a8c3b8ff' -IconType "Server"

        <#
            Finally, create a Node for the web server farm using the HTML-like SubGraph as the label.
            The node is styled with a transparent background and a font size of 14.
        #>

        Node -Name "USA-WebServers" -Attributes @{Label = $WebNodeObj ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14; }
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $advancedexample01 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename AdvancedExample01 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -DraftMode:$DraftMode
```
When you run the script, it generates a PNG file named Example15.png in the specified output folder.

### Resulting diagram:

```graphviz dot example15.png
digraph Root {
	graph [bb="0,0,1710,1024.2",
		bgcolor=White,
		compound=true,
		fontcolor="#565656",
		fontname="Segoe Ui Black",
		fontsize=32,
		labelloc=t,
		nodesep=0.6,
		pad=1,
		penwidth=1.5,
		rankdir=TB,
		ranksep=0.75,
		splines=line,
		style=dashed
	];
	node [fillcolor="#71797E",
		fontcolor=Black,
		fontsize=14,
		imagescale=True,
		label="\N",
		labelloc=t,
		shape=none,
		style=filled
	];
	edge [arrowsize=1,
		arrowtail=dot,
		color="#71797E",
		dir=both,
		fontcolor="#71797E",
		penwidth=3,
		style=dashed
	];
	subgraph clusterOUTERDRAWBOARD1 {
		graph [bb="8,8,1702,1016.2",
			color=gray,
			fontsize=24,
			label=" ",
			labeljust=r,
			labelloc=b,
			lheight=0.47,
			lp="1690.6,28.875",
			lwidth=0.09,
			penwidth=1.5,
			style=invis
		];
		subgraph clusterMainGraph {
			graph [bb="16,57.75,1694,1008.2",
				fontsize=24,
				label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Docs/Icons/Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,
				labeljust=c,
				labelloc=t,
				lheight=3.98,
				lp="855,860.88",
				lwidth=5.09,
				penwidth=0
			];
			subgraph cluster3tier {
				graph [bb="24,65.75,1686,705.5",
					color=darkgray,
					fontsize=22,
					label="Advanced Diagram Concepts",
					labelloc=t,
					lheight=0.43,
					lp="855,686.12",
					lwidth=4.29,
					penwidth=1.5,
					style="dashed,rounded"
				];
				subgraph clusterTraditional {
					graph [bb="32,238.75,1175,532.5",
						bgcolor="#c1cfe5ff",
						color=darkgray,
						fontsize=22,
						label="Native Graphviz SubGraph",
						labelloc=t,
						lheight=0.43,
						lp="603.5,513.12",
						lwidth=3.95,
						penwidth=1.5,
						style="dashed,rounded"
					];
					"UK-WebServer-01"	[fillcolor=transparent,
						height=3.3194,
						label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
						pos="116,366.25",
						shape=plain,
						width=2.1111];
					"UK-WebServer-02"	[fillcolor=transparent,
						height=3.3194,
						label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-02</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
						pos="311,366.25",
						shape=plain,
						width=2.1111];
					"UK-WebServer-03"	[fillcolor=transparent,
						height=3.3194,
						label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-03</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
						pos="506,366.25",
						shape=plain,
						width=2.1111];
					"UK-WebServer-04"	[fillcolor=transparent,
						height=3.3194,
						label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-04</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
						pos="701,366.25",
						shape=plain,
						width=2.1111];
					"UK-WebServer-05"	[fillcolor=transparent,
						height=3.3194,
						label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-05</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
						pos="896,366.25",
						shape=plain,
						width=2.1111];
					"UK-WebServer-06"	[fillcolor=transparent,
						height=3.3194,
						label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-06</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
						pos="1091,366.25",
						shape=plain,
						width=2.1111];
				}
				"USA-WebServers"	[fillcolor=transparent,
					height=8.125,
					label=<<TABLE BGColor="#a8c3b8ff" COLOR="darkgray" STYLE="dashed,rounded" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD valign="BOTTOM" ALIGN="Center" colspan="1" fixedsize="true" width="40" height="40"><IMG src="Docs/Icons/Server.png"></IMG></TD></TR><TR><TD valign="TOP" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="22"><B>Diagrammer SubGraph</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="22"><TABLE COLOR="#000000" PORT="EdgeDot" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD></TR><TR><TD PORT="Web-Server-04" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-04</B></FONT></TD><TD PORT="Web-Server-05" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-05</B></FONT></TD><TD PORT="Web-Server-06" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-06</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE></FONT></TD></TR></TABLE>>,
					pos="1444,366.25",
					shape=plain,
					width=6.5];
			}
		}
	}
}
```