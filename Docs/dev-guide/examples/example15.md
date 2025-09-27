---
comments: true
hide:
  - toc
---

This example demonstrates how to use the Add-DiaNodeSpacer (part of Diagrammer.Core) cmdlet to add spacer nodes that assist with diagram alignment.

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
[System.IO.FileInfo]$IconPath = Join-Path $RootPath 'icons'
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

The Add-DiaNodeSpacer cmdlet is used to create invisible spacer nodes that help with diagram alignment (Part of Diagrammer.Core module).

```powershell
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

            Add-DiaHTMLTable -Name 'RouterNetworkInfo' -Rows $RouterNetworkInfo -NodeObject -ColumnSize 2 -TableBorder 1 -TableBorderColor "black" -FontSize 14 -Subgraph -SubgraphLabel "Interfaces Table" -SubgraphLabelPos "top" -SubgraphTableStyle "solid,rounded" -SubgraphLabelFontsize 20 -GraphvizAttributes @{style = 'filled,rounded'; fillcolor = 'lightblue' } -DraftMode:$DraftMode

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

    === "Example 15 - DraftMode"

        ```graphviz dot example15_draftmode.png
        digraph Root {
            graph [bb="0,0,1186,1849",
                bgcolor=White,
                compound=true,
                fontcolor="#565656",
                fontname="Segoe Ui Black",
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
                graph [bb="8,8,1178,1841",
                    color=red,
                    fontsize=24,
                    label=" ",
                    labeljust=r,
                    labelloc=b,
                    lheight=0.47,
                    lp="1166.6,28.875",
                    lwidth=0.09,
                    penwidth=1.5,
                    style=dashed
                ];
                subgraph clusterMainGraph {
                    graph [bb="16,57.75,1170,1833",
                        fontsize=24,
                        label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='20'><TR><TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'>Main Logo</TD></TR><TR><TD bgcolor='#FFCCCC' ALIGN='center' ><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR><TR><TD ALIGN='center'><font color='red'>Debug ON</font></TD></TR></TABLE>>,
                        labeljust=c,
                        labelloc=t,
                        lheight=4.18,
                        lp="593,1678.4",
                        lwidth=5.37,
                        penwidth=0
                    ];
                    subgraph cluster3tier {
                        graph [bb="24,65.75,1162,1515.8",
                            color=darkgray,
                            fontsize=22,
                            label="3 Tier Concept",
                            labelloc=t,
                            lheight=0.43,
                            lp="593,1496.4",
                            lwidth=2.17,
                            penwidth=1.5,
                            style="dashed,rounded"
                        ];
                        subgraph clusterSignature {
                            graph [bb="32,73.75,1154,1469",
                                color=darkgray,
                                fontsize=22,
                                label=<<TABLE STYLE="rounded,dashed" COLOR="red" border="2" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="left" colspan="1" rowspan="4">Logo</TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Author: Bugs Bunny</FONT></B></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Company: ACME Inc.</FONT></B></TD></TR></TABLE>>,
                                labeljust=right,
                                labelloc=b,
                                lheight=1.07,
                                lp="1033.8,116.25",
                                lwidth=3.12,
                                penwidth=1.5,
                                style=invis
                            ];
                            {
                                graph [rank=same];
                                App01	[fillcolor=transparent,
                                    height=3.316,
                                    label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>App-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Windows Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 2019</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 17763.3163</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                    pos="593,286.12",
                                    shape=plain,
                                    width=2.4479];
                                DB01	[fillcolor=transparent,
                                    height=3.316,
                                    label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="1020,286.12",
                                    shape=plain,
                                    width=2.2604];
                            }
                            {
                                graph [rank=same];
                                Router01	[fillcolor=transparent,
                                    height=2.2604,
                                    label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Core-Router</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Cisco IOS</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 15.2</FONT></TD></TR></TABLE>>,
                                    pos="593,1083.1",
                                    shape=plain,
                                    width=1.8125];
                                RouterNetworkInfo	[fillcolor=lightblue,
                                    height=1.3681,
                                    label=<<TABLE STYLE="solid,rounded" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="2"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="14"><B>Interfaces Table</B></FONT></TD></TR><TR><TD align="center" colspan="1"><FONT POINT-SIZE="14">S0/0:</FONT></TD><TD align="center" colspan="1"><FONT POINT-SIZE="14">164.42.203.10/30</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT POINT-SIZE="14">G0/0:</FONT></TD><TD align="center" colspan="1"><FONT POINT-SIZE="14">192.168.5.10/24</FONT></TD></TR></TABLE>>,
                                    pos="823,1083.1",
                                    shape=plain,
                                    style="filled,rounded",
                                    width=2.2049];
                            }
                            {
                                graph [rank=same];
                                Web01	[fillcolor=transparent,
                                    height=3.9271,
                                    label=<<TABLE STYLE="dashed,rounded" PORT="EdgeDot" COLOR="red" border="1" cellborder="1" cellpadding="5" cellspacing="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="20"><B>Web Server Farm</B></FONT></TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="18"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="18"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="18"><B>Icon</B></FONT></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="593,729.38",
                                    shape=plain,
                                    width=6.5868];
                                SpaceRight	[color=red,
                                    fillcolor="#FFCCCC",
                                    height=1,
                                    label=SpaceRight,
                                    labelloc=c,
                                    orientation=0,
                                    penwidth=1,
                                    pos="1074,729.38",
                                    shape=rectangle,
                                    width=2];
                                SpaceLeft	[color=red,
                                    fillcolor="#FFCCCC",
                                    height=1,
                                    label=SpaceLeft,
                                    labelloc=c,
                                    orientation=0,
                                    penwidth=1,
                                    pos="112,729.38",
                                    shape=rectangle,
                                    width=2];
                            }
                            Web01 -> App01	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=gRPC,
                                lp="609.12,496.75",
                                minlen=3,
                                pos="s,593,588.23 e,593,405.49 593,577.32 593,537.26 593,505 593,505 593,505 593,465.34 593,419.78"];
                            Web01 -> SpaceRight	[color=red,
                                minlen=2,
                                pos="s,829.74,729.38 e,1002,729.38 840.51,729.38 889.49,729.38 938.47,729.38 987.46,729.38",
                                style=filled];
                            App01 -> DB01	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=SQL,
                                lp="809.88,297.38",
                                minlen=3,
                                pos="s,680.96,286.12 e,938.66,286.12 691.81,286.12 761.74,286.12 855.03,286.12 924.27,286.12"];
                            Router01 -> Web01	[color=black,
                                fontcolor=black,
                                fontsize=18,
                                label="GE0/0",
                                lp="616.62,936.25",
                                minlen=2,
                                pos="s,593,1001.8 e,593,870.72 593,991.07 593,966.56 593,946.75 593,946.75 593,946.75 593,919.86 593,884.99"];
                            Router01 -> RouterNetworkInfo	[arrowhead=none,
                                arrowtail=none,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                minlen=1,
                                pos="658.14,1083.1 686.69,1083.1 715.24,1083.1 743.79,1083.1",
                                style=filled];
                            WAN	[fillcolor=transparent,
                                height=0.53472,
                                label=<<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='SOLID' ALIGN='Center' colspan='1'>WAN Image</TD></TR></TABLE>>,
                                pos="593,1441.8",
                                shape=plain,
                                width=1.2743];
                            Firewall	[color=red,
                                fillcolor="red:white",
                                fontcolor=black,
                                fontname=Arial,
                                height=0.5,
                                label=Firewall,
                                labelloc=c,
                                orientation=0,
                                penwidth=1,
                                pos="593,1293.5",
                                shape=rectangle,
                                width=3];
                            WAN -> Firewall	[arrowhead=normal,
                                arrowtail=normal,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                head_lp="614.13,1356.9",
                                headlabel=port1,
                                labeldistance=5,
                                minlen=2,
                                pos="s,593,1422.7 e,593,1311.6 593,1408.3 593,1383.7 593,1350.2 593,1325.8"];
                            Firewall -> Router01	[arrowhead=normal,
                                arrowtail=normal,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                head_lp="609.9,1200.6",
                                headlabel="Serial0/0",
                                labeldistance=4,
                                minlen=2,
                                pos="s,593,1275.2 e,593,1164.4 593,1260.7 593,1238.6 593,1208.2 593,1178.7",
                                tail_lp="576.1,1238.9",
                                taillabel=port2];
                            SpaceLeft -> Web01	[color=red,
                                minlen=2,
                                pos="s,184.34,729.38 e,355.94,729.38 195.06,729.38 243.87,729.38 292.68,729.38 341.49,729.38",
                                style=filled];
                        }
                    }
                }
            }
        }
        ```
    === "Example 15"

        ```graphviz dot example15.png
        digraph Root {
            graph [bb="0,0,1180,2082.8",
                bgcolor=White,
                compound=true,
                fontcolor="#565656",
                fontname="Segoe Ui Black",
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
                graph [bb="8,8,1172,2074.8",
                    color=gray,
                    fontsize=24,
                    label=" ",
                    labeljust=r,
                    labelloc=b,
                    lheight=0.47,
                    lp="1160.6,28.875",
                    lwidth=0.09,
                    penwidth=1.5,
                    style=invis
                ];
                subgraph clusterMainGraph {
                    graph [bb="16,57.75,1164,2066.8",
                        fontsize=24,
                        label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Docs/Icons/Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,
                        labeljust=c,
                        labelloc=t,
                        lheight=3.98,
                        lp="590,1919.4",
                        lwidth=5.09,
                        penwidth=0
                    ];
                    subgraph cluster3tier {
                        graph [bb="24,65.75,1156,1764",
                            color=darkgray,
                            fontsize=22,
                            label="3 Tier Concept",
                            labelloc=t,
                            lheight=0.43,
                            lp="590,1744.6",
                            lwidth=2.17,
                            penwidth=1.5,
                            style="dashed,rounded"
                        ];
                        subgraph clusterSignature {
                            graph [bb="32,73.75,1148,1717.2",
                                color=darkgray,
                                fontsize=22,
                                label=<<TABLE STYLE="rounded,dashed" border="2" cellborder="0" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="left" colspan="1" rowspan="4"><img src="Docs/Icons/Signature_Logo.png"/></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Author: Bugs Bunny</FONT></B></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Company: ACME Inc.</FONT></B></TD></TR></TABLE>>,
                                labeljust=right,
                                labelloc=b,
                                lheight=1.22,
                                lp="1022.1,121.75",
                                lwidth=3.27,
                                penwidth=1.5,
                                style=invis
                            ];
                            {
                                graph [rank=same];
                                App01	[fillcolor=transparent,
                                    height=3.8194,
                                    label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>App-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Windows Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 2019</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 17763.3163</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Datacenter</FONT></TD></TR></TABLE>>,
                                    pos="590,315.25",
                                    shape=plain,
                                    width=2.3924];
                                DB01	[fillcolor=transparent,
                                    height=3.8194,
                                    label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="1013,315.25",
                                    shape=plain,
                                    width=2.2049];
                            }
                            {
                                graph [rank=same];
                                Router01	[fillcolor=transparent,
                                    height=2.8194,
                                    label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Router.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Core-Router</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Cisco IOS</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 15.2</FONT></TD></TR></TABLE>>,
                                    pos="590,1186.8",
                                    shape=plain,
                                    width=1.7569];
                                RouterNetworkInfo	[fillcolor=lightblue,
                                    height=1.4514,
                                    label=<<TABLE COLOR="black" STYLE="solid,rounded" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="center" colspan="2"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="14"><B>Interfaces Table</B></FONT></TD></TR><TR><TD align="center" colspan="1"><FONT POINT-SIZE="14">S0/0:</FONT></TD><TD align="center" colspan="1"><FONT POINT-SIZE="14">164.42.203.10/30</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT POINT-SIZE="14">G0/0:</FONT></TD><TD align="center" colspan="1"><FONT POINT-SIZE="14">192.168.5.10/24</FONT></TD></TR></TABLE>>,
                                    pos="821,1186.8",
                                    shape=plain,
                                    style="filled,rounded",
                                    width=2.2743];
                            }
                            {
                                graph [rank=same];
                                Web01	[fillcolor=transparent,
                                    height=4.4306,
                                    label=<<TABLE COLOR="gray" STYLE="dashed,rounded" PORT="EdgeDot" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="20"><B>Web Server Farm</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_Ubuntu.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,
                                    pos="590,794.75",
                                    shape=plain,
                                    width=6.5035];
                                SpaceRight	[color=black,
                                    fillcolor=transparent,
                                    height=1,
                                    label=SpaceRight,
                                    labelloc=c,
                                    orientation=0,
                                    penwidth=1,
                                    pos="1068,794.75",
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
                                    pos="112,794.75",
                                    shape=rectangle,
                                    style=invis,
                                    width=2];
                            }
                            Web01 -> App01	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=gRPC,
                                lp="606.12,544",
                                minlen=3,
                                pos="s,590,635.37 e,590,452.43 590,624.59 590,584.04 590,552.25 590,552.25 590,552.25 590,513.14 590,466.7"];
                            Web01 -> SpaceRight	[color=transparent,
                                minlen=2,
                                pos="s,823.87,794.75 e,995.52,794.75 834.59,794.75 883.42,794.75 932.24,794.75 981.06,794.75",
                                style=invis];
                            App01 -> DB01	[color=black,
                                fontcolor=black,
                                fontsize=14,
                                label=SQL,
                                lp="804.88,326.5",
                                minlen=3,
                                pos="s,676.11,315.25 e,933.8,315.25 686.94,315.25 756.76,315.25 850.43,315.25 919.46,315.25"];
                            Router01 -> Web01	[color=black,
                                fontcolor=black,
                                fontsize=18,
                                label="GE0/0",
                                lp="613.62,1019.8",
                                minlen=2,
                                pos="s,590,1085.4 e,590,954.12 590,1074.8 590,1049.6 590,1030.2 590,1030.2 590,1030.2 590,1003.8 590,968.56"];
                            Router01 -> RouterNetworkInfo	[arrowhead=none,
                                arrowtail=none,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                minlen=1,
                                pos="653.16,1186.8 681.9,1186.8 710.64,1186.8 739.38,1186.8",
                                style=filled];
                            WAN	[fillcolor=transparent,
                                height=2.2639,
                                label=<<TABLE border='0' color='#000000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' fixedsize='true' width='153.6' height='153.6' colspan='1'><img src='Docs/Icons/Cloud.png'/></TD></TR></TABLE>>,
                                pos="590,1627.8",
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
                                pos="590,1417.2",
                                shape=rectangle,
                                width=3];
                            WAN -> Firewall	[arrowhead=normal,
                                arrowtail=normal,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                head_lp="611.13,1481",
                                headlabel=port1,
                                labeldistance=5,
                                minlen=2,
                                pos="s,590,1546.4 e,590,1435.7 590,1532 590,1502.6 590,1472.3 590,1450.2"];
                            Firewall -> Router01	[arrowhead=normal,
                                arrowtail=normal,
                                color=black,
                                fontcolor=black,
                                fontsize=18,
                                head_lp="606.9,1324.4",
                                headlabel="Serial0/0",
                                labeldistance=4,
                                minlen=2,
                                pos="s,590,1398.8 e,590,1288.2 590,1384.2 590,1362.4 590,1332.4 590,1302.4",
                                tail_lp="573.1,1362.5",
                                taillabel=port2];
                            SpaceLeft -> Web01	[color=transparent,
                                minlen=2,
                                pos="s,184.35,794.75 e,355.88,794.75 195.07,794.75 243.86,794.75 292.65,794.75 341.43,794.75",
                                style=invis];
                        }
                    }
                }
            }
        }
        ```