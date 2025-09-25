---
comments: true
---
** In this example, servers are grouped in a cluster (SubGraph). **

This is a simple example demonstrating how to create a 3-tier web application diagram using the PSGraph module, without using any object icons.

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
$MainGraphLabel = '3tier Web Application Diagram'
```

This section introduces the Subgraph feature, which allows grouping nodes together. In this example, all servers are grouped within a cluster named "3tier".

A SubGraph groups objects in a container, like a graph within a graph. SubGraph attributes allow you to set background color, label, border color, style, etc.

[https://psgraph.readthedocs.io/en/latest/Command-SubGraph/](https://psgraph.readthedocs.io/en/latest/Command-SubGraph/){:target="_blank"}

```powershell
$example4 = & {
    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {

        Node -Name Web01 -Attributes @{shape = 'rectangle'; fillColor = 'Green'; fontsize = 14 }
        Node -Name App01 -Attributes @{shape = 'rectangle'; fillColor = 'Blue'; fontsize = 14 }
        Node -Name DB01 -Attributes @{shape = 'rectangle'; fillColor = 'Red'; fontsize = 14 }

        Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
        Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example4 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example4 -LogoName "Main_Logo"  -DraftMode:$DraftMode
```

When you run the script, it generates a PNG file named Example4.png in the specified output folder.

### Resulting GraphViz Source Code:

```graphviz dot example4.png
digraph Root {
	graph [bb="0,0,414,901.75",
		bgcolor=White,
		compound=true,
		fontcolor="#565656",
		fontname="Segoe Ui Black",
		fontsize=32,
		imagepath="C:\Users\jocolon\Documents\WindowsPowerShell\Modules\Diagrammer.Core\icons",
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
		graph [bb="8,8,406,893.75",
			color=gray,
			fontsize=24,
			label=" ",
			labeljust=r,
			labelloc=b,
			lheight=0.47,
			lp="394.62,28.875",
			lwidth=0.09,
			penwidth=1.5,
			style=invis
		];
		subgraph clusterMainGraph {
			graph [bb="16,57.75,398,885.75",
				fontsize=24,
				label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,
				labeljust=c,
				labelloc=t,
				lheight=3.98,
				lp="207,738.38",
				lwidth=5.09,
				penwidth=0
			];
			subgraph cluster3tier {
				graph [bb="136,65.75,278,583",
					color=gray,
					fontsize=18,
					label="3 Tier Concept",
					labelloc=t,
					lheight=0.34,
					lp="207,566.62",
					lwidth=1.75,
					penwidth=1.5,
					style="dashed,rounded"
				];
				Web01	[fillcolor=Green,
					height=0.5,
					label=Web01,
					pos="214,524.25",
					shape=rectangle,
					width=0.75347];
				App01	[fillcolor=Blue,
					height=0.5,
					label=App01,
					pos="214,308",
					shape=rectangle,
					width=0.75];
				Web01 -> App01	[color=black,
					fontcolor=black,
					fontsize=12,
					label=gRPC,
					lp="228.62,416.12",
					minlen=3,
					pos="s,214,506.19 e,214,326.26 214,495.48 214,465.62 214,423.25 214,423.25 214,423.25 214,374.75 214,340.68"];
				DB01	[fillcolor=Red,
					height=0.5,
					label=DB01,
					pos="214,91.75",
					shape=rectangle,
					width=0.75];
				App01 -> DB01	[color=black,
					fontcolor=black,
					fontsize=12,
					label=SQL,
					lp="225.62,199.88",
					minlen=3,
					pos="s,214,289.94 e,214,110.01 214,279.23 214,249.37 214,207 214,207 214,207 214,158.5 214,124.43"];
			}
		}
	}
}
```