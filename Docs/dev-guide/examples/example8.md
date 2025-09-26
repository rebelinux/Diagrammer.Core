---
comments: true
---
** This time, we'll demonstrate the use of the Add-DiaHTMLNodeTable cmdlet (Part of Diagrammer.Core module). **

This is a simple example demonstrating how to create a 3-tier web application diagram using the PSGraph module, without using any object icons.

```powershell title="PowerShell: param block"
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
$MainGraphLabel = '3tier Web Application Diagram'
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

This time, we will simulate a Web Server Farm with multiple web server node. While the **`Add-DiaNodeIcon`** cmdlet is typically used to add icons/properties to nodes, it lack the ability to create multiple nodes with distinct properties.

**`Add-DiaHTMLNodeTable`** has the capability to create a table layout for the nodes simulting a web server farm. It also allows the addition of icons and properties to each node in the table.

** The $Images object and IconType "Server" must be defined earlier in the script **

In this example, Web-Server-01, Web-Server-02, and Web-Server-03 are part of the web server farm. Each server has its own properties defined in the AdditionalInfo parameter ($WebServerFarm).

```powershell
$example8 = & {
    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {

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
            -AdditionalInfo parameter accepts a custom object with properties to display in the node label.
            -columnSize parameter sets the number of columns in the table layout.
            -inputObject parameter accepts an array of names for the nodes in the table.
            -Subgraph parameter creates a subgraph container around the table.
            -SubgraphLabel parameter sets the label for the subgraph container.
            -SubgraphLabelPos parameter sets the position of the subgraph label (top, bottom).
            -SubgraphTableStyle parameter sets the style of the subgraph border (dashed, rounded, solid).
            -TableBorderColor parameter sets the color of the table border.
            -TableBorder sets the thickness of the table border.
            -iconType parameter sets the type of icon to use for the nodes. In this case the $WebServerFarm.IconType hashtable value is used
            (must match a key in the $Images hashtable).
        #>

        $Web01Label = Add-DiaHTMLNodeTable -ImagesObj $Images -inputObject $WebServerFarm.Name -iconType "Server" -columnSize 3 -AditionalInfo $WebServerFarm.AdditionalInfo -Subgraph -SubgraphLabel "Web Server Farm" -SubgraphLabelPos "top" -SubgraphTableStyle "dashed,rounded" -TableBorderColor "gray" -TableBorder "1" -SubgraphLabelFontsize 20 -fontSize 18  -DraftMode:$DraftMode


        $App01Label = Add-DiaNodeIcon -Name 'App-Server-01' -AditionalInfo $AppServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode
        $DB01Label = Add-DiaNodeIcon -Name 'Db-Server-01' -AditionalInfo $DBServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

        Node -Name Web01 -Attributes @{Label = $Web01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
        Node -Name App01 -Attributes @{ Label = $App01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
        Node -Name DB01 -Attributes @{Label = $DB01Label; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

        Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
        Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }

        # The Rank cmdlet (part of PSGraph module) forces nodes to be on the same level (same rank).
        Rank -Nodes App01, DB01
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example8 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example8 -LogoName "Main_Logo"  -DraftMode:$DraftMode
```

When you run the script, it generates a PNG file named Example8.png in the specified output folder.

### Resulting GraphViz Source Code:

```graphviz dot example8.png
digraph Root {
	graph [bb="0,0,652,1215.8",
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
		graph [bb="8,8,644,1207.8",
			color=gray,
			fontsize=24,
			label=" ",
			labeljust=r,
			labelloc=b,
			lheight=0.47,
			lp="632.62,28.875",
			lwidth=0.09,
			penwidth=1.5,
			style=invis
		];
		subgraph clusterMainGraph {
			graph [bb="16,57.75,636,1199.8",
				fontsize=24,
				label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Docs/Icons/Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,
				labeljust=c,
				labelloc=t,
				lheight=3.98,
				lp="326,1052.4",
				lwidth=5.09,
				penwidth=0
			];
			subgraph cluster3tier {
				graph [bb="24,65.75,628,897",
					color=darkgray,
					fontsize=22,
					label="3 Tier Concept",
					labelloc=t,
					lheight=0.43,
					lp="326,877.62",
					lwidth=2.17,
					penwidth=1.5,
					style="dashed,rounded"
				];
				{
					graph [rank=same];
					App01	[fillcolor=transparent,
						height=3.8194,
						label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>App-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Windows Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 2019</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 17763.3163</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Datacenter</FONT></TD></TR></TABLE>>,
						pos="118,211.25",
						shape=plain,
						width=2.3924];
					DB01	[fillcolor=transparent,
						height=3.8194,
						label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
						pos="541,211.25",
						shape=plain,
						width=2.2049];
				}
				Web01	[fillcolor=transparent,
					height=4.4306,
					label=<<TABLE COLOR="gray" STYLE="dashed,rounded" PORT="EdgeDot" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="20"><B>Web Server Farm</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="3"><img src="Docs/Icons/Server.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
					pos="266,690.75",
					shape=plain,
					width=6.5035];
				Web01 -> App01	[color=black,
					fontcolor=black,
					fontsize=14,
					label=gRPC,
					lp="208.12,440",
					minlen=3,
					pos="s,217.36,531.37 e,160.83,348.43 214.15,520.85 201.74,480.17 192,448.25 192,448.25 192,448.25 179.68,408.81 165.1,362.1"];
				App01 -> DB01	[color=black,
					fontcolor=black,
					fontsize=14,
					label=SQL,
					lp="332.88,222.5",
					minlen=3,
					pos="s,204.11,211.25 e,461.8,211.25 214.94,211.25 284.76,211.25 378.43,211.25 447.46,211.25"];
			}
		}
	}
}
```