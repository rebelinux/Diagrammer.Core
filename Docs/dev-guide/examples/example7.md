---
comments: true
hide:
  - toc
---

The Rank cmdlet (part of PSgraph module) is used in Graphviz to control the vertical or horizontal alignment of nodes. When you apply the Rank cmdlet to a set of nodes, it forces them to appear at the same level in the diagram—either in a row (horizontal alignment) or a column (vertical alignment).

For example, in a 3-tier architecture diagram, using the Rank cmdlet on App01 and DB01 ensures these nodes are visually grouped together at the same layer. This makes the diagram easier to read and helps clarify the relationships between components.

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
[System.IO.FileInfo]$IconPath = Join-Path $RootPath 'Icons'
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
    'Edition' = "Datacenter"
}

$DBServerInfo = [PSCustomObject][ordered]@{
    'OS' = 'Oracle Server'
    'Version' = '8'
    'Build' = "8.2"
    'Edition' = "Enterprise"
}
```

The Rank cmdlet is used to place nodes at the same hierarchical level.

[https://psgraph.readthedocs.io/en/stable/Command-Rank-Advanced/](https://psgraph.readthedocs.io/en/stable/Command-Rank-Advanced/){:target="_blank"}

In this example, App01 and DB01 are aligned horizontally.

```powershell linenums="1" hl_lines="15-16" title="Example7.ps1 - Rank cmdlet"
$example7 = & {
    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {

        $Web01Label = Add-DiaNodeIcon -Name 'Web-Server-01' -AditionalInfo $WebServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode
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
New-Diagrammer -InputObject $example7 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example7 -LogoName "Main_Logo"  -DraftMode:$DraftMode
```

When you run the script, it generates a PNG file named Example7.png in the specified output folder.

**Resulting diagram:**

!!! example

    === "Example 7"
        ```graphviz dot example7.png
            digraph Root {
                graph [bb="0,0,703,1157.5",
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
                    graph [bb="8,8,695,1149.5",
                        color=gray,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="684,26.625",
                        lwidth=0.08,
                        penwidth=1.5,
                        style=invis
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,648,1141.5",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.92,
                            lp="332,996.38",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="24,61.25,628,843.25",
                                color=darkgray,
                                fontsize=18,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.31,
                                lp="326,828",
                                lwidth=1.74,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            {
                                graph [rank=same];
                                "App-Server-01"	[fillcolor=transparent,
                                    height=3.8403,
                                    label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>App-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Windows Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 2019</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 17763.3163</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                    pos="118,207.5",
                                    shape=plain,
                                    width=2.3924];
                                "Db-Server-01"	[fillcolor=transparent,
                                    height=3.8403,
                                    label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Db-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Oracle Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 8</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 8.2</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="541,207.5",
                                    shape=plain,
                                    width=2.2049];
                            }
                            "3tier"	[height=0.05,
                                label="",
                                pos="34,666.5",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "Web-Server-01"	[fillcolor=transparent,
                                height=3.8403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="158,666.5",
                                shape=plain,
                                width=2.2049];
                            "Web-Server-01" -> "App-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=gRPC,
                                lp="154.12,437",
                                minlen=3,
                                pos="s,145.5,528.26 e,129.61,345.46 144.52,517.41 140.92,477.52 138,445.25 138,445.25 138,445.25 134.71,406.19 130.81,359.74"];
                            "App-Server-01" -> "Db-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=SQL,
                                lp="332.88,218.75",
                                minlen=3,
                                pos="s,204.11,207.5 e,461.8,207.5 214.94,207.5 284.76,207.5 378.43,207.5 447.46,207.5"];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="638,666.5",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="685,666.5",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
            ```
    === "Example 7 - Draft Mode"
        ```graphviz dot example7_draftmode.png
            digraph Root {
                graph [bb="0,0,711,1026",
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
                    graph [bb="8,8,703,1018",
                        color=red,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="692,26.625",
                        lwidth=0.08,
                        penwidth=1.5,
                        style=dashed
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,656,1010",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.16,
                            lp="336,892.12",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="24,61.25,636,766.25",
                                color=darkgray,
                                fontsize=18,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.31,
                                lp="330,751",
                                lwidth=1.74,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            {
                                graph [rank=same];
                                "App-Server-01"	[fillcolor=transparent,
                                    height=3.3056,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>App-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Windows Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 2019</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 17763.3163</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                    pos="120,188.25",
                                    shape=plain,
                                    width=2.4479];
                                "Db-Server-01"	[fillcolor=transparent,
                                    height=3.3056,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Db-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Oracle Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 8</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 8.2</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="547,188.25",
                                    shape=plain,
                                    width=2.2604];
                            }
                            "3tier"	[height=0.05,
                                label="",
                                pos="34,608.75",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "Web-Server-01"	[fillcolor=transparent,
                                height=3.3056,
                                label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="160,608.75",
                                shape=plain,
                                width=2.2604];
                            "Web-Server-01" -> "App-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=gRPC,
                                lp="156.12,398.5",
                                minlen=3,
                                pos="s,148.22,489.79 e,130.88,307.09 147.14,478.86 143.26,439.63 140,406.75 140,406.75 140,406.75 136.36,366.99 132.19,321.39"];
                            "App-Server-01" -> "Db-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=SQL,
                                lp="336.88,199.5",
                                minlen=3,
                                pos="s,207.96,188.25 e,465.66,188.25 218.81,188.25 288.74,188.25 382.03,188.25 451.27,188.25"];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="646,608.75",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="693,608.75",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```