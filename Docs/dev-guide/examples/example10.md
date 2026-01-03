---
comments: true
hide:
  - toc
---

This time, we'll demonstrate the use of the **`Add-DiaNodeImage`** (part of Diagrammer.Core module) to add a custom image to the diagram. The **`Add-DiaNodeImage`** function allows you to incorporate images into your diagrams, enhancing their visual appeal and providing additional context. In this example, we will add a network router and a cloud icon to represent internet connectivity.


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
[System.IO.FileInfo]$IconPath = Join-Path -Path $RootPath -ChildPath 'Icons'
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

In this section we demonstrates the use of the **`Add-DiaNodeImage`** to add a custom image to the diagram (Part of Diagrammer.Core module).

To improve the diagram, we will add a network router and a cloud icon to represent internet connectivity.

```powershell linenums="1" hl_lines="65-73" title="Example10.ps1 - Add-DiaNodeImage"
$example10 = & {
    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {

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

        # Adding a router icon to represent the network router using Add-DiaNodeIcon (part of Diagrammer.Core module).

        $RouterInfo = [PSCustomObject][ordered]@{
            'OS' = 'Cisco IOS'
            'Version' = '15.2'
        }

        $RouterLabel = Add-DiaNodeIcon -Name 'Core-Router' -AdditionalInfo $RouterInfo -ImagesObj $Images -IconType "Router" -Align "Center" -FontSize 18 -DraftMode:$DraftMode

        Node -Name Router01 -Attributes @{label = $RouterLabel ; shape = 'plain'; fillColor = 'transparent'; fontsize = 14 }

        Edge -From Router01 -To Web01 @{label = 'GE0/0'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2 }

        <#
            Adding a cloud icon to represent the WAN/Internet connection using Add-DiaNodeImage (part of Diagrammer.Core module).
            -Name parameter sets the name of the node (WAN in this case).
            -ImageSizePercent parameter sets the size of the image as a percentage (30% in this case).
        #>

        Add-DiaNodeImage -Name "WAN" -ImagesObj $Images -IconType "Cloud" -IconPath $IconPath -ImageSizePercent 30 -DraftMode:$DraftMode

        Edge -From WAN -To Router01 @{label = 'Serial0/0'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2 }
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example10 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example10 -LogoName "Main_Logo"  -DraftMode:$DraftMode
```

When you run the script, it generates a PNG file named Example10.png in the specified output folder.

**Resulting diagram:**

