---
comments: true
hide:
  - toc
---

This time, we'll demonstrate the use of the Signature feature (Part of Diagrammer.Core module)

To include a signature table as a footer in the diagram, use the `Add-DiaHtmlSignatureTable` cmdlet. This cmdlet generates a signature table, which you assign to a variable (e.g., `$Signature`). You then set this variable as the label of a dedicated SubGraph. By configuring the SubGraph's style to be invisible and positioning its label at the bottom, the signature table appears as a custom footer in the final diagram output.

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

In this section we demonstrates the use of the **`Add-DiaHtmlSignatureTable`** cmdlet used to creates a signature table to be used as a footer in the diagram. The Signature SubGraph contains the $Signature table created above. It is styled to be invisible and positioned at the bottom of the diagram.

```powershell linenums="1" hl_lines="04-10" title="Example13.ps1 - Signature feature"
$example13 = & {
    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {

        # The $Signature variable store the result of the signature table to be used as a footer in the diagram.

        $Signature = Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows "Author: Bugs Bunny", "Company: ACME Inc." -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -DraftMode:$DraftMode -FontBold

        # The content of the Signature variable is placed inside a SubGraph to position it at the bottom of the diagram.

        SubGraph Signature -Attributes @{Label = $Signature; fontsize = 22; penwidth = 1.5; labelloc = 'b'; labeljust = 'right'; style = "invis"; color = "darkgray" } {

            $WebServerFarm = @(
                @{
                    Name = 'Web-Server-01';
                    AdditionalInfo = [PSCustomObject][ordered]@{
                        'OS' = 'Redhat Linux'
                        'Version' = '10'
                        'Build' = "10.1"
                        'Edition' = "Enterprise"
                    }
                    IconType = "ServerRedhat"
                },
                @{
                    Name = 'Web-Server-02';
                    AdditionalInfo = [PSCustomObject][ordered]@{
                        'OS' = 'Redhat Linux'
                        'Version' = '10'
                        'Build' = "10.1"
                        'Edition' = "Enterprise"
                    }
                    IconType = "ServerRedhat"
                },
                @{
                    Name = 'Web-Server-03';
                    AdditionalInfo = [PSCustomObject][ordered]@{
                        'OS' = 'Ubuntu Linux'
                        'Version' = '24'
                        'Build' = "11"
                        'Edition' = "Enterprise"
                    }
                    IconType = "ServerUbuntu"
                }
            )

            $Web01Label = Add-DiaHTMLNodeTable -ImagesObj $Images -inputObject $WebServerFarm.Name -iconType $WebServerFarm.IconType -columnSize 3 -AditionalInfo $WebServerFarm.AdditionalInfo -Subgraph -SubgraphLabel "Web Server Farm" -SubgraphLabelPos "top" -SubgraphTableStyle "dashed,rounded" -TableBorderColor "gray" -TableBorder "1" -SubgraphLabelFontsize 20 -fontSize 18 -MultiIcon -DraftMode:$DraftMode


            $App01Label = Add-DiaNodeIcon -Name 'App-Server-01' -AditionalInfo $AppServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode
            $DB01Label = Add-DiaNodeIcon -Name 'Db-Server-01' -AditionalInfo $DBServerInfo -ImagesObj $Images -IconType "Server" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

            Node -Name Web01 -Attributes @{Label = $Web01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
            Node -Name App01 -Attributes @{ Label = $App01Label ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }
            Node -Name DB01 -Attributes @{Label = $DB01Label; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

            Edge -From Web01 -To App01 @{label = 'gRPC'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }
            Edge -From App01 -To DB01 @{label = 'SQL'; color = 'black'; fontsize = 12; fontcolor = 'black'; minlen = 3 }

            Rank -Nodes App01, DB01

            $RouterInfo = [PSCustomObject][ordered]@{
                'OS' = 'Cisco IOS'
                'Version' = '15.2'
            }

            $RouterLabel = Add-DiaNodeIcon -Name 'Core-Router' -AdditionalInfo $RouterInfo -ImagesObj $Images -IconType "Router" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

            Node -Name Router01 -Attributes @{label = $RouterLabel ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

            Edge -From Router01 -To Web01 @{label = 'GE0/0'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2 }

            Add-DiaNodeImage -Name "WAN" -ImagesObj $Images -IconType "Cloud" -IconPath $IconPath -ImageSizePercent 30 -DraftMode:$DraftMode

            Edge -From WAN -To Router01 @{label = 'Serial0/0'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2 }

            $RouterNetworkInfo = @(
                "S0/0:"
                "164.42.203.10/30"
                "G0/0:"
                "192.168.5.10/24"
            )

            Add-DiaHtmlTable -Name 'RouterNetworkInfo' -Rows $RouterNetworkInfo -NodeObject -ColumnSize 2 -TableBorder 1 -TableBorderColor "black" -FontSize 14 -Subgraph -SubgraphLabel "Interfaces Table" -SubgraphLabelPos "top" -SubgraphTableStyle "solid,rounded" -SubgraphLabelFontsize 20 -SubgraphFontUnderline -SubgraphFontBold -DraftMode:$DraftMode -TableBackgroundColor 'lightblue'

            Edge -From Router01 -To RouterNetworkInfo @{color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 1; style = 'filled'; arrowhead = 'none'; arrowtail = 'none' }

            Rank Router01, RouterNetworkInfo
         }
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example13 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example13 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -WaterMarkText "Confidential" -WaterMarkColor "DarkGray" -WaterMarkFontOpacity 40 -DraftMode:$DraftMode
```

