---
comments: true
hide:
  - toc
---
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

This block creates a diagram with three servers, each represented by a custom node label and shape (without object icons).

```powershell linenums="1" hl_lines="06-08" title="Example1.ps1 - Node cmdlet"
$example1 = & {

    # The Node function creates nodes with specified attributes, including custom labels and shapes.


    Node -Name Web01 -Attributes @{Label = 'Web01'; shape = 'rectangle'; fillColor = 'Green'; fontsize = 14 }
    Node -Name App01 -Attributes @{Label = 'App01'; shape = 'rectangle'; fillColor = 'Blue'; fontsize = 14 }
    Node -Name DB01 -Attributes @{Label = 'DB01'; shape = 'rectangle'; fillColor = 'Red'; fontsize = 14 }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example1 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example1 -LogoName "Main_Logo"  -DraftMode:$DraftMode
```

The parameters used in the New-Diagrammer cmdlet are explained below:

```text title="Parameters Explained:"
-InputObject: Accepts the custom object defined above.
-OutputFolderPath: Specifies where to save the generated diagram.
-Format: Sets the output format (png, jpg, svg, etc.).
-ImagesObj: Passes a hashtable of images for custom icons.
-MainDiagramLabel: Sets the diagram's title.
-Filename: Specifies the output file name (without extension).
-LogoName: Selects an image from the hashtable to use as the diagram logo.
    - If the specified logo image is not found, a default no_icon.png is used.
-DraftMode: If set to $true, generates a draft version of the diagram for troubleshooting.
```

When you run the script, it generates a PNG file named Example1.png in the specified output folder.

**Resulting diagram:**

!!! example

    === "Example 1"
        ```graphviz dot example1.png
            digraph Root {
                graph [bb="0,0,506,411.5",
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
                    graph [bb="8,8,498,403.5",
                        color=gray,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="487,26.625",
                        lwidth=0.08,
                        penwidth=1.5,
                        style=invis
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,451,395.5",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">3tier Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.92,
                            lp="233.5,250.38",
                            lwidth=5.40,
                            penwidth=0
                        ];
                        MainGraph	[height=0.05,
                            label="",
                            pos="26,79.25",
                            shape=point,
                            style=invis,
                            width=0.05];
                        "Web-Server-01"	[fillcolor=Green,
                            height=0.5,
                            label="Web-Server-01",
                            pos="120,79.25",
                            shape=rectangle,
                            width=1.3681];
                        "App-Server-01"	[fillcolor=Blue,
                            height=0.5,
                            label="App-Server-01",
                            pos="261,79.25",
                            shape=rectangle,
                            width=1.3472];
                        "Db-Server-01"	[fillcolor=Red,
                            height=0.5,
                            label="Db-Server-01",
                            pos="398,79.25",
                            shape=rectangle,
                            width=1.2535];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="488,79.25",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```
    === "Example 1 - DraftMode"
        ```graphviz dot example1_draftmode.png
            digraph Root {
                graph [bb="0,0,506,357",
                    bgcolor=White,
                    compound=true,
                    fontcolor="#000000",
                    fontname="Segoe Ui",
                    fontsize=32,
                    imagepath="/home/rebelinux/.local/share/powershell/Modules/Diagrammer.Core/Tools/Icons",
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
                    graph [bb="8,8,498,349",
                        color=red,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="487,26.625",
                        lwidth=0.08,
                        penwidth=1.5,
                        style=dashed
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,451,341",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">3tier Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.16,
                            lp="233.5,223.12",
                            lwidth=5.40,
                            penwidth=0
                        ];
                        MainGraph	[height=0.05,
                            label="",
                            pos="26,79.25",
                            shape=point,
                            style=invis,
                            width=0.05];
                        "Web-Server-01"	[fillcolor=Green,
                            height=0.5,
                            label="Web-Server-01",
                            pos="120,79.25",
                            shape=rectangle,
                            width=1.3681];
                        "App-Server-01"	[fillcolor=Blue,
                            height=0.5,
                            label="App-Server-01",
                            pos="261,79.25",
                            shape=rectangle,
                            width=1.3472];
                        "Db-Server-01"	[fillcolor=Red,
                            height=0.5,
                            label="Db-Server-01",
                            pos="398,79.25",
                            shape=rectangle,
                            width=1.2535];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="488,79.25",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```