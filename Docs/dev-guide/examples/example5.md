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
                graph [bb="0,0,414,1618.8",
                    bgcolor=White,
                    compound=true,
                    fontcolor="#565656",
                    fontname="Segoe Ui",
                    fontsize=32,
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
                    graph [bb="8,8,406,1610.8",
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
                        graph [bb="16,57.75,398,1602.8",
                            fontsize=24,
                            label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Docs/Icons/Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.98,
                            lp="207,1455.4",
                            lwidth=5.09,
                            penwidth=0
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
                                label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="207,1121.8",
                                shape=plain,
                                width=2.2049];
                            App01	[fillcolor=transparent,
                                height=3.8194,
                                label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>App-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Windows Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 2019</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 17763.3163</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Datacenter</FONT></TD></TR></TABLE>>,
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
                                label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
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
                }
            }
        ```
    === "Example 5 - Draft Mode"

        ```graphviz dot example5_draftmode.png
            digraph Root {
                graph [bb="0,0,435,1524.5",
                    bgcolor=White,
                    compound=true,
                    fontcolor="#565656",
                    fontname="Segoe Ui",
                    fontsize=32,
                    imagepath="C:\Users\jocolon\Documents\WindowsPowerShell\Modules\Diagrammer.Core\Examples\icons",
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
                    graph [bb="8,8,427,1516.5",
                        color=red,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.47,
                        lp="415.62,28.875",
                        lwidth=0.09,
                        penwidth=1.5,
                        style=dashed
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,57.75,419,1508.5",
                            fontsize=24,
                            label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='20'><TR><TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'>Main Logo</TD></TR><TR><TD bgcolor='#FFCCCC' ALIGN='center' ><FONT FACE='Segoe Ui' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR><TR><TD ALIGN='center'><font color='red'>DraftMode ON</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=4.18,
                            lp="217.5,1353.9",
                            lwidth=5.37,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="121,65.75,313,1191.2",
                                color=gray,
                                fontsize=18,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.34,
                                lp="217,1174.9",
                                lwidth=1.75,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            Web01	[fillcolor=transparent,
                                height=3.316,
                                label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="217,1031.1",
                                shape=plain,
                                width=2.2604];
                            App01	[fillcolor=transparent,
                                height=3.316,
                                label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>App-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Windows Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 2019</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 17763.3163</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                pos="217,612.12",
                                shape=plain,
                                width=2.4479];
                            Web01 -> App01	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=gRPC,
                                lp="231.62,821.62",
                                minlen=3,
                                pos="s,217,911.94 e,217,731.21 217,900.99 217,861.69 217,828.75 217,828.75 217,828.75 217,790.15 217,745.54"];
                            DB01	[fillcolor=transparent,
                                height=3.316,
                                label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="217,193.12",
                                shape=plain,
                                width=2.2604];
                            App01 -> DB01	[color=black,
                                fontcolor=black,
                                fontsize=12,
                                label=SQL,
                                lp="228.62,402.62",
                                minlen=3,
                                pos="s,217,492.94 e,217,312.21 217,481.99 217,442.69 217,409.75 217,409.75 217,409.75 217,371.15 217,326.54"];
                        }
                    }
                }
            }
        ```
