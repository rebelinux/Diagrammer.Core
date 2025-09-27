---
comments: true
hide:
  - toc
---

This time we will connect the nodes to show relationships.

The diagram below visualizes a 3-tier web application architecture. Each tier—Web, Application, and Database—is represented by a distinct color-coded rectangle for clarity. Connections between the tiers are labeled to indicate the communication protocols: the Web server communicates with the Application server via gRPC, and the Application server interacts with the Database server using SQL.

The **`Edge`** statements create connections between the nodes, illustrating the flow of data and interactions within the architecture.

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

This section creates connections between the nodes in a herarchical layout.
The Edge statements create connections between the nodes.

Edge is a reserved word in PSGraph module:

[https://psgraph.readthedocs.io/en/latest/Command-Edge/](https://psgraph.readthedocs.io/en/latest/Command-Edge/){:target="_blank"}

```powershell
$example2 = & {
    Node -Name Web01 -Attributes @{Label = 'Web01'; shape = 'rectangle'; fillColor = 'Green'; fontsize = 14 }
    Node -Name App01 -Attributes @{Label = 'App01'; shape = 'rectangle'; fillColor = 'Blue'; fontsize = 14 }
    Node -Name DB01 -Attributes @{Label = 'DB01'; shape = 'rectangle'; fillColor = 'Red'; fontsize = 14 }

    # This section creates connections between the nodes in a hierarchical layout.

    Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 12; fontcolor = 'black' }
    Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 12; fontcolor = 'black' }
}
```
Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example2 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example2 -LogoName "Main_Logo"  -DraftMode:$DraftMode
```

When you run the script, it generates a PNG file named Example2.png in the specified output folder.

**Resulting diagram:**

```graphviz dot example2.png
digraph Root {
	graph [bb="0,0,414,629",
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
		graph [bb="8,8,406,621",
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
			graph [bb="16,57.75,398,613",
				fontsize=24,
				label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,
				labeljust=c,
				labelloc=t,
				lheight=3.98,
				lp="207,465.62",
				lwidth=5.09,
				penwidth=0
			];
			Web01	[fillcolor=Green,
				height=0.5,
				label=Web01,
				pos="214,292.25",
				shape=rectangle,
				width=0.75347];
			App01	[fillcolor=Blue,
				height=0.5,
				label=App01,
				pos="214,188",
				shape=rectangle,
				width=0.75];
			Web01 -> App01	[color=black,
				fontcolor=black,
				fontsize=12,
				label=gRPC,
				lp="228.62,240.12",
				pos="s,214,273.9 e,214,206.43 214,263.09 214,249.91 214,234.17 214,220.59"];
			DB01	[fillcolor=Red,
				height=0.5,
				label=DB01,
				pos="214,83.75",
				shape=rectangle,
				width=0.75];
			App01 -> DB01	[color=black,
				fontcolor=black,
				fontsize=12,
				label=SQL,
				lp="225.62,135.88",
				pos="s,214,169.65 e,214,102.18 214,158.84 214,145.66 214,129.92 214,116.34"];
		}
	}
}
```