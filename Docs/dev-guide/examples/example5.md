---
comments: true
hide:
  - toc
---

This time we will add icons and additional information to Node objects.

The **`Add-DiaNodeIcon`** (part of Diagrammer.Core module) function enhances the visual representation of nodes by incorporating icons and detailed information. In this example, each server node (Web, Application, and Database) is depicted with a server icon and a table listing its operating system, version, build, and edition. The nodes are organized within a dashed rounded rectangle labeled "3 Tier Concept," visually encapsulating the three-tier architecture. Connections between the nodes are clearly labeled with the communication protocols used (gRPC and SQL), providing a comprehensive overview of the web application structure.

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

This time, we enhance the diagram by adding images to the Node objects and embedding information to describe server properties. Graphviz supports HTML-Like tables to extend object labels, allowing images, text, and tables within Node, Edge, and Subgraph @{Label=} script blocks attributes.

**`Add-DiaNodeIcon`** extends PSGraph to improve the appearance of the generated Node objects (Add-DiaNodeIcon is part of Diagrammer.Core).

The $Images object and IconType "Server" must be defined earlier in the script

```powershell linenums="1" hl_lines="11-13" title="Example5.ps1 - Add-DiaNodeIcon"
$example5 = & {
    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {

        <#
            -AditionalInfo parameter accepts a custom object with properties to display in the node label.
            -Align parameter sets the alignment of the icon and text (Left, Right, Center).
            -ImagesObj parameter passes the hashtable of images defined earlier in the script.
            -FontSize 18 sets the font size for the node label text.
        #>

        $Web01Label = Add-DiaNodeIcon -Name 'Web-Server-01' -AditionalInfo $WebServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode
        $App01Label = Add-DiaNodeIcon -Name 'App-Server-01' -AditionalInfo $AppServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode
        $DB01Label = Add-DiaNodeIcon -Name 'Db-Server-01' -AditionalInfo $DBServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

        Node -Name Web01 -Attributes @{Label = $Web01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
        Node -Name App01 -Attributes @{ Label = $App01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
        Node -Name DB01 -Attributes @{Label = $DB01Label; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

        Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
        Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example5 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example5 -LogoName "Main_Logo"  -DraftMode:$DraftMode
```

When you run the script, it generates a PNG file named Example5.png in the specified output folder.

**Resulting diagram:**

!!! example

    === "Example 5"

        ```graphviz dot example5.png
            digraph Root {
                graph [bb="0,0,394,1612",
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
                    graph [bb="8,8,386,1604",
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
                        graph [bb="16,53.25,366,1596",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.92,
                            lp="191,1450.9",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="47,61.25,268,1297.8",
                                color=gray,
                                fontsize=18,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.31,
                                lp="157.5,1282.5",
                                lwidth=1.74,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            "3tier"	[height=0.05,
                                label="",
                                pos="57,1121",
                                shape=point,
                                style=invis,
                                width=0.05];
                            Web01	[fillcolor=transparent,
                                height=3.8403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="181,1121",
                                shape=plain,
                                width=2.2049];
                            App01	[fillcolor=transparent,
                                height=3.8403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>App-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Windows Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 2019</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 17763.3163</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                pos="174,664.25",
                                shape=plain,
                                width=2.3924];
                            Web01 -> App01	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=gRPC,
                                lp="191.62,892.62",
                                minlen=3,
                                pos="s,178.5,982.76 e,175.76,802.26 178.3,971.91 177.58,932.02 177,899.75 177,899.75 177,899.75 176.52,861.9 175.94,816.55"];
                            DB01	[fillcolor=transparent,
                                height=3.8403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Db-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Oracle Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 8</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 8.2</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="174,207.5",
                                shape=plain,
                                width=2.2049];
                            App01 -> DB01	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=SQL,
                                lp="185.62,435.88",
                                minlen=3,
                                pos="s,174,526.01 e,174,345.51 174,515.16 174,475.27 174,443 174,443 174,443 174,405.15 174,359.8"];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="317,1121",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="376,1121",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```
    === "Example 5 - Draft Mode"

        ```graphviz dot example5_draftmode.png
            digraph Root {
                graph [bb="0,0,394,1442",
                    bgcolor=White,
                    compound=true,
                    fontcolor="#000000",
                    fontname="Segoe Ui",
                    fontsize=32,
                    imagepath="/home/rebelinux/.local/share/powershell/Modules/Diagrammer.Core/Examples/Icons",
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
                    graph [bb="8,8,386,1434",
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
                        graph [bb="16,53.25,366,1426",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.16,
                            lp="191,1308.1",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="45,61.25,270,1182.2",
                                color=gray,
                                fontsize=18,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.31,
                                lp="157.5,1167",
                                lwidth=1.74,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            "3tier"	[height=0.05,
                                label="",
                                pos="55,1024.8",
                                shape=point,
                                style=invis,
                                width=0.05];
                            Web01	[fillcolor=transparent,
                                height=3.3056,
                                label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="181,1024.8",
                                shape=plain,
                                width=2.2604];
                            App01	[fillcolor=transparent,
                                height=3.3056,
                                label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>App-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Windows Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 2019</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 17763.3163</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                pos="174,606.5",
                                shape=plain,
                                width=2.4479];
                            Web01 -> App01	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=gRPC,
                                lp="191.62,815.62",
                                minlen=3,
                                pos="s,178.64,905.79 e,175.65,725.38 178.43,894.86 177.65,855.63 177,822.75 177,822.75 177,822.75 176.47,784.22 175.85,739.68"];
                            DB01	[fillcolor=transparent,
                                height=3.3056,
                                label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Db-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Oracle Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 8</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 8.2</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="174,188.25",
                                shape=plain,
                                width=2.2604];
                            App01 -> DB01	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=SQL,
                                lp="185.62,397.38",
                                minlen=3,
                                pos="s,174,487.54 e,174,307.13 174,476.61 174,437.38 174,404.5 174,404.5 174,404.5 174,365.97 174,321.43"];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="318,1024.8",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="376,1024.8",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```