When you run the script, it generates a PNG file named Example13.png in the specified output folder.

**Resulting diagram:**

!!! example

    === "Example 13"
        ```graphviz dot example13.png
            digraph Root {
                graph [bb="0,0,758,1946",
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
                    graph [bb="8,8,750,1938",
                        color=gray,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="739,26.625",
                        lwidth=0.08,
                        penwidth=1.5,
                        style=invis
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,703,1930",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.92,
                            lp="359.5,1784.9",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="24,61.25,656,1631.8",
                                color=darkgray,
                                fontsize=22,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.39,
                                lp="340,1613.9",
                                lwidth=2.06,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            subgraph clusterSignature {
                                graph [bb="32,69.25,636,1588",
                                    color=darkgray,
                                    fontsize=22,
                                    label=<<TABLE STYLE="rounded,dashed" border="2" cellborder="0" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="left" colspan="1" rowspan="4"><img src="Signature_Logo.png"/></TD></TR><TR><TD valign="top" align="left" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000"><B>Author: Bugs Bunny</B></FONT></TD></TR><TR><TD valign="top" align="left" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000"><B>Company: ACME Inc.</B></FONT></TD></TR></TABLE>>,
                                    labeljust=right,
                                    labelloc=b,
                                    lheight=1.22,
                                    lp="506.75,117.25",
                                    lwidth=3.37,
                                    penwidth=1.5,
                                    style=invis
                                ];
                                {
                                    graph [rank=same];
                                    "App-Server-01"	[fillcolor=transparent,
                                        height=3.8403,
                                        label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>App-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Windows Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 2019</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 17763.3163</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                        pos="126,311.5",
                                        shape=plain,
                                        width=2.3924];
                                    "Db-Server-01"	[fillcolor=transparent,
                                        height=3.8403,
                                        label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Db-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Oracle Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 8</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 8.2</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                        pos="549,311.5",
                                        shape=plain,
                                        width=2.2049];
                                }
                                {
                                    graph [rank=same];
                                    "Core-Router"	[fillcolor=transparent,
                                        height=2.8403,
                                        label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Router.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Core-Router</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Cisco IOS</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 15.2</FONT></TD></TR></TABLE>>,
                                        pos="274,1183.8",
                                        shape=plain,
                                        width=1.7882];
                                    RouterNetworkInfo	[fillcolor=lightblue,
                                        height=1.566,
                                        label=<<TABLE COLOR="black" STYLE="solid,rounded" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="center" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="20" COLOR="#000000">Interfaces Table</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">S0/0:</FONT></TD><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">164.42.203.10/30</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">G0/0:</FONT></TD><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.168.5.10/24</FONT></TD></TR></TABLE>>,
                                        pos="519,1183.8",
                                        shape=plain,
                                        style="filled,rounded",
                                        width=2.6285];
                                }
                                Signature	[height=0.05,
                                    label="",
                                    pos="95,1498.5",
                                    shape=point,
                                    style=invis,
                                    width=0.05];
                                "Web-Server-Farm"	[fillcolor=transparent,
                                    height=4.4201,
                                    label=<<TABLE COLOR="gray" STYLE="dashed,rounded" PORT="EdgeDot" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui" POINT-SIZE="20" COLOR="#000000"><B>Web Server Farm</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_Ubuntu.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="274,791.38",
                                    shape=plain,
                                    width=6.5035];
                                "Web-Server-Farm" -> "App-Server-01"	[color=black,
                                    fontcolor=black,
                                    fontsize=14,
                                    label=gRPC,
                                    lp="216.12,541",
                                    minlen=3,
                                    pos="s,225.47,632.58 e,168.94,449.46 222.33,622.3 209.83,581.42 200,549.25 200,549.25 200,549.25 187.74,509.85 173.2,463.14"];
                                "App-Server-01" -> "Db-Server-01"	[color=black,
                                    fontcolor=black,
                                    fontsize=14,
                                    label=SQL,
                                    lp="340.88,322.75",
                                    minlen=3,
                                    pos="s,212.11,311.5 e,469.8,311.5 222.94,311.5 292.76,311.5 386.43,311.5 455.46,311.5"];
                                "Core-Router" -> "Web-Server-Farm"	[color=black,
                                    fontcolor=black,
                                    fontsize=18,
                                    label="GE0/0",
                                    lp="297.62,1016",
                                    minlen=2,
                                    pos="s,274,1081.9 e,274,950.49 274,1071.2 274,1046 274,1026.5 274,1026.5 274,1026.5 274,1000.1 274,964.9"];
                                "Core-Router" -> RouterNetworkInfo	[arrowhead=none,
                                    arrowtail=none,
                                    color=black,
                                    fontcolor=black,
                                    fontsize=18,
                                    minlen=1,
                                    pos="338.12,1183.8 366.97,1183.8 395.82,1183.8 424.67,1183.8",
                                    style=filled];
                                WAN	[fillcolor=transparent,
                                    height=2.2639,
                                    label=<<TABLE border='0' color='#000000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' fixedsize='true' width='153.6' height='153.6' colspan='1'><img src='Cloud.png'/></TD></TR></TABLE>>,
                                    pos="274,1498.5",
                                    shape=plain,
                                    width=2.2639];
                                WAN -> "Core-Router"	[color=black,
                                    fontcolor=black,
                                    fontsize=18,
                                    label="Serial0/0",
                                    lp="307,1351.5",
                                    minlen=2,
                                    pos="s,274,1417.1 e,274,1285.9 274,1406.4 274,1381.8 274,1362 274,1362 274,1362 274,1334 274,1300.1"];
                            }
                            "3tier"	[height=0.05,
                                label="",
                                pos="646,1498.5",
                                shape=point,
                                style=invis,
                                width=0.05];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="693,1498.5",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="740,1498.5",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```
    === "Example 13 - DraftMode"
        ```graphviz dot example13_draftmode.png
            digraph Root {
                graph [bb="0,0,874,1633.5",
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
                    graph [bb="8,8,866,1625.5",
                        color=red,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="855,26.625",
                        lwidth=0.08,
                        penwidth=1.5,
                        style=dashed
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,819,1617.5",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.16,
                            lp="417.5,1499.6",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="24,61.25,772,1373.8",
                                color=darkgray,
                                fontsize=22,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.39,
                                lp="398,1355.9",
                                lwidth=2.06,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            subgraph clusterSignature {
                                graph [bb="32,69.25,752,1330",
                                    color=darkgray,
                                    fontsize=22,
                                    label=<<TABLE STYLE="rounded,dashed" COLOR="red" border="2" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="left" colspan="1" rowspan="4">Signature_Logo.png</TD></TR><TR><TD valign="top" align="left" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000"><B>Author: Bugs Bunny</B></FONT></TD></TR><TR><TD valign="top" align="left" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000"><B>Company: ACME Inc.</B></FONT></TD></TR></TABLE>>,
                                    labeljust=right,
                                    labelloc=b,
                                    lheight=1.03,
                                    lp="555.62,110.25",
                                    lwidth=5.23,
                                    penwidth=1.5,
                                    style=invis
                                ];
                                {
                                    graph [rank=same];
                                    "App-Server-01"	[fillcolor=transparent,
                                        height=3.3056,
                                        label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>App-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Windows Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 2019</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 17763.3163</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                        pos="236,278.25",
                                        shape=plain,
                                        width=2.4479];
                                    "Db-Server-01"	[fillcolor=transparent,
                                        height=3.3056,
                                        label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Db-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Oracle Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 8</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 8.2</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                        pos="663,278.25",
                                        shape=plain,
                                        width=2.2604];
                                }
                                {
                                    graph [rank=same];
                                    "Core-Router"	[fillcolor=transparent,
                                        height=2.25,
                                        label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Router.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Core-Router</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Cisco IOS</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 15.2</FONT></TD></TR></TABLE>>,
                                        pos="392,1071.5",
                                        shape=plain,
                                        width=1.8438];
                                    RouterNetworkInfo	[fillcolor=lightblue,
                                        height=1.4826,
                                        label=<<TABLE STYLE="solid,rounded" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="20" COLOR="#000000">Interfaces Table</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">S0/0:</FONT></TD><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">164.42.203.10/30</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">G0/0:</FONT></TD><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.168.5.10/24</FONT></TD></TR></TABLE>>,
                                        pos="636,1071.5",
                                        shape=plain,
                                        style="filled,rounded",
                                        width=2.559];
                                }
                                Signature	[height=0.05,
                                    label="",
                                    pos="175,1302.8",
                                    shape=point,
                                    style=invis,
                                    width=0.05];
                                "Web-Server-Farm"	[fillcolor=transparent,
                                    height=3.8854,
                                    label=<<TABLE STYLE="dashed,rounded" PORT="EdgeDot" COLOR="red" border="1" cellborder="1" cellpadding="5" cellspacing="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="20"><B>Web Server Farm</B></FONT></TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_Ubuntu.png</FONT></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="392,719.62",
                                    shape=plain,
                                    width=9.7847];
                                "Web-Server-Farm" -> "App-Server-01"	[color=black,
                                    fontcolor=black,
                                    fontsize=14,
                                    label=gRPC,
                                    lp="330.12,488.5",
                                    minlen=3,
                                    pos="s,343.16,580.06 e,278.42,397.09 339.61,569.92 325.47,529.52 314,496.75 314,496.75 314,496.75 299.62,456.47 283.21,410.51"];
                                "App-Server-01" -> "Db-Server-01"	[color=black,
                                    fontcolor=black,
                                    fontsize=14,
                                    label=SQL,
                                    lp="452.88,289.5",
                                    minlen=3,
                                    pos="s,323.96,278.25 e,581.66,278.25 334.81,278.25 404.74,278.25 498.03,278.25 567.27,278.25"];
                                "Core-Router" -> "Web-Server-Farm"	[color=black,
                                    fontcolor=black,
                                    fontsize=18,
                                    label="GE0/0",
                                    lp="415.62,925",
                                    minlen=2,
                                    pos="s,392,990.82 e,392,859.39 392,980.03 392,955.43 392,935.5 392,935.5 392,935.5 392,908.53 392,873.65"];
                                "Core-Router" -> RouterNetworkInfo	[arrowhead=none,
                                    arrowtail=none,
                                    color=black,
                                    fontcolor=black,
                                    fontsize=18,
                                    minlen=1,
                                    pos="458.24,1071.5 486.83,1071.5 515.41,1071.5 544,1071.5",
                                    style=filled];
                                WAN	[fillcolor=transparent,
                                    height=0.53472,
                                    label=<<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='SOLID' ALIGN='Center' colspan='1'>Cloud.png</TD></TR></TABLE>>,
                                    pos="392,1302.8",
                                    shape=plain,
                                    width=1.0972];
                                WAN -> "Core-Router"	[color=black,
                                    fontcolor=black,
                                    fontsize=18,
                                    label="Serial0/0",
                                    lp="425,1218",
                                    minlen=2,
                                    pos="s,392,1283.6 e,392,1152.3 392,1272.7 392,1252.1 392,1228.5 392,1228.5 392,1228.5 392,1199.6 392,1166.6"];
                            }
                            "3tier"	[height=0.05,
                                label="",
                                pos="762,1302.8",
                                shape=point,
                                style=invis,
                                width=0.05];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="809,1302.8",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="856,1302.8",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```