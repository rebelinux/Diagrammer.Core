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

```powershell linenums="1" hl_lines="08-09" title="Example2.ps1 - Edge cmdlet"
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

!!! example

    === "Example 2"

        ```graphviz dot example2.png
            digraph Root {
                graph [bb="0,0,394,620",
                    bgcolor=White,
                    compound=true,
                    fontcolor="#000000",
                    fontname="Segoe Ui",
                    fontsize=32,
                    imagepath="Docs/Icons",
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
                    graph [bb="8,8,386,612",
                        color=gray,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="375,26.625",
                        lwidth=0.08,
                        penwidth=1.5,
                        style=invis
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,366,604",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.92,
                            lp="191,458.88",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        MainGraph	[height=0.05,
                            label="",
                            pos="107,287.75",
                            shape=point,
                            style=invis,
                            width=0.05];
                        "Web-Server-01"	[fillcolor=Green,
                            height=0.5,
                            label="Web-Server-01",
                            pos="241,287.75",
                            shape=rectangle,
                            width=1.3681];
                        "App-Server-01"	[fillcolor=Blue,
                            height=0.5,
                            label="App-Server-01",
                            pos="241,183.5",
                            shape=rectangle,
                            width=1.3472];
                        "Web-Server-01" -> "App-Server-01"	[color=black,
                            fontcolor=black,
                            fontsize=12,
                            label=HTTP,
                            lp="256.38,235.62",
                            pos="s,241,269.4 e,241,201.93 241,258.59 241,245.41 241,229.67 241,216.09"];
                        "Db-Server-01"	[fillcolor=Red,
                            height=0.5,
                            label="Db-Server-01",
                            pos="241,79.25",
                            shape=rectangle,
                            width=1.2535];
                        "App-Server-01" -> "Db-Server-01"	[color=black,
                            fontcolor=black,
                            fontsize=12,
                            label=SQL,
                            lp="252.62,131.38",
                            pos="s,241,165.15 e,241,97.68 241,154.34 241,141.16 241,125.42 241,111.84"];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="376,287.75",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```
    === "Example 2 - DraftMode"

        ```graphviz dot example2_draftmode.png
            digraph Root {
                graph [bb="0,0,394,565.5",
                    bgcolor=White,
                    compound=true,
                    fontcolor="#000000",
                    fontname="Segoe Ui",
                    fontsize=32,
                    imagepath="Docs/Icons",
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
                    graph [bb="8,8,386,557.5",
                        color=red,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="375,26.625",
                        lwidth=0.08,
                        penwidth=1.5,
                        style=dashed
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,366,549.5",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.16,
                            lp="191,431.62",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        MainGraph	[height=0.05,
                            label="",
                            pos="107,287.75",
                            shape=point,
                            style=invis,
                            width=0.05];
                        "Web-Server-01"	[fillcolor=Green,
                            height=0.5,
                            label="Web-Server-01",
                            pos="241,287.75",
                            shape=rectangle,
                            width=1.3681];
                        "App-Server-01"	[fillcolor=Blue,
                            height=0.5,
                            label="App-Server-01",
                            pos="241,183.5",
                            shape=rectangle,
                            width=1.3472];
                        "Web-Server-01" -> "App-Server-01"	[color=black,
                            fontcolor=black,
                            fontsize=12,
                            label=HTTP,
                            lp="256.38,235.62",
                            pos="s,241,269.4 e,241,201.93 241,258.59 241,245.41 241,229.67 241,216.09"];
                        "Db-Server-01"	[fillcolor=Red,
                            height=0.5,
                            label="Db-Server-01",
                            pos="241,79.25",
                            shape=rectangle,
                            width=1.2535];
                        "App-Server-01" -> "Db-Server-01"	[color=black,
                            fontcolor=black,
                            fontsize=12,
                            label=SQL,
                            lp="252.62,131.38",
                            pos="s,241,165.15 e,241,97.68 241,154.34 241,141.16 241,125.42 241,111.84"];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="376,287.75",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```