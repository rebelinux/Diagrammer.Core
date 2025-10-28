---
comments: true
hide:
  - toc
---

This time we will extend the edges size using the Graphviz minlen attribute.

The diagram below illustrates a 3-tier web application architecture. Each tier—Web, Application, and Database—is depicted as a color-coded rectangle for easy identification. Labeled connections show the communication protocols: the Web server connects to the Application server using gRPC, while the Application server communicates with the Database server via SQL.

The **`minlen`** attribute has been applied to the edges to enhance the spacing between the nodes, resulting in a clearer and more organized layout.

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

```powershell linenums="1" hl_lines="08-09" title="Example3.ps1 - Edge minlen attribute"
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

**Resulting diagram:**

!!! example

    === "Example 3"

        ```graphviz dot example3.png
            digraph Root {
                graph [bb="0,0,394,844",
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
                    graph [bb="8,8,386,836",
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
                        graph [bb="16,53.25,366,828",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.92,
                            lp="191,682.88",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        MainGraph	[height=0.05,
                            label="",
                            pos="107,511.75",
                            shape=point,
                            style=invis,
                            width=0.05];
                        "Web-Server-01"	[fillcolor=Green,
                            height=0.5,
                            label="Web-Server-01",
                            pos="241,511.75",
                            shape=rectangle,
                            width=1.3681];
                        "App-Server-01"	[fillcolor=Blue,
                            height=0.5,
                            label="App-Server-01",
                            pos="241,295.5",
                            shape=rectangle,
                            width=1.3472];
                        "Web-Server-01" -> "App-Server-01"	[color=black,
                            fontcolor=black,
                            fontsize=12,
                            label=gRPC,
                            lp="255.62,403.62",
                            minlen=3,
                            pos="s,241,493.69 e,241,313.76 241,482.98 241,453.12 241,410.75 241,410.75 241,410.75 241,362.25 241,328.18"];
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
                            lp="252.62,187.38",
                            minlen=3,
                            pos="s,241,277.44 e,241,97.512 241,266.73 241,236.87 241,194.5 241,194.5 241,194.5 241,146 241,111.93"];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="376,511.75",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```
    === "Example 3 - DraftMode"

        ```graphviz dot example3_draftmode.png
            digraph Root {
                graph [bb="0,0,394,789.5",
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
                    graph [bb="8,8,386,781.5",
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
                        graph [bb="16,53.25,366,773.5",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.16,
                            lp="191,655.62",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        MainGraph	[height=0.05,
                            label="",
                            pos="107,511.75",
                            shape=point,
                            style=invis,
                            width=0.05];
                        "Web-Server-01"	[fillcolor=Green,
                            height=0.5,
                            label="Web-Server-01",
                            pos="241,511.75",
                            shape=rectangle,
                            width=1.3681];
                        "App-Server-01"	[fillcolor=Blue,
                            height=0.5,
                            label="App-Server-01",
                            pos="241,295.5",
                            shape=rectangle,
                            width=1.3472];
                        "Web-Server-01" -> "App-Server-01"	[color=black,
                            fontcolor=black,
                            fontsize=12,
                            label=gRPC,
                            lp="255.62,403.62",
                            minlen=3,
                            pos="s,241,493.69 e,241,313.76 241,482.98 241,453.12 241,410.75 241,410.75 241,410.75 241,362.25 241,328.18"];
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
                            lp="252.62,187.38",
                            minlen=3,
                            pos="s,241,277.44 e,241,97.512 241,266.73 241,236.87 241,194.5 241,194.5 241,194.5 241,146 241,111.93"];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="376,511.75",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```