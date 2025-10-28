---
comments: true
hide:
  - toc
---
This example demonstrates how to use the **`Add-DiaHTMLSubGraph`** cmdlet to simulate Graphviz SubGraphs (part of Diagrammer.Core).

The diagram below visually compares a traditional Graphviz SubGraph with a Diagrammer.Core HTML-like SubGraph, highlighting the enhanced layout and connectivity options available in Diagrammer.Core.


```powershell title="PowerShell: AdvancedExample1.ps1 - param block"
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
$MainGraphLabel = 'Web Application Diagram'
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
    "ServerRedhat" = "Linux_Server_RedHat.png"
    "ServerUbuntu" = "Linux_Server_Ubuntu.png"
    "Cloud" = "Cloud.png"
    "Router" = "Router.png"
    "Logo_Footer" = "Signature_Logo.png"
}
```

This section creates custom objects to hold server information, which are used to set node labels in the diagram.

```powershell
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

Native Graphviz SubGraph has its issues when it comes to layout and connectivity. For example, nodes in a SubGraph are not always aligned properly, and edges connecting nodes inside and outside the SubGraph can be misaligned or not connect as expected. This can lead to diagrams that are difficult to read and understand.

Additionally, Nodes inside SubGraphs cannot be split across multiple rows or columns, limiting the flexibility of the layout. This can be particularly problematic when trying to create complex diagrams with many nodes and connections.

Diagrammer.Core provides a workaround using HTML-like labels to simulate SubGraphs with enhanced layout and connectivity options.By using HTML-like labels, we can create more complex and flexible layouts for nodes within
a SubGraph. This allows us to better organize and present information in the diagram.Additionally, HTML-like labels provide more control over the appearance and formatting of the nodes, allowing for a more polished and professional look. This approach can help to overcome some of the limitations of traditional Graphviz SubGraphs, making it easier to create clear and effective diagrams.

```powershell linenums="1" hl_lines="96-102" title="AdvancedExample1.ps1 - Add-DiaHTMLSubGraph"
$advancedexample01 = & {

    SubGraph 3tier -Attributes @{Label = 'Advanced Diagram Concepts'; fontsize = 22; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "darkgray" } {

        # Here I create a web server farm with 6 web servers using a traditional Graphviz SubGraph.
        SubGraph Traditional -Attributes @{Label = 'Native Graphviz SubGraph'; bgcolor = '#c1cfe5ff'; fontsize = 22; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "darkgray" } {
            $index = 1

            while ($index -le 6) {

                $AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }

                $WebLabel = Add-DiaNodeIcon -Name "Web-Server-0$index" -AdditionalInfo $AdditionalInfo -ImagesObj $Images -IconType "ServerRedhat" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

                Node -Name "UK-WebServer-0$index" -Attributes @{Label = $WebLabel ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

                $index++
            }
        }

        <#
            Here I create a web server farm with 6 web servers using Add-DiaHTMLNodeTable.
            Each server will have an icon and additional information displayed in a table format.
            The servers will be arranged in a table with **3 columns** (This can't be done with Graphviz Native SubGraph).
        #>

        $WebServerFarm = @(
            @{
                Name = 'Web-Server-01';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-02';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-03';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-04';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            }, @{
                Name = 'Web-Server-05';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            },
            @{
                Name = 'Web-Server-06';
                AdditionalInfo = [PSCustomObject][ordered]@{
                    'OS' = 'Redhat Linux'
                    'Version' = '10'
                    'Build' = "10.1"
                }
                IconType = "ServerRedhat"
            }
        )

        <#
            The Add-DiaHTMLNodeTable cmdlet creates a HTML-like table with icons and additional information for each web server.
            The -columnSize parameter is set to 3, which arranges the servers in a table with 3 columns.
            The -MultiIcon switch allows multiple icons to be displayed in the table.
            The resulting HTML-like table is then used as the label for a Node representing the web server farm.
        #>

        $WebLabel = Add-DiaHTMLNodeTable -ImagesObj $Images -inputObject $WebServerFarm.Name -iconType $WebServerFarm.IconType -columnSize 3 -AditionalInfo $WebServerFarm.AdditionalInfo -MultiIcon -DraftMode:$DraftMode -fontSize 18

        <#
            The Add-DiaHTMLSubGraph cmdlet creates a HTML-like table that simulates a SubGraph with enhanced layout and connectivity options.
            The -columnSize parameter is set to 1, which arranges the web servers in a table with 1 column.
            The resulting HTML-like table is then used as the label for a Node representing the web server farm.
        #>

        $WebNodeObj = Add-DiaHTMLSubGraph -ImagesObj $Images -TableArray $WebLabel -Align 'Center' -Label 'Diagrammer SubGraph' -LabelPos "top" -TableStyle "dashed,rounded" -TableBorderColor "darkgray" -TableBorder "1" -columnSize 1 -fontSize 22 -DraftMode:$DraftMode -TableBackgroundColor '#a8c3b8ff' -IconType "Server"

        <#
            Finally, create a Node for the web server farm using the HTML-like SubGraph as the label.
            The node is styled with a transparent background and a font size of 14.
        #>

        Node -Name "USA-WebServers" -Attributes @{Label = $WebNodeObj ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14; }
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $advancedexample01 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename AdvancedExample1 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -DraftMode:$DraftMode
```
When you run the script, it generates a PNG file named AdvancedExample1.png in the specified output folder.

### Resulting diagram:

!!! example

    === "Advanced Example 01"

        ```graphviz dot advancedexample01.png
        digraph Root {
            graph [bb="0,0,1921,1013",
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
                graph [bb="8,8,1913,1005",
                    color=gray,
                    fontsize=24,
                    label=" ",
                    labeljust=r,
                    labelloc=b,
                    lheight=0.41,
                    lp="1902,26.625",
                    lwidth=0.08,
                    penwidth=1.5,
                    style=invis
                ];
                subgraph clusterMainGraph {
                    graph [bb="16,53.25,1866,997",
                        fontsize=24,
                        label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">Web Application Diagram</FONT></TD></TR></TABLE>>,
                        labeljust=c,
                        labelloc=t,
                        lheight=3.92,
                        lp="941,851.88",
                        lwidth=4.64,
                        penwidth=0
                    ];
                    subgraph cluster3tier {
                        graph [bb="24,61.25,1819,698.75",
                            color=darkgray,
                            fontsize=22,
                            label="Advanced Diagram Concepts",
                            labelloc=t,
                            lheight=0.39,
                            lp="921.5,680.88",
                            lwidth=4.07,
                            penwidth=1.5,
                            style="dashed,rounded"
                        ];
                        subgraph clusterTraditional {
                            graph [bb="32,233.88,1247,526.12",
                                bgcolor="#c1cfe5ff",
                                color=darkgray,
                                fontsize=22,
                                label="Native Graphviz SubGraph",
                                labelloc=t,
                                lheight=0.39,
                                lp="639.5,508.25",
                                lwidth=3.69,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            Traditional	[height=0.05,
                                label="",
                                pos="42,362.12",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "Web-Server-01"	[fillcolor=transparent,
                                height=3.3403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="163,362.12",
                                shape=plain,
                                width=2.1215];
                            "Web-Server-02"	[fillcolor=transparent,
                                height=3.3403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="361,362.12",
                                shape=plain,
                                width=2.1736];
                            "Web-Server-03"	[fillcolor=transparent,
                                height=3.3403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="561,362.12",
                                shape=plain,
                                width=2.1736];
                            "Web-Server-04"	[fillcolor=transparent,
                                height=3.3403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-04</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="761,362.12",
                                shape=plain,
                                width=2.184];
                            "Web-Server-05"	[fillcolor=transparent,
                                height=3.3403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-05</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="961,362.12",
                                shape=plain,
                                width=2.1736];
                            "Web-Server-06"	[fillcolor=transparent,
                                height=3.3403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-06</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="1161,362.12",
                                shape=plain,
                                width=2.1736];
                        }
                        "3tier"	[height=0.05,
                            label="",
                            pos="1284,362.12",
                            shape=point,
                            style=invis,
                            width=0.05];
                        "USA-WebServers"	[fillcolor=transparent,
                            height=8.1354,
                            label=<<TABLE BGColor="#a8c3b8ff" COLOR="darkgray" STYLE="dashed,rounded" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD valign="BOTTOM" ALIGN="Center" colspan="1" fixedsize="true" width="40" height="40"><IMG src="Server.png"></IMG></TD></TR><TR><TD valign="TOP" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="22" COLOR="#000000">Diagrammer SubGraph</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="22"><TABLE COLOR="#000000" PORT="EdgeDot" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD PORT="Web-Server-04" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-04</B></FONT></TD><TD PORT="Web-Server-05" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-05</B></FONT></TD><TD PORT="Web-Server-06" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-06</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE></FONT></TD></TR></TABLE>>,
                            pos="1570,362.12",
                            shape=plain,
                            width=6.6979];
                    }
                    MainGraph	[height=0.05,
                        label="",
                        pos="1856,362.12",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
                OUTERDRAWBOARD1	[height=0.05,
                    label="",
                    pos="1903,362.12",
                    shape=point,
                    style=invis,
                    width=0.05];
            }
        }
        ```

    === "Advanced Example 01 - DraftMode"

        ```graphviz dot advancedexample01_draftmode.png
            digraph Root {
                graph [bb="0,0,2666,867.25",
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
                    graph [bb="8,8,2658,859.25",
                        color=red,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="2647,26.625",
                        lwidth=0.08,
                        penwidth=1.5,
                        style=dashed
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,2611,851.25",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.16,
                            lp="1313.5,733.38",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="24,61.25,2564,607.5",
                                color=darkgray,
                                fontsize=22,
                                label="Advanced Diagram Concepts",
                                labelloc=t,
                                lheight=0.39,
                                lp="1294,589.62",
                                lwidth=4.07,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            subgraph clusterTraditional {
                                graph [bb="32,208.5,1750,460.25",
                                    bgcolor="#c1cfe5ff",
                                    color=darkgray,
                                    fontsize=22,
                                    label="Native Graphviz SubGraph",
                                    labelloc=t,
                                    lheight=0.39,
                                    lp="891,442.38",
                                    lwidth=3.69,
                                    penwidth=1.5,
                                    style="dashed,rounded"
                                ];
                                Traditional	[height=0.05,
                                    label="",
                                    pos="42,316.5",
                                    shape=point,
                                    style=invis,
                                    width=0.05];
                                "Web-Server-01"	[fillcolor=transparent,
                                    height=2.7778,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="207,316.5",
                                    shape=plain,
                                    width=3.3333];
                                "Web-Server-02"	[fillcolor=transparent,
                                    height=2.7778,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="490,316.5",
                                    shape=plain,
                                    width=3.3333];
                                "Web-Server-03"	[fillcolor=transparent,
                                    height=2.7778,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="773,316.5",
                                    shape=plain,
                                    width=3.3333];
                                "Web-Server-04"	[fillcolor=transparent,
                                    height=2.7778,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-04</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="1056,316.5",
                                    shape=plain,
                                    width=3.3333];
                                "Web-Server-05"	[fillcolor=transparent,
                                    height=2.7778,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-05</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="1339,316.5",
                                    shape=plain,
                                    width=3.3333];
                                "Web-Server-06"	[fillcolor=transparent,
                                    height=2.7778,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-06</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="1622,316.5",
                                    shape=plain,
                                    width=3.3333];
                            }
                            "3tier"	[height=0.05,
                                label="",
                                pos="1787,316.5",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "USA-WebServers"	[fillcolor=transparent,
                                height=6.8681,
                                label=<<TABLE BGColor="#a8c3b8ff" STYLE="dashed,rounded" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="22">Server.png</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="22" COLOR="#000000">Diagrammer SubGraph</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="22"><TABLE PORT="EdgeDot" COLOR="red" border="1" cellborder="1" cellpadding="5" cellspacing="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD></TR><TR><TD PORT="Web-Server-04" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-04</B></FONT></TD><TD PORT="Web-Server-05" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-05</B></FONT></TD><TD PORT="Web-Server-06" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-06</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE></FONT></TD></TR></TABLE>>,
                                pos="2194,316.5",
                                shape=plain,
                                width=10.056];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="2601,316.5",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="2648,316.5",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```