!!! example

    === "Example 10"
        ```graphviz dot example10.png
            digraph Root {
                graph [bb="0,0,703,1834",
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
                    graph [bb="8,8,695,1826",
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
                        graph [bb="16,53.25,648,1818",
                            fontsize=24,
                            label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.92,
                            lp="332,1672.9",
                            lwidth=4.64,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="24,61.25,628,1519.8",
                                color=darkgray,
                                fontsize=22,
                                label="3 Tier Concept",
                                labelloc=t,
                                lheight=0.39,
                                lp="326,1501.9",
                                lwidth=2.06,
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
                                pos="87,1394.5",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "Web-Server-Farm"	[fillcolor=transparent,
                                height=4.4201,
                                label=<<TABLE COLOR="gray" STYLE="dashed,rounded" PORT="EdgeDot" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui" POINT-SIZE="20" COLOR="#000000"><B>Web Server Farm</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_Ubuntu.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="266,687.38",
                                shape=plain,
                                width=6.5035];
                            "Web-Server-Farm" -> "App-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=gRPC,
                                lp="208.12,437",
                                minlen=3,
                                pos="s,217.47,528.58 e,160.94,345.46 214.33,518.3 201.83,477.42 192,445.25 192,445.25 192,445.25 179.74,405.85 165.2,359.14"];
                            "App-Server-01" -> "Db-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=SQL,
                                lp="332.88,218.75",
                                minlen=3,
                                pos="s,204.11,207.5 e,461.8,207.5 214.94,207.5 284.76,207.5 378.43,207.5 447.46,207.5"];
                            "Core-Router"	[fillcolor=transparent,
                                height=2.8403,
                                label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Router.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Core-Router</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Cisco IOS</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 15.2</FONT></TD></TR></TABLE>>,
                                pos="266,1079.8",
                                shape=plain,
                                width=1.7882];
                            "Core-Router" -> "Web-Server-Farm"	[color=black,
                                fontcolor=black,
                                fontsize=18,
                                label="GE0/0",
                                lp="289.62,912",
                                minlen=2,
                                pos="s,266,977.94 e,266,846.49 266,967.21 266,941.97 266,922.5 266,922.5 266,922.5 266,896.06 266,860.9"];
                            WAN	[fillcolor=transparent,
                                height=2.2639,
                                label=<<TABLE border='0' color='#000000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' fixedsize='true' width='153.6' height='153.6' colspan='1'><img src='Cloud.png'/></TD></TR></TABLE>>,
                                pos="266,1394.5",
                                shape=plain,
                                width=2.2639];
                            WAN -> "Core-Router"	[color=black,
                                fontcolor=black,
                                fontsize=18,
                                label="Serial0/0",
                                lp="299,1247.5",
                                minlen=2,
                                pos="s,266,1313.1 e,266,1181.9 266,1302.4 266,1277.8 266,1258 266,1258 266,1258 266,1230 266,1196.1"];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="638,1394.5",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="685,1394.5",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```
    === "Example 10 - Draft Mode"

        ```graphviz dot example10_draftmode.png
        digraph Root {
            graph [bb="0,0,819,1535.5",
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
                graph [bb="8,8,811,1527.5",
                    color=red,
                    fontsize=24,
                    label=" ",
                    labeljust=r,
                    labelloc=b,
                    lheight=0.41,
                    lp="800,26.625",
                    lwidth=0.08,
                    penwidth=1.5,
                    style=dashed
                ];
                subgraph clusterMainGraph {
                    graph [bb="16,53.25,764,1519.5",
                        fontsize=24,
                        label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                        labeljust=c,
                        labelloc=t,
                        lheight=3.16,
                        lp="390,1401.6",
                        lwidth=4.64,
                        penwidth=0
                    ];
                    subgraph cluster3tier {
                        graph [bb="24,61.25,744,1275.8",
                            color=darkgray,
                            fontsize=22,
                            label="3 Tier Concept",
                            labelloc=t,
                            lheight=0.39,
                            lp="384,1257.9",
                            lwidth=2.06,
                            penwidth=1.5,
                            style="dashed,rounded"
                        ];
                        {
                            graph [rank=same];
                            "App-Server-01"	[fillcolor=transparent,
                                height=3.3056,
                                label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>App-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Windows Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 2019</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 17763.3163</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                pos="228,188.25",
                                shape=plain,
                                width=2.4479];
                            "Db-Server-01"	[fillcolor=transparent,
                                height=3.3056,
                                label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Db-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Oracle Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 8</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 8.2</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                pos="655,188.25",
                                shape=plain,
                                width=2.2604];
                        }
                        "3tier"	[height=0.05,
                            label="",
                            pos="167,1212.8",
                            shape=point,
                            style=invis,
                            width=0.05];
                        "Web-Server-Farm"	[fillcolor=transparent,
                            height=3.8854,
                            label=<<TABLE STYLE="dashed,rounded" PORT="EdgeDot" COLOR="red" border="1" cellborder="1" cellpadding="5" cellspacing="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="20"><B>Web Server Farm</B></FONT></TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_Ubuntu.png</FONT></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                            pos="384,629.62",
                            shape=plain,
                            width=9.7847];
                        "Web-Server-Farm" -> "App-Server-01"	[color=black,
                            fontcolor=black,
                            fontsize=14,
                            label=gRPC,
                            lp="322.12,398.5",
                            minlen=3,
                            pos="s,335.16,490.06 e,270.42,307.09 331.61,479.92 317.47,439.52 306,406.75 306,406.75 306,406.75 291.62,366.47 275.21,320.51"];
                        "App-Server-01" -> "Db-Server-01"	[color=black,
                            fontcolor=black,
                            fontsize=14,
                            label=SQL,
                            lp="444.88,199.5",
                            minlen=3,
                            pos="s,315.96,188.25 e,573.66,188.25 326.81,188.25 396.74,188.25 490.03,188.25 559.27,188.25"];
                        "Core-Router"	[fillcolor=transparent,
                            height=2.25,
                            label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Router.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Core-Router</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Cisco IOS</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 15.2</FONT></TD></TR></TABLE>>,
                            pos="384,981.5",
                            shape=plain,
                            width=1.8438];
                        "Core-Router" -> "Web-Server-Farm"	[color=black,
                            fontcolor=black,
                            fontsize=18,
                            label="GE0/0",
                            lp="407.62,835",
                            minlen=2,
                            pos="s,384,900.82 e,384,769.39 384,890.03 384,865.43 384,845.5 384,845.5 384,845.5 384,818.53 384,783.65"];
                        WAN	[fillcolor=transparent,
                            height=0.53472,
                            label=<<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='SOLID' ALIGN='Center' colspan='1'>Cloud.png</TD></TR></TABLE>>,
                            pos="384,1212.8",
                            shape=plain,
                            width=1.0972];
                        WAN -> "Core-Router"	[color=black,
                            fontcolor=black,
                            fontsize=18,
                            label="Serial0/0",
                            lp="417,1128",
                            minlen=2,
                            pos="s,384,1193.6 e,384,1062.3 384,1182.7 384,1162.1 384,1138.5 384,1138.5 384,1138.5 384,1109.6 384,1076.6"];
                    }
                    MainGraph	[height=0.05,
                        label="",
                        pos="754,1212.8",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
                OUTERDRAWBOARD1	[height=0.05,
                    label="",
                    pos="801,1212.8",
                    shape=point,
                    style=invis,
                    width=0.05];
            }
        }
        ```