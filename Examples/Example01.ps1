<#
    This is a simple example demonstrating how to create a 3-tier web application diagram using the PSgraph module, without using any object icons.
#>

[CmdletBinding()]
param (
    [System.IO.FileInfo] $Path = '~\Desktop\',
    [array] $Format = @('png'),
    [bool] $DraftMode = $false
)

<#
    Starting with PowerShell v3, modules are auto-imported when needed. Importing the module here ensures clarity and avoids ambiguity.
#>

# Import-Module Diagrammer.Core -Force -Verbose:$false

<#
    Since the diagram output is a file, specify the output folder path using $OutputFolderPath.
#>

$OutputFolderPath = Resolve-Path $Path

<#
    The $MainGraphLabel variable sets the main title of the diagram.
#>

$MainGraphLabel = '3tier Web Application Diagram'

$example1 = & {
    <#
        This block creates a diagram with three servers, each represented by a custom node label and shape (without object icons).
    #>

    Node -Name Web01 -Attributes @{Label = 'Web01'; shape = 'rectangle'; fillColor = 'Green'; fontsize = 14 }
    Node -Name App01 -Attributes @{Label = 'App01'; shape = 'rectangle'; fillColor = 'Blue'; fontsize = 14 }
    Node -Name DB01 -Attributes @{Label = 'DB01'; shape = 'rectangle'; fillColor = 'Red'; fontsize = 14 }
}

<#
    The New-Diagrammer cmdlet generates the diagram.
    -InputObject: Accepts the custom object defined above.
    -OutputFolderPath: Specifies where to save the generated diagram.
    -Format: Sets the output format (png, jpg, svg, etc.).
    -ImagesObj: Passes a hashtable of images for custom icons.
    -MainDiagramLabel: Sets the diagram's title.
    -Filename: Specifies the output file name (without extension).
    -LogoName: Selects an image from the hashtable to use as the diagram logo.
    -DraftMode: If set to $true, generates a draft version of the diagram for troubleshooting.
    If the specified logo image is not found, a default no_icon.png is used.
#>
New-Diagrammer -InputObject $example1 -OutputFolderPath $OutputFolderPath -Format $Format -MainDiagramLabel $MainGraphLabel -Filename Example1 -LogoName "Main_Logo"  -DraftMode:$DraftMode