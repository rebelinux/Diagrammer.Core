---
comments: true
hide:
  - toc
---

This example demonstrates how to use the **`Add-DiaNodeSpacer`** (part of Diagrammer.Core) cmdlet to add spacer nodes that assist with diagram alignment.

The `Add-DiaNodeSpacer` cmdlet allows you to insert invisible spacer nodes into your diagram. These spacer nodes do not appear in the final output but play a crucial role in controlling the alignment and spacing of visible nodes. By strategically placing spacer nodes, you can resolve layout issues—such as centering or evenly distributing nodes—ensuring your diagram appears balanced and visually organized.

```powershell title="PowerShell: Example1.ps1 - param block"
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

In this diagram there is a alignment issue with the Web01 node, as it is not centered with the App01 and DB01 nodes below it. To fix this, we create two spacer nodes (FillerRight and FillerLeft) on either side of the Web01 node.

The `Add-DiaNodeSpacer` cmdlet is used to create invisible spacer nodes that help with diagram alignment (Part of Diagrammer.Core module).

:material-powershell:
```powershell linenums="1" hl_lines="104-119" title="Example15.ps1 - Add-DiaNodeSpacer"
$example15 = & {
    SubGraph 3tier -Attributes @{Label = '3 Tier Concept'; fontsize = 18; penwidth = 1.5; labelloc = 't'; style = "dashed,rounded"; color = "gray" } {

        $Signature = Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows "Author: Bugs Bunny", "Company: ACME Inc." -TableBorder 2 -CellBorder 0 -Align 'left' -Logo "Logo_Footer" -DraftMode:$DraftMode

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

            Add-DiaNodeShape -Name "Firewall" -Shape rectangle -ShapeStyle 'filled' -ShapeFillColor 'red:white' -ShapeFontSize 14 -ShapeFontColor 'black' -ShapeFontName 'Arial' -ShapeWidth 3 -ShapeLabelPosition center -ShapeLineColor 'black' -DraftMode:$DraftMode

            # An edge is created from WAN to Firewall and from Firewall to Router01

            Edge -From WAN -To Firewall @{labeldistance = 5; headlabel = 'port1'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2; arrowhead = 'normal'; arrowtail = 'normal' }
            Edge -From Firewall -To Router01 @{labeldistance = 4; headlabel = 'Serial0/0'; taillabel = 'port2'; color = 'black'; fontsize = 18; fontcolor = 'black'; minlen = 2; arrowhead = 'normal'; arrowtail = 'normal' }

            <#
                In this example, we create two spacer nodes to help align the web server node.

                -Name parameter sets the name of the spacer node.
                -ShapeWidth parameter sets the width of the spacer node.
                -ShapeHeight parameter sets the height of the spacer node.
                -ShapeOrientation parameter sets the orientation of the spacer node (0 for horizontal, 1 for vertical).
                -DraftMode parameter specifies whether the node is in draft mode.

                The rank command is used to align the spacer nodes and the web server node horizontally.
                The edge commands create invisible edges between the spacer nodes and the web server node to maintain alignment.
            #>

            Add-DiaNodeSpacer -Name "SpaceRight" -ShapeWidth 2 -ShapeHeight 1 -ShapeOrientation 0 -DraftMode:$DraftMode
            Add-DiaNodeSpacer -Name "SpaceLeft" -ShapeWidth 2 -ShapeHeight 1 -ShapeOrientation 0 -DraftMode:$DraftMode

            # The Rank command is used to align the spacer nodes and the web server node horizontally.

            Rank -Nodes SpaceLeft, Web01, SpaceRight

            # An invisible edge is created from SpaceLeft to Web01 and from Web01 to SpaceRight to maintain alignment.

            $Style = if ($DraftMode) { 'filled' } else { 'invis' }
            $StyleColor = if ($DraftMode) { 'red' } else { 'transparent' }

            # The edge style is set to 'invis' for normal mode and 'filled' for draft mode, with corresponding colors.

            Edge -From SpaceLeft -To Web01 @{minlen = 2; style = $Style; color = $StyleColor; }
            Edge -From Web01 -To SpaceRight @{minlen = 2; style = $Style; color = $StyleColor; }
        }
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $example15 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example15 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -WaterMarkText "Confidential" -WaterMarkColor "DarkGray" -WaterMarkFontOpacity 40 -DraftMode:$DraftMode
```
When you run the script, it generates a PNG file named Example15.png in the specified output folder.

**Resulting Diagrams:**

!!! example

    === "Example 15"

        ```graphviz dot example15.png
        digraph Root {
            graph [bb="0,0,1270,2073",
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
                graph [bb="8,8,1262,2065",
                    color=gray,
                    fontsize=24,
                    label=" ",
                    labeljust=r,
                    labelloc=b,
                    lheight=0.41,
                    lp="1251,26.625",
                    lwidth=0.08,
                    penwidth=1.5,
                    style=invis
                ];
                subgraph clusterMainGraph {
                    graph [bb="16,53.25,1215,2057",
                        fontsize=24,
                        label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="24" COLOR="#000000">Web Application Diagram</FONT></TD></TR></TABLE>>,
                        labeljust=c,
                        labelloc=t,
                        lheight=3.92,
                        lp="615.5,1911.9",
                        lwidth=4.64,
                        penwidth=0
                    ];
                    subgraph cluster3tier {
                        graph [bb="24,61.25,1168,1758.8",
                            color=darkgray,
                            fontsize=22,
                            label="3 Tier Concept",
                            labelloc=t,
                            lheight=0.39,
                            lp="596,1740.9",
                            lwidth=2.06,
                            penwidth=1.5,
                            style="dashed,rounded"
                        ];
                        subgraph clusterSignature {
                            graph [bb="32,69.25,1148,1715",
                                color=darkgray,
                                fontsize=22,
                                label=<<TABLE STYLE="rounded,dashed" border="2" cellborder="0" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="left" colspan="1" rowspan="4"><img src="Signature_Logo.png"/></TD></TR><TR><TD valign="top" align="left" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000"><B>Author: Bugs Bunny</B></FONT></TD></TR><TR><TD valign="top" align="left" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000"><B>Company: ACME Inc.</B></FONT></TD></TR></TABLE>>,
                                labeljust=right,
                                labelloc=b,
                                lheight=1.22,
                                lp="1018.8,117.25",
                                lwidth=3.37,
                                penwidth=1.5,
                                style=invis
                            ];
                            {
                                graph [rank=same];
                                "App-Server-01"	[fillcolor=transparent,
                                    height=3.8403,
                                    label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>App-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Windows Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 2019</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 17763.3163</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                    pos="590,311.5",
                                    shape=plain,
                                    width=2.3924];
                                "Db-Server-01"	[fillcolor=transparent,
                                    height=3.8403,
                                    label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Server.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Db-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Oracle Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 8</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 8.2</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="1013,311.5",
                                    shape=plain,
                                    width=2.2049];
                            }
                            {
                                graph [rank=same];
                                "Core-Router"	[fillcolor=transparent,
                                    height=2.8403,
                                    label=<<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="Router.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Core-Router</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Cisco IOS</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 15.2</FONT></TD></TR></TABLE>>,
                                    pos="590,1183.8",
                                    shape=plain,
                                    width=1.7882];
                                RouterNetworkInfo	[fillcolor=lightblue,
                                    height=1.566,
                                    label=<<TABLE COLOR="black" STYLE="solid,rounded" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="center" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="20" COLOR="#000000"><U><B>Interfaces Table</B></U></FONT></TD></TR><TR><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">S0/0:</FONT></TD><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">164.42.203.10/30</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">G0/0:</FONT></TD><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.168.5.10/24</FONT></TD></TR></TABLE>>,
                                    pos="835,1183.8",
                                    shape=plain,
                                    style="filled,rounded",
                                    width=2.6285];
                            }
                            {
                                graph [rank=same];
                                "Web-Server-Farm"	[fillcolor=transparent,
                                    height=4.4201,
                                    label=<<TABLE COLOR="gray" STYLE="dashed,rounded" PORT="EdgeDot" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui" POINT-SIZE="20" COLOR="#000000"><B>Web Server Farm</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_Ubuntu.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="590,791.38",
                                    shape=plain,
                                    width=6.5035];
                                SpaceRight	[color=black,
                                    fillcolor=transparent,
                                    height=1,
                                    label=SpaceRight,
                                    labelloc=c,
                                    orientation=0,
                                    penwidth=1,
                                    pos="1068,791.38",
                                    shape=rectangle,
                                    style=invis,
                                    width=2];
                                SpaceLeft	[color=black,
                                    fillcolor=transparent,
                                    height=1,
                                    label=SpaceLeft,
                                    labelloc=c,
                                    orientation=0,
                                    penwidth=1,
                                    pos="112,791.38",
                                    shape=rectangle,
                                    style=invis,
                                    width=2];
                            }
                            Signature	[height=0.05,
                                label="",
                                pos="253,1625.5",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "Web-Server-Farm" -> "App-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=gRPC,
                                lp="606.12,541",
                                minlen=3,
                                pos="s,590,632.58 e,590,449.46 590,621.78 590,581.14 590,549.25 590,549.25 590,549.25 590,510.19 590,463.74"];
                            "Web-Server-Farm" -> SpaceRight	[color=transparent,
                                minlen=2,
                                pos="s,823.87,791.38 e,995.52,791.38 834.59,791.38 883.42,791.38 932.24,791.38 981.06,791.38",
                                style=invis];
                            "App-Server-01" -> "Db-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=SQL,
                                lp="804.88,322.75",
                                minlen=3,
                                pos="s,676.11,311.5 e,933.8,311.5 686.94,311.5 756.76,311.5 850.43,311.5 919.46,311.5"];
                            "Core-Router" -> "Web-Server-Farm"	[color=black,
                                fontcolor=black,
                                fontsize=18,
                                label="GE0/0",
                                lp="613.62,1016",
                                minlen=2,
                                pos="s,590,1081.9 e,590,950.49 590,1071.2 590,1046 590,1026.5 590,1026.5 590,1026.5 590,1000.1 590,964.9"];
                            "Core-Router" -> RouterNetworkInfo	[arrowhead=none,
                                arrowtail=none,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                minlen=1,
                                pos="654.12,1183.8 682.97,1183.8 711.82,1183.8 740.67,1183.8",
                                style=filled];
                            WAN	[fillcolor=transparent,
                                height=2.2639,
                                label=<<TABLE border='0' color='#000000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' fixedsize='true' width='153.6' height='153.6' colspan='1'><img src='Cloud.png'/></TD></TR></TABLE>>,
                                pos="590,1625.5",
                                shape=plain,
                                width=2.2639];
                            Firewall	[color=black,
                                fillcolor="red:white",
                                fontcolor=black,
                                fontname=Arial,
                                height=0.5,
                                label=Firewall,
                                labelloc=c,
                                orientation=0,
                                penwidth=1,
                                pos="590,1415",
                                shape=rectangle,
                                width=3];
                            WAN -> Firewall	[arrowhead=normal,
                                arrowtail=normal,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                head_lp="611.13,1478.8",
                                headlabel=port1,
                                labeldistance=5,
                                minlen=2,
                                pos="s,590,1544.1 e,590,1433.4 590,1529.7 590,1500.4 590,1470 590,1447.9"];
                            Firewall -> "Core-Router"	[arrowhead=normal,
                                arrowtail=normal,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                head_lp="606.9,1322.1",
                                headlabel="Serial0/0",
                                labeldistance=4,
                                minlen=2,
                                pos="s,590,1396.9 e,590,1285.9 590,1382.3 590,1360.5 590,1330.4 590,1300.2",
                                tail_lp="573.1,1360.6",
                                taillabel=port2];
                            SpaceLeft -> "Web-Server-Farm"	[color=transparent,
                                minlen=2,
                                pos="s,184.35,791.38 e,355.88,791.38 195.07,791.38 243.86,791.38 292.65,791.38 341.43,791.38",
                                style=invis];
                        }
                        "3tier"	[height=0.05,
                            label="",
                            pos="1158,1625.5",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    MainGraph	[height=0.05,
                        label="",
                        pos="1205,1625.5",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
                OUTERDRAWBOARD1	[height=0.05,
                    label="",
                    pos="1252,1625.5",
                    shape=point,
                    style=invis,
                    width=0.05];
            }
        }
        ```
    === "Example 15 - DraftMode"

        ```graphviz dot example15_draftmode.png
        digraph Root {
            graph [bb="0,0,1506,1760.5",
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
                graph [bb="8,8,1498,1752.5",
                    color=red,
                    fontsize=24,
                    label=" ",
                    labeljust=r,
                    labelloc=b,
                    lheight=0.41,
                    lp="1487,26.625",
                    lwidth=0.08,
                    penwidth=1.5,
                    style=dashed
                ];
                subgraph clusterMainGraph {
                    graph [bb="16,53.25,1451,1744.5",
                        fontsize=24,
                        label=<<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="24">Web Application Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>>,
                        labeljust=c,
                        labelloc=t,
                        lheight=3.16,
                        lp="733.5,1626.6",
                        lwidth=4.64,
                        penwidth=0
                    ];
                    subgraph cluster3tier {
                        graph [bb="24,61.25,1404,1500.8",
                            color=darkgray,
                            fontsize=22,
                            label="3 Tier Concept",
                            labelloc=t,
                            lheight=0.39,
                            lp="714,1482.9",
                            lwidth=2.06,
                            penwidth=1.5,
                            style="dashed,rounded"
                        ];
                        subgraph clusterSignature {
                            graph [bb="32,69.25,1384,1457",
                                color=darkgray,
                                fontsize=22,
                                label=<<TABLE STYLE="rounded,dashed" COLOR="red" border="2" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="left" colspan="1" rowspan="4">Signature_Logo.png</TD></TR><TR><TD valign="top" align="left" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000"><B>Author: Bugs Bunny</B></FONT></TD></TR><TR><TD valign="top" align="left" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000"><B>Company: ACME Inc.</B></FONT></TD></TR></TABLE>>,
                                labeljust=right,
                                labelloc=b,
                                lheight=1.03,
                                lp="1187.6,110.25",
                                lwidth=5.23,
                                penwidth=1.5,
                                style=invis
                            ];
                            {
                                graph [rank=same];
                                "App-Server-01"	[fillcolor=transparent,
                                    height=3.3056,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>App-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Windows Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 2019</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 17763.3163</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                    pos="708,278.25",
                                    shape=plain,
                                    width=2.4479];
                                "Db-Server-01"	[fillcolor=transparent,
                                    height=3.3056,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Server.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Db-Server-01</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Oracle Server</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 8</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Build: 8.2</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="1135,278.25",
                                    shape=plain,
                                    width=2.2604];
                            }
                            {
                                graph [rank=same];
                                "Core-Router"	[fillcolor=transparent,
                                    height=2.25,
                                    label=<<TABLE color="red" border="1" cellborder="1" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Router.png</FONT></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Core-Router</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">OS: Cisco IOS</FONT></TD></TR> <TR><TD align="Center" colspan="1"><FONT POINT-SIZE="18">Version: 15.2</FONT></TD></TR></TABLE>>,
                                    pos="708,1071.5",
                                    shape=plain,
                                    width=1.8438];
                                RouterNetworkInfo	[fillcolor=lightblue,
                                    height=1.4826,
                                    label=<<TABLE STYLE="solid,rounded" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="20" COLOR="#000000"><U><B>Interfaces Table</B></U></FONT></TD></TR><TR><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">S0/0:</FONT></TD><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">164.42.203.10/30</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">G0/0:</FONT></TD><TD align="center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.168.5.10/24</FONT></TD></TR></TABLE>>,
                                    pos="952,1071.5",
                                    shape=plain,
                                    style="filled,rounded",
                                    width=2.559];
                            }
                            {
                                graph [rank=same];
                                "Web-Server-Farm"	[fillcolor=transparent,
                                    height=3.8854,
                                    label=<<TABLE STYLE="dashed,rounded" PORT="EdgeDot" COLOR="red" border="1" cellborder="1" cellpadding="5" cellspacing="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="20"><B>Web Server Farm</B></FONT></TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_RedHat.png</FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="18">Linux_Server_Ubuntu.png</FONT></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="18" COLOR="#000000"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="708,719.62",
                                    shape=plain,
                                    width=9.7847];
                                SpaceRight	[color=red,
                                    fillcolor="#FFCCCC",
                                    height=1,
                                    label=SpaceRight,
                                    labelloc=c,
                                    orientation=0,
                                    penwidth=1,
                                    pos="1304,719.62",
                                    shape=rectangle,
                                    width=2];
                                SpaceLeft	[color=red,
                                    fillcolor="#FFCCCC",
                                    height=1,
                                    label=SpaceLeft,
                                    labelloc=c,
                                    orientation=0,
                                    penwidth=1,
                                    pos="112,719.62",
                                    shape=rectangle,
                                    width=2];
                            }
                            Signature	[height=0.05,
                                label="",
                                pos="333,1429.8",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "Web-Server-Farm" -> "App-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=gRPC,
                                lp="724.12,488.5",
                                minlen=3,
                                pos="s,708,580.06 e,708,397.09 708,569.15 708,529.1 708,496.75 708,496.75 708,496.75 708,456.99 708,411.39"];
                            "Web-Server-Farm" -> SpaceRight	[color=red,
                                minlen=2,
                                pos="s,1060.1,719.62 e,1231.6,719.62 1070.8,719.62 1119.6,719.62 1168.4,719.62 1217.2,719.62",
                                style=filled];
                            "App-Server-01" -> "Db-Server-01"	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=SQL,
                                lp="924.88,289.5",
                                minlen=3,
                                pos="s,795.96,278.25 e,1053.7,278.25 806.81,278.25 876.74,278.25 970.03,278.25 1039.3,278.25"];
                            "Core-Router" -> "Web-Server-Farm"	[color=black,
                                fontcolor=black,
                                fontsize=18,
                                label="GE0/0",
                                lp="731.62,925",
                                minlen=2,
                                pos="s,708,990.82 e,708,859.39 708,980.03 708,955.43 708,935.5 708,935.5 708,935.5 708,908.53 708,873.65"];
                            "Core-Router" -> RouterNetworkInfo	[arrowhead=none,
                                arrowtail=none,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                minlen=1,
                                pos="774.24,1071.5 802.83,1071.5 831.41,1071.5 860,1071.5",
                                style=filled];
                            WAN	[fillcolor=transparent,
                                height=0.53472,
                                label=<<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='SOLID' ALIGN='Center' colspan='1'>Cloud.png</TD></TR></TABLE>>,
                                pos="708,1429.8",
                                shape=plain,
                                width=1.0972];
                            Firewall	[color=red,
                                fillcolor="red:white",
                                fontcolor=black,
                                fontname=Arial,
                                height=0.5,
                                label=Firewall,
                                labelloc=c,
                                orientation=0,
                                penwidth=1,
                                pos="708,1281.5",
                                shape=rectangle,
                                width=3];
                            WAN -> Firewall	[arrowhead=normal,
                                arrowtail=normal,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                head_lp="729.13,1344.9",
                                headlabel=port1,
                                labeldistance=5,
                                minlen=2,
                                pos="s,708,1410.7 e,708,1299.6 708,1396.3 708,1371.7 708,1338.2 708,1313.8"];
                            Firewall -> "Core-Router"	[arrowhead=normal,
                                arrowtail=normal,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                head_lp="724.9,1188.4",
                                headlabel="Serial0/0",
                                labeldistance=4,
                                minlen=2,
                                pos="s,708,1263.2 e,708,1152.1 708,1248.7 708,1226.5 708,1196 708,1166.5",
                                tail_lp="691.1,1227",
                                taillabel=port2];
                            SpaceLeft -> "Web-Server-Farm"	[color=red,
                                minlen=2,
                                pos="s,184.46,719.62 e,355.99,719.62 195.18,719.62 243.97,719.62 292.76,719.62 341.55,719.62",
                                style=filled];
                        }
                        "3tier"	[height=0.05,
                            label="",
                            pos="1394,1429.8",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    MainGraph	[height=0.05,
                        label="",
                        pos="1441,1429.8",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
                OUTERDRAWBOARD1	[height=0.05,
                    label="",
                    pos="1488,1429.8",
                    shape=point,
                    style=invis,
                    width=0.05];
            }
        }
        ```