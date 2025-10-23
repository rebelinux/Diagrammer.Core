---
comments: true
hide:
  - toc
---

In this example, servers are grouped in a cluster (SubGraph).

The **`SubGraph`** (part of PSGraph module) feature groups the three servers into a dashed rounded rectangle labeled "3 Tier Concept," visually encapsulating the Web, Application, and Database servers along with their connections.

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

This section introduces the Subgraph feature, which allows grouping nodes together. In this example, all servers are grouped within a cluster named "3tier".

A SubGraph groups objects in a container, like a graph within a graph. SubGraph attributes allow you to set background color, label, border color, style, etc.

[https://psgraph.readthedocs.io/en/latest/Command-SubGraph/](https://psgraph.readthedocs.io/en/latest/Command-SubGraph/){:target="_blank"}

```powershell linenums="1" hl_lines="02" title="Example4.ps1 - SubGraph cmdlet"
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

**Resulting diagram:**

!!! example

    === "Example 4"

        ```graphviz dot example4.png
            digraph Root {
                graph [bb="0,0,394,890.5",
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
                    graph [bb="8,8,386,882.5",
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
                        graph [bb="16,53.25,366,874.5",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.92,
                            lp="191,729.38",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="77,61.25,238,576.25",
                                color=gray,
                                fontsize=18,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.31,
                                lp="157.5,561",
                                lwidth=1.74,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            "3tier"	[height=0.05,
                                label="",
                                pos="87,519.75",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "Web-Server-01"	[fillcolor=Green,
                                height=0.5,
                                label="Web-Server-01",
                                pos="181,519.75",
                                shape=rectangle,
                                width=1.3681];
                            "App-Server-01"	[fillcolor=Blue,
                                height=0.5,
                                label="App-Server-01",
                                pos="181,303.5",
                                shape=rectangle,
                                width=1.3472];
                            "Web-Server-01" -> "App-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=gRPC,
                                lp="195.62,411.62",
                                minlen=3,
                                pos="s,181,501.69 e,181,321.76 181,490.98 181,461.12 181,418.75 181,418.75 181,418.75 181,370.25 181,336.18"];
                            "Db-Server-01"	[fillcolor=Red,
                                height=0.5,
                                label="Db-Server-01",
                                pos="181,87.25",
                                shape=rectangle,
                                width=1.2535];
                            "App-Server-01" -> "Db-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=SQL,
                                lp="192.62,195.38",
                                minlen=3,
                                pos="s,181,285.44 e,181,105.51 181,274.73 181,244.87 181,202.5 181,202.5 181,202.5 181,154 181,119.93"];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="302,519.75",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="376,519.75",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```
    === "Example 4 - Draft Mode"

        ```graphviz dot example4_draftmode.png
            digraph Root {
                graph [bb="0,0,394,836",
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
                    graph [bb="8,8,386,828",
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
                        graph [bb="16,53.25,366,820",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.16,
                            lp="191,702.12",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="77,61.25,238,576.25",
                                color=gray,
                                fontsize=18,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.31,
                                lp="157.5,561",
                                lwidth=1.74,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            "3tier"	[height=0.05,
                                label="",
                                pos="87,519.75",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "Web-Server-01"	[fillcolor=Green,
                                height=0.5,
                                label="Web-Server-01",
                                pos="181,519.75",
                                shape=rectangle,
                                width=1.3681];
                            "App-Server-01"	[fillcolor=Blue,
                                height=0.5,
                                label="App-Server-01",
                                pos="181,303.5",
                                shape=rectangle,
                                width=1.3472];
                            "Web-Server-01" -> "App-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=gRPC,
                                lp="195.62,411.62",
                                minlen=3,
                                pos="s,181,501.69 e,181,321.76 181,490.98 181,461.12 181,418.75 181,418.75 181,418.75 181,370.25 181,336.18"];
                            "Db-Server-01"	[fillcolor=Red,
                                height=0.5,
                                label="Db-Server-01",
                                pos="181,87.25",
                                shape=rectangle,
                                width=1.2535];
                            "App-Server-01" -> "Db-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=SQL,
                                lp="192.62,195.38",
                                minlen=3,
                                pos="s,181,285.44 e,181,105.51 181,274.73 181,244.87 181,202.5 181,202.5 181,202.5 181,154 181,119.93"];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="302,519.75",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="376,519.75",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```