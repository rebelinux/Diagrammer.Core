This is a simple example demonstrating how to create a 3-tier web application diagram using the PSGraph module, without using any object icons.

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

This block creates a diagram with three servers, each represented by a custom node label and shape (without object icons).

```powershell
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

### Resulting GraphViz Source Code:

```graphviz dot example1.png
DiGraph Root {
    Graph [bb="0,0,477,420.5",
    bgcolor=White,
    compound=true,
    fontcolor="#565656",
    fontname="Segoe Ui Black",
    fontsize=32,
    imagepath="C:\Users\jocolon\Documents\WindowsPowerShell\Modules\Diagrammer.Core\icons",
    labelloc=t,
    nodesep=0.6,
    pad=1,
    penwidth=1.5,
    rankdir=TB,
    ranksep=0.75,
    splines=line,
    style=dashed
    ];
    Node [fillcolor="#71797E",
    fontcolor=Black,
    fontsize=14,
    imagescale=True,
    label="\N",
    labelloc=t,
    shape=none,
    style=filled
    ];
    Edge [arrowsize=1,
    arrowtail=dot,
    color="#71797E",
    dir=both,
    fontcolor="#71797E",
    penwidth=3,
    style=dashed
    ];
    SubGraph clusterOUTERDRAWBOARD1 {
        Graph [bb="8,8,469,412.5",
        color=gray,
        fontsize=24,
        label=" ",
        labeljust=r,
        labelloc=b,
        lheight=0.47,
        lp="457.62,28.875",
        lwidth=0.09,
        penwidth=1.5,
        style=invis
        ];
        SubGraph clusterMainGraph {
            Graph [bb="16,57.75,461,404.5",
            fontsize=24,
            label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>3tier Web Application Diagram</FONT></TD></TR></TABLE>>,
            labeljust=c,
            labelloc=t,
            lheight=3.98,
            lp="238.5,257.12",
            lwidth=5.96,
            penwidth=0
            ];
            Web01	[fillcolor=Green,
            height=0.5,
            label=Web01,
            pos="141,83.75",
            shape=rectangle,
            width=0.75347];
            App01	[fillcolor=Blue,
            height=0.5,
            label=App01,
            pos="283,83.75",
            shape=rectangle,
            width=0.75];
            DB01	[fillcolor=Red,
            height=0.5,
            label=DB01,
            pos="403,83.75",
            shape=rectangle,
            width=0.75];
        }
    }
}
```