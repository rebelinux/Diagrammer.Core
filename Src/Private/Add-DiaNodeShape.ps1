function Add-DiaNodeShape {
    <#
    .SYNOPSIS
        Generates an Node with a specific shape and customizable attributes for diagramming purposes.

    .DESCRIPTION
        The Add-DiaNodeShape function creates an Node with a specific shape and customizable attributes for diagramming purposes.
        It supports customization of the node's appearance, including border width, color, style, and image size percentage.
        The function also allows for debug mode, which highlights the node for easier troubleshooting, and supports specifying the icon image via a hashtable object.

    .PARAMETER Name
        Specifies the name of the node to be illustrated. This is a required parameter.

    .PARAMETER IconDebug
        Enables debug mode for icons. When set to $true, the table border is highlighted in red to assist with visual debugging.

    .EXAMPLE
        Add-DiaNodeShape -Name "MyNode" -ImagesObj $Images -IconType "ServerWindows" -ImageSizePercent 50 -TableBorder 1 -TableBorderColor "#FF0000" -TableBorderStyle "Solid"

        ** Generates an HTML table with a "ServerWindows" icon, 50% size, red solid border. **
                    _________________
                    |               |
                    |     Image     |
                    |               |
                    |_______________|

    .NOTES
        Author: Jonathan Colon
        Version: 0.2.30
        Twitter: @jcolonfzenpr
        Github: rebelinux

    #>

    [CmdletBinding()]
    [OutputType([System.String])]

    param(

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the Node.'
        )]
        [string] $Name,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Set the shape of the node. (https://graphviz.org/doc/info/shapes.html)'
        )]
        [ValidateSet('box', 'polygon', 'ellipse', 'circle', 'point', 'egg', 'triangle', 'plaintext', 'plain', 'diamond', 'trapezium', 'parallelogram', 'house', 'pentagon', 'hexagon', 'septagon', 'octagon', 'doublecircle', 'doubleoctagon', 'tripleoctagon', 'invtriangle', 'invtrapezium', 'invhouse', 'Mdiamond', 'Msquare', 'Mcircle', 'rect', 'rectangle')]
        [string] $Shape,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enables debug mode for icons, highlighting the table in red.'
        )]
        [Alias("DraftMode")]
        [bool] $IconDebug = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)'
        )]
        [hashtable] $GraphvizAttributes = @{},

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Fill Color.'
        )]
        [string] $ShapeFillColor = 'transparent',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Line Color.'
        )]
        [string] $ShapeLineColor = 'black',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Font Color.'
        )]
        [string] $ShapeFontColor = 'black',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Font Size.'
        )]
        [int] $ShapeFontSize = 14,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Font Name.'
        )]
        [string] $ShapeFontName = 'Times-Roman',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Style (e.g., filled, dashed, wedged, dotted, solid, striped, diagonals, rounded, bold, invisible; can be combined with commas Ex: dashed,rounded).'
        )]
        [string] $ShapeStyle = 'filled',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Width.'
        )]
        [ValidateRange(0, 10)]
        [float] $ShapeWidth = 0.75,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Height.'
        )]
        [ValidateRange(0, 10)]
        [float] $ShapeHeight = 0.5,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Border Size (1-10).'
        )]
        [ValidateRange(1, 10)]
        [int] $ShapeBorderSize = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Orientation (0-360 degrees).'
        )]
        [ValidateRange(0, 360)]
        [int] $ShapeOrientation = 0,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Label Position (top, bottom, center). Default is center.'
        )]
        [ValidateSet('top', 'bottom', 'center')]
        [string] $ShapeLabelPosition = 'center'
    )

    $ShapeLabelAllocation = switch ($ShapeLabelPosition) {
        'top' { 't' }
        'bottom' { 'b' }
        'center' { 'c' }
        Default { 'c' }
    }



    if ($IconDebug) {

        $JoinedHash = Join-Hashtable -PrimaryHash @{label = $Name; labelloc = $ShapeLabelAllocation; color = 'red'; shape = $Shape; fillcolor = $ShapeFillColor; fontsize = $ShapeFontSize; fontcolor = $ShapeFontColor; fontname = $ShapeFontName; style = $ShapeStyle; orientation = $ShapeOrientation; height = $ShapeHeight; width = $ShapeWidth; penwidth = $ShapeBorderSize } -SecondaryHash $GraphvizAttributes -PreferSecondary

        Node -Name $Name -Attributes $JoinedHash

    } else {
        $JoinedHash = Join-Hashtable -PrimaryHash @{label = $Name; labelloc = $ShapeLabelAllocation; color = $ShapeLineColor; shape = $Shape; fillcolor = $ShapeFillColor; fontsize = $ShapeFontSize; fontcolor = $ShapeFontColor; fontname = $ShapeFontName; style = $ShapeStyle; orientation = $ShapeOrientation; height = $ShapeHeight; width = $ShapeWidth; penwidth = $ShapeBorderSize } -SecondaryHash $GraphvizAttributes -PreferSecondary

        Node -Name $Name -Attributes $JoinedHash
    }

}