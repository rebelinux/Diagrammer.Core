## Dependencies

Diagrammer.Core relies on the following dependencies to PSGraph to facilitate diagram generation and rendering.

- **PSGraph**: A PowerShell module for creating and rendering GraphViz diagrams.
- **GraphViz**: An open-source graph visualization software that provides the necessary tools to render diagrams defined in the DOT language.

These dependencies are essential for the module's functionality and performance. PSGraph is a helper module implemented as a DSL (Domain Specific Language) for generating GraphViz graphs. The goal is to make it easier to generate graphs using Powershell. The DSL adds these commands that are explained below.

- **graph**: Defines the overall graph structure and properties.
- **edge**: Represents a connection between two nodes in the graph.
- **node**: Represents an individual element or point in the graph.
- **subgraph**: Groups related nodes and edges within a larger graph.
- **rank**: Specifies the vertical positioning of nodes within the graph.

### Example Usage of PSGraph Commands

```powershell
Graph g {
    Node Web @{shape='oval'}
    Mode App @{shape='oval'}
    Mode DB @{shape='oval'}
    Edge Web,App @{label='HTTP'}
    Edge App,DB @{label='SQL'}
}
```

The PSGraph commands above define a simple graph with three nodes (Web, App, DB) and two edges (Web to App with label "HTTP" and App to DB with label "SQL"). Each node is styled as an oval. The resulting code is passed to GraphViz dot.exe command that translates the PSGraph DSL into the DOT language, which is then used to generate a visual representation of the graph. Finally, the graph is rendered into an image format such as PNG, SVG etc...

### Resulting GraphViz Source Code

```dot
digraph g {
    compound="true";
    "Web" [shape="oval";]
    "App" [shape="oval";]
    "DB" [shape="oval";]
    "Web"->"App" [label="HTTP";]
    "App"->"DB" [label="SQL";]
}
```

Until now, the example has been using PSGraph to generate the diagrams. However, to enhance the diagram rendering capabilities, Diagrammer.Core defines a bundle of custom commands that extend the PSGraph DSL. These commands are designed to simplify the creation of complex diagrams and improve the overall user experience.

As an example, Diagrammer.Core introduces the `Add-DiaNodeIcon` command, which allows users to easily add icons to nodes in the diagram. This command abstracts the complexity of manually specifying icon properties and provides a straightforward way to enhance the visual appeal of the diagrams.


```powershell

$WebServerInfo = [PSCustomObject][ordered]@{
    'OS' = 'Redhat Linux'
    'Version' = '10'
    'Build' = "10.1"
    'Edition' = "Enterprise"
}

$AppServerInfo = [PSCustomObject][ordered]@{
    'OS' = 'Windows Server'
    'Version' = '2019'
    'Build' = "17763.3163"
}

$DBServerInfo = [PSCustomObject][ordered]@{
    'OS' = 'Oracle Server'
    'Version' = '8'
    'Build' = "8.2"
    'Edition' = "Enterprise"
}

$Web01Label = Add-DiaNodeIcon -Name 'Web-Server-01' -AditionalInfo $WebServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18
$App01Label = Add-DiaNodeIcon -Name 'App-Server-01' -AditionalInfo $AppServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18
$DB01Label = Add-DiaNodeIcon -Name 'Db-Server-01' -AditionalInfo $DBServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18

graph g {
    Node -Name Web01 -Attributes @{Label = $Web01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
    Node -Name App01 -Attributes @{ Label = $App01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
    Node -Name DB01 -Attributes @{Label = $DB01Label; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
    Edge Web,App @{label='HTTP'}
    Edge App,DB @{label='SQL'}
}
```

```dot
digraph Root {
	graph [bb="0,0,414,1618.8",
		bgcolor=White,
		compound=true,
		fontcolor="#565656",
		fontname="Segoe Ui Black",
		fontsize=32,
		imagepath="icons",
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
    subgraph cluster3tier {
        graph [bb="113,65.75,301,1300",
            color=gray,
            fontsize=18,
            label="3 Tier Concept",
            labelloc=t,
            lheight=0.34,
            lp="207,1283.6",
            lwidth=1.75,
            penwidth=1.5,
            style="dashed,rounded"
        ];
        Web01	[fillcolor=transparent,
            height=3.8194,
            label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
            pos="207,1121.8",
            shape=plain,
            width=2.2049];
        App01	[fillcolor=transparent,
            height=3.8194,
            label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>App-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Windows Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 2019</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 17763.3163</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Datacenter</FONT></TD></TR></TABLE>>,
            pos="207,666.5",
            shape=plain,
            width=2.3924];
        Web01 -> App01	[color=black,
            fontcolor=black,
            fontsize=12,
            label=gRPC,
            lp="221.62,894.12",
            minlen=3,
            pos="s,207,984.3 e,207,803.73 207,973.44 207,933.56 207,901.25 207,901.25 207,901.25 207,863.35 207,818.01"];
        DB01	[fillcolor=transparent,
            height=3.8194,
            label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
            pos="207,211.25",
            shape=plain,
            width=2.2049];
        App01 -> DB01	[color=black,
            fontcolor=black,
            fontsize=12,
            label=SQL,
            lp="218.62,438.88",
            minlen=3,
            pos="s,207,529.05 e,207,348.48 207,518.19 207,478.31 207,446 207,446 207,446 207,408.1 207,362.76"];
    }
}
```