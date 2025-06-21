function Add-DiaLeftTShapeLine {
    <#
    .SYNOPSIS
        Adds a Left T-shaped connector to a diagram, representing a vertical line intersecting a horizontal line extending to the right.

        Example:
                        (LeftTShapeUpper)
                                o
                                |
                                |
                (LeftTShapeEnd) o___o (RightTShapeEnd)
                                |
                                |
                                o
                        (LeftTShapeDown)

    .DESCRIPTION
        The Add-DiaLeftTShapeLine function creates a Left T-shaped connector in a diagram by defining four nodes and connecting them with edges.
        This shape is commonly used to represent branching or intersection points in diagrams, such as flowcharts or network diagrams.
        The function allows customization of node names, line styles, arrow types, line widths, and colors.
        It also supports a debug mode for visualizing node placement.

    .PARAMETER LeftTShapeUpper
        The name of the upper node in the T-shape. Default is 'LeftTShapeUpper'.

    .PARAMETER LeftTShapeDown
        The name of the lower node in the T-shape. Default is 'LeftTShapeDown'.

    .PARAMETER LeftTShapeMiddleRight
        The name of the right node at the intersection of the T-shape. Default is 'LeftTShapeMiddleRight'.

    .PARAMETER LeftTShapeMiddleLeft
        The name of the left node at the intersection of the T-shape. Default is 'LeftTShapeMiddleLeft'.

    .PARAMETER Arrowtail
        The style of the arrow tail for the edges. Accepts various Graphviz arrow types. Default is 'none'.

    .PARAMETER Arrowhead
        The style of the arrow head for the edges. Accepts various Graphviz arrow types. Default is 'none'.

    .PARAMETER LineStyle
        The style of the line connecting the nodes. Options include 'dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered'. Default is 'solid'.

    .PARAMETER LineWidth
        The width of the connector lines (penwidth), from 1 to 10. Default is 1.

    .PARAMETER LeftTShapeUpperLineLength
        The minimum length of the line from the upper node to the intersection. Default is 1.

    .PARAMETER LeftTShapeDownLineLength
        The minimum length of the line from the intersection to the lower node. Default is 1.

    .PARAMETER LeftTShapeMiddleRightLineLength
        The minimum length of the horizontal line from the intersection to the right node. Default is 1.

    .PARAMETER LineColor
        The color of the connector lines. Accepts any valid Graphviz color. Default is 'black'.

    .PARAMETER IconDebug
        Switch to enable debug mode, which highlights the nodes and lines in red for easier visualization. Default is $false.

    .EXAMPLE
        Add-DiaLeftTShapeLine -LeftTShapeUpper "Top" -LeftTShapeDown "Bottom" -LeftTShapeMiddleRight "Right" -LeftTShapeMiddleLeft "Center" -LineColor "blue" -LineStyle "dashed"

        Creates a blue, dashed Left T-shaped connector with custom node names.

    .NOTES
        Author: Jonathan Colon
        Version: 0.6.30
        GitHub: https://github.com/rebelinux/Diagrammer.Core

    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as Start Node Name'
        )]
        [string] $LeftTShapeUpper = 'LeftTShapeUpper',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $LeftTShapeDown = 'LeftTShapeDown',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $LeftTShapeMiddleRight = 'LeftTShapeMiddleRight',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $LeftTShapeMiddleLeft = 'LeftTShapeMiddleLeft',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [ValidateSet(
            'none', 'normal', 'inv', 'dot', 'invdot', 'odot', 'invodot', 'diamond', 'odiamond', 'ediamond', 'crow', 'box', 'obox', 'open', 'halfopen', 'empty', 'invempty', 'tee', 'vee', 'icurve', 'lcurve', 'rcurve', 'icurve', 'box', 'obox', 'diamond', 'odiamond', 'ediamond', 'crow', 'tee', 'vee', 'dot', 'odot', 'inv', 'invodot', 'invempty', 'invbox', 'invodiamond', 'invtee', 'invvee', 'none'
        )]
        [string] $Arrowtail = 'none',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [ValidateSet(
            'none', 'normal', 'inv', 'dot', 'invdot', 'odot', 'invodot', 'diamond', 'odiamond', 'ediamond', 'crow', 'box', 'obox', 'open', 'halfopen', 'empty', 'invempty', 'tee', 'vee', 'icurve', 'lcurve', 'rcurve', 'icurve', 'box', 'obox', 'diamond', 'odiamond', 'ediamond', 'crow', 'tee', 'vee', 'dot', 'odot', 'inv', 'invodot', 'invempty', 'invbox', 'invodiamond', 'invtee', 'invvee', 'none'
        )]
        [string] $Arrowhead = 'none',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [ValidateSet('dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered')]
        [string] $LineStyle = 'solid',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Width of the line (penwidth), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LineWidth = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Width of the line (penwidth), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LeftTShapeUpperLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Width of the line (penwidth), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LeftTShapeDownLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Width of the line (penwidth), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LeftTShapeMiddleRightLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a color to be used in the line. Default is black. Supported color https://graphviz.org/doc/info/colors.html'
        )]
        [string] $LineColor = "black",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enables debug mode for icons, highlighting the table in red.'
        )]
        [Alias('DraftMode')]
        [bool] $IconDebug = $false
    )

    begin {
    }

    process {
        try {
            if ($IconDebug) {
                $Shape = 'plain'
                $fillColor = 'red'
                $Style = 'filled'
                $Color = 'black'
                $LineColor = 'red'
            } else {
                $Shape = 'point'
                $fillColor = 'transparent'
                $Style = 'invis'
                $Color = $LineColor
            }
            if ($IconDebug) {
                Node $LeftTShapeUpper, $LeftTShapeMiddleRight, $LeftTShapeDown, $LeftTShapeMiddleLeft  @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }

            } else {
                Node $LeftTShapeUpper, $LeftTShapeMiddleRight, $LeftTShapeDown, $LeftTShapeMiddleLeft @{shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = 'transparent'; style = $Style }
            }

            Rank $LeftTShapeMiddleRight, $LeftTShapeMiddleLeft

            Edge -From $LeftTShapeUpper -To $LeftTShapeMiddleLeft @{minlen = $LeftTShapeUpperLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }

            Edge -From $LeftTShapeMiddleLeft -To $LeftTShapeDown @{minlen = $LeftTShapeDownLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }

            Edge -From $LeftTShapeMiddleLeft -To $LeftTShapeMiddleRight @{minlen = $LeftTShapeMiddleRightLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }

        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}