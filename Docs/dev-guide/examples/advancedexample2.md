---
comments: true
hide:
  - toc
---
This example demonstrates how to use the Add-DiaNodeText cmdlet to create a text box node in a diagram. (part of Diagrammer.Core)

The diagram below visually compares a traditional Graphviz SubGraph with a Diagrammer.Core HTML-like SubGraph, highlighting the enhanced layout and connectivity options available in Diagrammer.Core.


```powershell title="PowerShell: AdvancedExample2.ps1 - param block"
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

```powershell linenums="1" hl_lines="111-126" title="AdvancedExample2.ps1 - Add-DiaNodeText"
$advancedexample02 = & {

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

        <#
            Now, let's add a text box node using the Add-DiaNodeText cmdlet.
            This text box can provide additional information about the web server farm.
            The Add-DiaNodeText cmdlet allows you to create a text box node with customizable properties.
            You can specify the text, font size, color, background color, and more.
            The resulting text box can be connected to other nodes in the diagram.
            The \n character is used to create line breaks in the text. Simulating a multi-line text box.
        #>
        Add-DiaNodeText -Name "Info-Box" -TableBorder 2 -DraftMode:$DraftMode -TableBorderColor "#FF0000" -TableBorderStyle "SOLID" -Text "This is a test text box.\nIt supports multiple lines of text.\nYou can customize the font, size, color, and background." -FontColor "#0000FF" -FontSize 30 -FontBold -TableBackgroundColor "#FFFF00" -TextAlign "Left" -NodeObject

        # Now, let's add another text box node. This one will explain the advantages of using Add-DiaHTMLSubGraph over native Graphviz SubGraphs.
        $Message = "Add-DiaHTMLSubGraph permit the use of edges to connect nodes inside and outside the SubGraph.\n
        This is not possible with native Graphviz SubGraphs.\n"
        Add-DiaNodeText -Name "Info-Box2" -DraftMode:$DraftMode -Text $Message -FontColor "#0000FF" -FontSize 20 -FontBold -TextAlign "Left" -NodeObject

        Edge -From "USA-WebServers" -To "Info-Box2" -Attributes @{minlen = 2; color = 'black'; style = 'dashed'; penwidth = 1.5}
    }
}
```

Finally, call the New-Diagrammer cmdlet with the specified parameters.

```powershell
New-Diagrammer -InputObject $advancedexample02 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename AdvancedExample2 -LogoName "Main_Logo" -Direction top-to-bottom -IconPath $IconPath -ImagesObj $Images -DraftMode:$DraftMode
```
When you run the script, it generates a PNG file named AdvancedExample2.png in the specified output folder.

### Resulting diagram:

!!! example

    === "Advanced Example 02"

        ```graphviz dot advancedexample02.png
            digraph Root {
                graph [bb="0,0,2727,1179",
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
                    graph [bb="8,8,2719,1171",
                        color=gray,
                        fontsize=24,
                        label=" ",
                        labeljust=r,
                        labelloc=b,
                        lheight=0.41,
                        lp="2708.8,26.625",
                        lwidth=0.06,
                        penwidth=1.5,
                        style=invis
                    ];
                    subgraph clusterMainGraph {
                        graph [bb="16,53.25,2672,1163",
                            fontsize=24,
                            label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Docs/Icons/Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,
                            labeljust=c,
                            labelloc=t,
                            lheight=3.92,
                            lp="1344,1017.9",
                            lwidth=5.00,
                            penwidth=0
                        ];
                        subgraph cluster3tier {
                            graph [bb="24,61.25,2625,864.75",
                                color=darkgray,
                                fontsize=22,
                                label="Advanced Diagram Concepts",
                                labelloc=t,
                                lheight=0.39,
                                lp="1324.5,846.88",
                                lwidth=4.40,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            subgraph clusterTraditional {
                                graph [bb="32,402.12,1222,692.88",
                                    bgcolor="#c1cfe5ff",
                                    color=darkgray,
                                    fontsize=22,
                                    label="Native Graphviz SubGraph",
                                    labelloc=t,
                                    lheight=0.39,
                                    lp="627,675",
                                    lwidth=4.00,
                                    penwidth=1.5,
                                    style="dashed,rounded"
                                ];
                                Traditional	[height=0.05,
                                    label="",
                                    pos="42,529.62",
                                    shape=point,
                                    style=invis,
                                    width=0.05];
                                "UK-WebServer-01"	[fillcolor=transparent,
                                    height=3.3194,
                                    label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="163,529.62",
                                    shape=plain,
                                    width=2.1111];
                                "UK-WebServer-02"	[fillcolor=transparent,
                                    height=3.3194,
                                    label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-02</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="358,529.62",
                                    shape=plain,
                                    width=2.1111];
                                "UK-WebServer-03"	[fillcolor=transparent,
                                    height=3.3194,
                                    label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-03</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="553,529.62",
                                    shape=plain,
                                    width=2.1111];
                                "UK-WebServer-04"	[fillcolor=transparent,
                                    height=3.3194,
                                    label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-04</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="748,529.62",
                                    shape=plain,
                                    width=2.1111];
                                "UK-WebServer-05"	[fillcolor=transparent,
                                    height=3.3194,
                                    label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-05</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="943,529.62",
                                    shape=plain,
                                    width=2.1111];
                                "UK-WebServer-06"	[fillcolor=transparent,
                                    height=3.3194,
                                    label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Docs/Icons/Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-06</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                    pos="1138,529.62",
                                    shape=plain,
                                    width=2.1111];
                            }
                            "3tier"	[height=0.05,
                                label="",
                                pos="1259,529.62",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "USA-WebServers"	[fillcolor=transparent,
                                height=8.0938,
                                label=<<TABLE BGColor="#a8c3b8ff" COLOR="darkgray" STYLE="dashed,rounded" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD valign="BOTTOM" ALIGN="Center" colspan="1" fixedsize="true" width="40" height="40"><IMG src="Docs/Icons/Server.png"></IMG></TD></TR><TR><TD valign="TOP" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="22"><B>Diagrammer SubGraph</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="22"><TABLE COLOR="#000000" PORT="EdgeDot" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Docs/Icons/Linux_Server_RedHat.png"/></TD></TR><TR><TD PORT="Web-Server-04" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-04</B></FONT></TD><TD PORT="Web-Server-05" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-05</B></FONT></TD><TD PORT="Web-Server-06" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-06</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE></FONT></TD></TR></TABLE>>,
                                pos="1538,529.62",
                                shape=plain,
                                width=6.5];
                            "Info-Box2"	[fillcolor=transparent,
                                height=0.83333,
                                label=<<TABLE border='0' color='#000000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Left' colspan='1'><FONT FACE='Segoe Ui' POINT-SIZE='20' COLOR='#0000FF'><B>Add-DiaHTMLSubGraph permit the use of edges to connect nodes inside and outside the SubGraph.<BR/>
                    This is not possible with native Graphviz SubGraphs.<BR/></B></FONT></TD></TR></TABLE>>,
                                pos="1538,99.25",
                                shape=plain,
                                width=13.632];
                            "USA-WebServers" -> "Info-Box2"	[color=black,
                                minlen=2,
                                penwidth=1.5,
                                pos="s,1538,238.39 e,1538,129.13 1538,229.1 1538,195.03 1538,164.36 1538,141.39"];
                            "Info-Box"	[fillcolor=transparent,
                                height=1.5833,
                                label=<<TABLE STYLE='SOLID' bgcolor='#FFFF00' border='2' color='#FF0000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='SOLID' ALIGN='Left' colspan='1'><FONT FACE='Segoe Ui' POINT-SIZE='30' COLOR='#0000FF'><B>This is a test text box.<BR/>It supports multiple lines of text.<BR/>You can customize the font, size, color, and background.</B></FONT></TD></TR></TABLE>>,
                                pos="2216,529.62",
                                shape=plain,
                                width=11.135];
                        }
                        MainGraph	[height=0.05,
                            label="",
                            pos="2662,529.62",
                            shape=point,
                            style=invis,
                            width=0.05];
                    }
                    OUTERDRAWBOARD1	[height=0.05,
                        label="",
                        pos="2709,529.62",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
            }
        ```

    === "Advanced Example 02 - DraftMode"

        ```graphviz dot advancedexample02_draftmode.png
        digraph Root {
            graph [bb="0,0,2753,1095.2",
                bgcolor=White,
                compound=true,
                fontcolor="#565656",
                fontname="Segoe Ui Black",
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
                graph [bb="8,8,2745,1087.2",
                    color=red,
                    fontsize=24,
                    label=" ",
                    labeljust=r,
                    labelloc=b,
                    lheight=0.41,
                    lp="2734.8,26.625",
                    lwidth=0.06,
                    penwidth=1.5,
                    style=dashed
                ];
                subgraph clusterMainGraph {
                    graph [bb="16,53.25,2698,1079.2",
                        fontsize=24,
                        label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='20'><TR><TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'>Main Logo</TD></TR><TR><TD bgcolor='#FFCCCC' ALIGN='center' ><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR><TR><TD ALIGN='center'><font color='red'>Debug ON</font></TD></TR></TABLE>>,
                        labeljust=c,
                        labelloc=t,
                        lheight=4.00,
                        lp="1357,931.38",
                        lwidth=5.28,
                        penwidth=0
                    ];
                    subgraph cluster3tier {
                        graph [bb="24,61.25,2651,775.5",
                            color=darkgray,
                            fontsize=22,
                            label="Advanced Diagram Concepts",
                            labelloc=t,
                            lheight=0.39,
                            lp="1337.5,757.62",
                            lwidth=4.40,
                            penwidth=1.5,
                            style="dashed,rounded"
                        ];
                        subgraph clusterTraditional {
                            graph [bb="32,378.75,1246,629",
                                bgcolor="#c1cfe5ff",
                                color=darkgray,
                                fontsize=22,
                                label="Native Graphviz SubGraph",
                                labelloc=t,
                                lheight=0.39,
                                lp="639,611.12",
                                lwidth=4.00,
                                penwidth=1.5,
                                style="dashed,rounded"
                            ];
                            Traditional	[height=0.05,
                                label="",
                                pos="42,486",
                                shape=point,
                                style=invis,
                                width=0.05];
                            "UK-WebServer-01"	[fillcolor=transparent,
                                height=2.7569,
                                label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="165,486",
                                shape=plain,
                                width=2.1667];
                            "UK-WebServer-02"	[fillcolor=transparent,
                                height=2.7569,
                                label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-02</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="364,486",
                                shape=plain,
                                width=2.1667];
                            "UK-WebServer-03"	[fillcolor=transparent,
                                height=2.7569,
                                label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-03</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="563,486",
                                shape=plain,
                                width=2.1667];
                            "UK-WebServer-04"	[fillcolor=transparent,
                                height=2.7569,
                                label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-04</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="762,486",
                                shape=plain,
                                width=2.1667];
                            "UK-WebServer-05"	[fillcolor=transparent,
                                height=2.7569,
                                label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-05</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="961,486",
                                shape=plain,
                                width=2.1667];
                            "UK-WebServer-06"	[fillcolor=transparent,
                                height=2.7569,
                                label=<<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD bgcolor='#FFCCCC' ALIGN='Center' colspan='1'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='18'>Icon</FONT></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-06</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,
                                pos="1160,486",
                                shape=plain,
                                width=2.1667];
                        }
                        "3tier"	[height=0.05,
                            label="",
                            pos="1283,486",
                            shape=point,
                            style=invis,
                            width=0.05];
                        "USA-WebServers"	[fillcolor=transparent,
                            height=6.8264,
                            label=<<TABLE BGColor="#a8c3b8ff" STYLE="dashed,rounded" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="22"><B>SubGraph Icon</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="22"><B>Diagrammer SubGraph</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="22"><TABLE PORT="EdgeDot" COLOR="red" border="1" cellborder="1" cellpadding="5" cellspacing="5"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="18"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="18"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="18"><B>Icon</B></FONT></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="18"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="18"><B>Icon</B></FONT></TD><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="18"><B>Icon</B></FONT></TD></TR><TR><TD PORT="Web-Server-04" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-04</B></FONT></TD><TD PORT="Web-Server-05" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-05</B></FONT></TD><TD PORT="Web-Server-06" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-06</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE></FONT></TD></TR></TABLE>>,
                            pos="1564,486",
                            shape=plain,
                            width=6.5556];
                        "Info-Box2"	[fillcolor=transparent,
                            height=0.86111,
                            label=<<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='SOLID' ALIGN='Left' colspan='1'><FONT FACE='Segoe Ui' POINT-SIZE='20' COLOR='#0000FF'><B>Add-DiaHTMLSubGraph permit the use of edges to connect nodes inside and outside the SubGraph.<BR/>
                This is not possible with native Graphviz SubGraphs.<BR/></B></FONT></TD></TR></TABLE>>,
                            pos="1564,100.25",
                            shape=plain,
                            width=13.66];
                        "USA-WebServers" -> "Info-Box2"	[color=black,
                            minlen=2,
                            penwidth=1.5,
                            pos="s,1564,240.33 e,1564,131.09 1564,230.94 1564,197.28 1564,166.45 1564,143.2"];
                        "Info-Box"	[fillcolor=transparent,
                            height=1.5556,
                            label=<<TABLE bgcolor='#FFCCCC' color='red' border='1' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='SOLID' ALIGN='Left' colspan='1'><FONT FACE='Segoe Ui' POINT-SIZE='30' COLOR='#0000FF'><B>This is a test text box.<BR/>It supports multiple lines of text.<BR/>You can customize the font, size, color, and background.</B></FONT></TD></TR></TABLE>>,
                            pos="2243,486",
                            shape=plain,
                            width=11.108];
                    }
                    MainGraph	[height=0.05,
                        label="",
                        pos="2688,486",
                        shape=point,
                        style=invis,
                        width=0.05];
                }
                OUTERDRAWBOARD1	[height=0.05,
                    label="",
                    pos="2735,486",
                    shape=point,
                    style=invis,
                    width=0.05];
            }
        }
        ```