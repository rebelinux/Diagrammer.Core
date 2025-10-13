function Add-DiaRightTShapeLine {
    <#
    .SYNOPSIS
        Adds a Right T-shaped connector to a diagram, representing a vertical line intersecting a horizontal line to the right.
        Example:
                                (RightTShapeUp)
                                        o
                                        |
            (RightTShapeMiddleLeft)o___o(RightTShapeMiddleRight)
                                        |
                                        o
                                (RightTShapeDown)
    .DESCRIPTION
        The Add-DiaRightTShapeLine function creates a Right T-shaped connector in a diagram, typically used for visualizing relationships or flows in diagrams such as Graphviz. The connector consists of a vertical line intersecting a horizontal line to the right, forming a "T" shape. The function allows customization of node names, line styles, arrowheads, colors, and lengths, and supports a debug mode for visual troubleshooting.

    .PARAMETER RightTShapeUp
        The name of the top node in the T-shape. Default is 'RightTShapeUp'.

    .PARAMETER RightTShapeDown
        The name of the bottom node in the T-shape. Default is 'RightTShapeDown'.

    .PARAMETER RightTShapeMiddleRight
        The name of the right node at the intersection of the T-shape. Default is 'RightTShapeMiddleRight'.

    .PARAMETER RightTShapeMiddleLeft
        The name of the left node at the intersection of the T-shape. Default is 'RightTShapeMiddleLeft'.

    .PARAMETER Arrowtail
        The style of the arrow tail for the connector. Supports various Graphviz arrow types. Default is 'none'.

    .PARAMETER Arrowhead
        The style of the arrow head for the connector. Supports various Graphviz arrow types. Default is 'none'.

    .PARAMETER LineStyle
        The style of the connector line. Valid values: 'dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered'. Default is 'solid'.

    .PARAMETER LineSize
        The size of the connector line. Range: 1-10. Default is 1.

    .PARAMETER RightTShapeUpLineLength
        The length of the vertical line from the top node to the intersection. Range: 1-10. Default is 1.

    .PARAMETER RightTShapeEndLineLength
        The length of the vertical line from the intersection to the bottom node. Range: 1-10. Default is 1.

    .PARAMETER RightTShapeMiddleRightLineLength
        The length of the horizontal line from the intersection to the right node. Range: 1-10. Default is 1.

    .PARAMETER RightTShapeMiddleLeftLineLength
        The length of the horizontal line from the intersection to the left node. Range: 1-10. Default is 1.

    .PARAMETER LineWidth
        The width of the connector line (penwidth). Range: 1-10. Default is 1.

    .PARAMETER LineColor
        The color of the connector line. Accepts any color supported by Graphviz. Default is 'black'.

    .PARAMETER IconDebug
        Switch to enable debug mode, which highlights the nodes and lines in red for easier troubleshooting. Default is $false.

    .EXAMPLE
        Add-DiaRightTShapeLine -RightTShapeUp "TopNode" -RightTShapeDown "BottomNode" -LineColor "blue" -LineStyle "dashed"

        Creates a Right T-shaped connector with custom node names, blue dashed lines.

    .NOTES
        Author: Jonathan Colon
        Version: 0.2.31
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
        [string] $RightTShapeUp = 'RightTShapeUp',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $RightTShapeDown = 'RightTShapeDown',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $RightTShapeMiddleRight = 'RightTShapeMiddleRight',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $RightTShapeMiddleLeft = 'RightTShapeMiddleLeft',

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
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [ValidateRange(1, 10)]
        [int] $LineSize = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $RightTShapeUpLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $RightTShapeDownLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $RightTShapeMiddleRightLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Width of the line (penwidth), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LineWidth = 1,

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
                Node $RightTShapeUp, $RightTShapeMiddleLeft, $RightTShapeMiddleRight, $RightTShapeDown @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
            } else {
                Node $RightTShapeUp, $RightTShapeMiddleLeft, $RightTShapeMiddleRight, $RightTShapeDown @{color = $Color; shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = $fillColor; style = $Style }
            }

            Rank $RightTShapeMiddleRight, $RightTShapeMiddleLeft

            Edge -From $RightTShapeUp -To $RightTShapeMiddleLeft @{minlen = $RightTShapeUpLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $RightTShapeMiddleLeft -To $RightTShapeDown @{minlen = $RightTShapeDownLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $RightTShapeMiddleLeft -To $RightTShapeMiddleRight @{minlen = $RightTShapeMiddleRightLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }


        } catch {
            Write-Error -Message $_.Exception.Message
        }
    }
    end {}
}