---
comments: true
---
** This time, we'll demonstrate the use of Add-DiaNodeShape cmdlet to add custom shapes to the diagram (Part of Diagrammer.Core module). **

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

In this example, we use the Add-DiaNodeShape cmdlet to add a custom rectangle shape representing a firewall in the network diagram. This cmdlet enables you to define custom shapes with flexible styles and attributes to visually enhance your diagrams.

[Supported Shapes](https://graphviz.org/doc/info/shapes.html){:target="_blank"}

```powershell
$example14 = & {
    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {

        $Signature = Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows "Author: Bugs Bunny", "Company: ACME Inc." -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -DraftMode:$DraftMode

        SubGraph Signature -Attributes @{Label = $Signature; fontsize = 22; penwidth = 1.5; labelloc = 'b'; labeljust = 'right'; style = "invis"; color = "darkgray" } {

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

            $Web01Label = Add-DiaHTMLNodeTable -ImagesObj $Images -inputObject $WebServerFarm.Name -iconType $WebServerFarm.IconType -columnSize 3 -AditionalInfo $WebServerFarm.AdditionalInfo -Subgraph -SubgraphLabel "Web Server Farm" -SubgraphLabelPos "top" -SubgraphTableStyle "dashed,rounded" -TableBorderColor "gray" -TableBorder "1" -SubgraphLabelFontsize 20 -fontSize 18 -MultiIcon -DraftMode:$DraftMode


            $App01Label = Add-DiaNodeIcon -Name 'App-Server-01' -AditionalInfo $AppServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode
            $DB01Label = Add-DiaNodeIcon -Name 'Db-Server-01' -AditionalInfo $DBServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

            Node -Name Web01 -Attributes @{Label = $Web01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
            Node -Name App01 -Attributes @{ Label = $App01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
            Node -Name DB01 -Attributes @{Label = $DB01Label; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

            Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
            Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }

            Rank -Nodes App01, DB01

            $RouterInfo = [PSCustomObject][ordered]@{
                'OS' = 'Cisco IOS'
                'Version' = '15.2'
            }

            $RouterLabel = Add-DiaNodeIcon -Name 'Core-Router' -AdditionalInfo $RouterInfo -ImagesObj $Images -IconType "Router" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

            Node -Name Router01 -Attributes @{label = $RouterLabel ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

            Edge -From Router01 -To Web01 @{label = 'GE0/0'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2 }

            Add-DiaNodeImage -Name "WAN" -ImagesObj $Images -IconType "Cloud" -IconPath $IconPath -ImageSizePercent 30 -DraftMode:$DraftMode

            Edge -From WAN -To Router01 @{label = 'Serial0/0'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2 }

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
                In this example, we create a rectangle to simulate a firewall presence in the network.

                -Shape parameter sets the shape of the node (rectangle in this case).
                -ShapeStyle parameter sets the style of the shape (filled in this case).
                -ShapeFillColor parameter sets the fill color of the shape (red:white (gradient) in this case).
                -ShapeFontSize parameter sets the font size of the shape label (14 in this case
                -ShapeFontColor parameter sets the font color of the shape label (white in this case).
                -ShapeFontName parameter sets the font name of the shape label (Arial in this case
                -ShapeWidth parameter sets the width of the shape (3 in this case).
                -ShapeLabelPosition parameter sets the position of the label within the shape (center in this case).
                -ShapeLineColor parameter sets the color of the shape's border (black in this case).
            #>

            Add-DiaNodeShape -Name "Firewall" -Shape rectangle -ShapeStyle 'filled' -ShapeFillColor 'red:white' -ShapeFontSize 14 -ShapeFontColor 'black' -ShapeFontName 'Arial' -ShapeWidth 3 -ShapeLabelPosition center -ShapeLineColor 'black' -DraftMode:$DraftMode

            # An edge is created from WAN to Firewall and from Firewall to Router01

            Edge -From WAN -To Firewall @{labeldistance = 5; headlabel = 'port1'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2; arrowhead = 'normal'; arrowtail = 'normal' }
            Edge -From Firewall -To Router01 @{labeldistance = 4; headlabel = 'Serial0/0'; taillabel = 'port2'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2; arrowhead = 'normal'; arrowtail = 'normal' }
        }
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example14 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example14 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -WaterMarkText "Confidential" -WaterMarkColor "DarkGray" -WaterMarkFontOpacity 40 -DraftMode:$DraftMode
```
When you run the script, it generates a PNG file named Example14.png in the specified output folder.

**Resulting diagram:**

```graphviz dot example14.png
digraph Root {
	graph [bb="0,0,668,2082.8",
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
		graph [bb="8,8,660,2074.8",
			color=gray,
			fontsize=24,
			label=" ",
			labeljust=r,
			labelloc=b,
			lheight=0.47,
			lp="648.62,28.875",
			lwidth=0.09,
			penwidth=1.5,
			style=invis
		];
		subgraph clusterMainGraph {
			graph [bb="16,57.75,652,2066.8",
				fontsize=24,
				label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Docs/Icons/Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,
				labeljust=c,
				labelloc=t,
				lheight=3.98,
				lp="334,1919.4",
				lwidth=5.09,
				penwidth=0
			];
			subgraph cluster3tier {
				graph [bb="24,65.75,644,1764",
					color=darkgray,
					fontsize=22,
					label="3 Tier Concept",
					labelloc=t,
					lheight=0.43,
					lp="334,1744.6",
					lwidth=2.17,
					penwidth=1.5,
					style="dashed,rounded"
				];
				subgraph clusterSignature {
					graph [bb="32,73.75,636,1717.2",
						color=darkgray,
						fontsize=22,
						label=<<TABLE STYLE="rounded,dashed" border="2" cellborder="0" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="left" colspan="1" rowspan="4"><img src="Docs/Icons/Signature_Logo.png"/></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Author: Bugs Bunny</FONT></B></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Company: ACME Inc.</FONT></B></TD></TR></TABLE>>,
						labeljust=right,
						labelloc=b,
						lheight=1.22,
						lp="510.12,121.75",
						lwidth=3.27,
						penwidth=1.5,
						style=invis
					];
					{
						graph [rank=same];
						App01	[fillcolor=transparent,
							height=3.8194,
							label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>App-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Windows Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 2019</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 17763.3163</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Datacenter</FONT></TD></TR></TABLE>>,
							pos="126,315.25",
							shape=plain,
							width=2.3924];
						DB01	[fillcolor=transparent,
							height=3.8194,
							label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
							pos="549,315.25",
							shape=plain,
							width=2.2049];
					}
					{
						graph [rank=same];
						Router01	[fillcolor=transparent,
							height=2.8194,
							label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Router.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Core-Router</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Cisco IOS</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 15.2</FONT></TD></TR></TABLE>>,
							pos="274,1186.8",
							shape=plain,
							width=1.7569];
						RouterNetworkInfo	[fillcolor=lightblue,
							height=1.4514,
							label=<<TABLE COLOR="black" STYLE="solid,rounded" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="center" colspan="2"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="14"><B>Interfaces Table</B></FONT></TD></TR><TR><TD align="center" colspan="1"><FONT POINT-SIZE="14">S0/0:</FONT></TD><TD align="center" colspan="1"><FONT POINT-SIZE="14">164.42.203.10/30</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT POINT-SIZE="14">G0/0:</FONT></TD><TD align="center" colspan="1"><FONT POINT-SIZE="14">192.168.5.10/24</FONT></TD></TR></TABLE>>,
							pos="505,1186.8",
							shape=plain,
							style="filled,rounded",
							width=2.2743];
					}
					Web01	[fillcolor=transparent,
						height=4.4306,
						label=<<TABLE COLOR="gray" STYLE="dashed,rounded" PORT="EdgeDot" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="20"><B>Web Server Farm</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_Ubuntu.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
						pos="274,794.75",
						shape=plain,
						width=6.5035];
					Web01 -> App01	[color=black,
						fontcolor=black,
						fontsize=14,
						label=gRPC,
						lp="216.12,544",
						minlen=3,
						pos="s,225.36,635.37 e,168.83,452.43 222.15,624.85 209.74,584.17 200,552.25 200,552.25 200,552.25 187.68,512.81 173.1,466.1"];
					App01 -> DB01	[color=black,
						fontcolor=black,
						fontsize=14,
						label=SQL,
						lp="340.88,326.5",
						minlen=3,
						pos="s,212.11,315.25 e,469.8,315.25 222.94,315.25 292.76,315.25 386.43,315.25 455.46,315.25"];
					Router01 -> Web01	[color=black,
						fontcolor=black,
						fontsize=18,
						label="GE0/0",
						lp="297.62,1019.8",
						minlen=2,
						pos="s,274,1085.4 e,274,954.12 274,1074.8 274,1049.6 274,1030.2 274,1030.2 274,1030.2 274,1003.8 274,968.56"];
					Router01 -> RouterNetworkInfo	[arrowhead=none,
						arrowtail=none,
						color=black,
						fontcolor=black,
						fontsize=18,
						minlen=1,
						pos="337.16,1186.8 365.9,1186.8 394.64,1186.8 423.38,1186.8",
						style=filled];
					WAN	[fillcolor=transparent,
						height=2.2639,
						label=<<TABLE border='0' color='#000000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' fixedsize='true' width='153.6' height='153.6' colspan='1'><img src='Docs/Icons/Cloud.png'/></TD></TR></TABLE>>,
						pos="274,1627.8",
						shape=plain,
						width=2.2639];
					Firewall	[color=black,
						fillcolor="red:white",
						fontcolor=black,
						fontname=Arial,
						height=0.5,
						label=Firewall,
						labelloc=c,
						orientation=0,
						penwidth=1,
						pos="274,1417.2",
						shape=rectangle,
						width=3];
					WAN -> Firewall	[arrowhead=normal,
						arrowtail=normal,
						color=black,
						fontcolor=black,
						fontsize=18,
						head_lp="295.13,1481",
						headlabel=port1,
						labeldistance=5,
						minlen=2,
						pos="s,274,1546.4 e,274,1435.7 274,1532 274,1502.6 274,1472.3 274,1450.2"];
					Firewall -> Router01	[arrowhead=normal,
						arrowtail=normal,
						color=black,
						fontcolor=black,
						fontsize=18,
						head_lp="290.9,1324.4",
						headlabel="Serial0/0",
						labeldistance=4,
						minlen=2,
						pos="s,274,1398.8 e,274,1288.2 274,1384.2 274,1362.4 274,1332.4 274,1302.4",
						tail_lp="257.1,1362.5",
						taillabel=port2];
				}
			}
		}
	}
}
```