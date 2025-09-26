---
comments: true
---

This time we will extend the edges size using the Graphviz minlen attribute.

The diagram below illustrates a 3-tier web application architecture. Each tier—Web, Application, and Database—is depicted as a color-coded rectangle for easy identification. Labeled connections show the communication protocols: the Web server connects to the Application server using gRPC, while the Application server communicates with the Database server via SQL. The minlen attribute has been applied to the edges to enhance the spacing between the nodes, resulting in a clearer and more organized layout.

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

This section creates connections between the nodes in a herarchical layout.
The Edge statements create connections between the nodes.

The minlen attribute is used to increase the minimum length of the edge lines.

[https://graphviz.org/docs/attrs/minlen/](https://graphviz.org/docs/attrs/minlen/){:target="_blank"}

```powershell
$example3 = & {
    Node -Name Web01 -Attributes @{Label = 'Web01'; shape = 'rectangle'; fillColor = 'Green'; fontsize = 14 }
    Node -Name App01 -Attributes @{Label = 'App01'; shape = 'rectangle'; fillColor = 'Blue'; fontsize = 14 }
    Node -Name DB01 -Attributes @{Label = 'DB01'; shape = 'rectangle'; fillColor = 'Red'; fontsize = 14 }

    # This section creates connections between the nodes in a hierarchical layout.

    Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
    Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
}
```
Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example3 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example3 -LogoName "Main_Logo"  -DraftMode:$DraftMode
```

When you run the script, it generates a PNG file named Example3.png in the specified output folder.

### Resulting diagram:

```graphviz dot example3.png
digraph Root {
	graph [bb="0,0,414,853",
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
		graph [bb="8,8,406,845",
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
			graph [bb="16,57.75,398,837",
				fontsize=24,
				label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,
				labeljust=c,
				labelloc=t,
				lheight=3.98,
				lp="207,689.62",
				lwidth=5.09,
				penwidth=0
			];
			Web01	[fillcolor=Green,
				height=0.5,
				label=Web01,
				pos="214,516.25",
				shape=rectangle,
				width=0.75347];
			App01	[fillcolor=Blue,
				height=0.5,
				label=App01,
				pos="214,300",
				shape=rectangle,
				width=0.75];
			Web01 -> App01	[color=black,
				fontcolor=black,
				fontsize=12,
				label=gRPC,
				lp="228.62,408.12",
				minlen=3,
				pos="s,214,498.19 e,214,318.26 214,487.48 214,457.62 214,415.25 214,415.25 214,415.25 214,366.75 214,332.68"];
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
				lp="225.62,191.88",
				minlen=3,
				pos="s,214,281.94 e,214,102.01 214,271.23 214,241.37 214,199 214,199 214,199 214,150.5 214,116.43"];
		}
	}
}
```