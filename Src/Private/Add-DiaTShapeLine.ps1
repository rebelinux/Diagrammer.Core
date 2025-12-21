function Add-DiaTShapeLine {
    <#
    .SYNOPSIS
        Adds a T-shaped connector to a diagram, linking four nodes with customizable line styles, widths, and colors.
        Example:
                                (TShapeMiddleUp)
                (TShapeLeft)o___o___o(TShapeRight)
                                |
                                o
                                (TShapeMiddleDown)

    .DESCRIPTION
        The Add-DiaTShapeLine function creates a T-shaped (⊥) connector in a diagram by connecting four nodes:
        - A horizontal line between a left node, a middle (top) node, and a right node.
        - A vertical line extending down from the middle node to a lower node.

        The function supports customization of:
        - Node names for each point of the T-shape.
        - Arrowhead and arrowtail styles (Graphviz types).
        - Line style (solid, dashed, dotted, etc.).
        - Individual line segment lengths for left, right, and vertical lines.
        - Line width and color.
        - Debug mode to visually highlight nodes and lines for troubleshooting.

    .PARAMETER TShapeLeft
        The name of the starting node on the horizontal line (left side). Default is 'TShapeLeft'.

    .PARAMETER TShapeRight
        The name of the ending node on the horizontal line (right side). Default is 'TShapeRight'.

    .PARAMETER TShapeMiddleUp
        The name of the node at the intersection of the T (top of the vertical line). Default is 'TShapeMiddleUp'.

    .PARAMETER TShapeMiddleDown
        The name of the node at the bottom of the vertical line. Default is 'TShapeMiddleDown'.

    .PARAMETER Arrowtail
        The style of the arrow tail for the connecting lines. Accepts Graphviz arrow types. Default is 'none'.

    .PARAMETER Arrowhead
        The style of the arrow head for the connecting lines. Accepts Graphviz arrow types. Default is 'none'.

    .PARAMETER LineStyle
        The style of the connecting lines (e.g., solid, dashed, dotted, bold). Default is 'solid'.

    .PARAMETER TShapeLeftLineLength
        The minimum length (Graphviz minlen) of the left horizontal segment. Range: 1-10. Default is 1.

    .PARAMETER TShapeRightLineLength
        The minimum length (Graphviz minlen) of the right horizontal segment. Range: 1-10. Default is 1.

    .PARAMETER TShapeMiddleDownLineLength
        The minimum length (Graphviz minlen) of the vertical segment. Range: 1-10. Default is 1.

    .PARAMETER LineWidth
        The width (penwidth) of the lines. Range: 1-10. Default is 1.

    .PARAMETER LineColor
        The color of the lines. Accepts any Graphviz-supported color. Default is 'black'.

    .PARAMETER IconDebug
        Switch to enable debug mode, which highlights the nodes and lines in red for easier troubleshooting. Default is $false.

    .EXAMPLE
        Add-DiaTShapeLine -TShapeLeft "A" -TShapeRight "B" -TShapeMiddleUp "C" -TShapeMiddleDown "D" -LineStyle "dashed" -LineColor "blue"

        Creates a T-shaped connector with custom node names, dashed blue lines, and default arrow styles.

    .NOTES
        Author: Jonathan Colon
        Version: 0.2.31
        GitHub: https://github.com/rebelinux/Diagrammer.Core

    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>

    # Todo: Add support for creating more than 1 line and able to join them with Rank parameter.

    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as Start Node Name'
        )]
        [string] $TShapeLeft = 'TShapeLeft',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $TShapeRight = 'TShapeRight',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $TShapeMiddleUp = 'TShapeMiddleUp',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $TShapeMiddleDown = 'TShapeMiddleDown',

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
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $TShapeLeftLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $TShapeRightLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $TShapeMiddleDownLineLength = 1,

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
        [string] $LineColor = 'black',

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
                Node $TShapeLeft, $TShapeMiddleDown, $TShapeRight, $TShapeMiddleUp @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
            } else {
                Node $TShapeLeft, $TShapeMiddleDown, $TShapeRight, $TShapeMiddleUp @{color = $Color; shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = $fillColor; style = $Style }
            }

            Rank $TShapeLeft, $TShapeMiddleUp, $TShapeRight

            Edge -From $TShapeLeft -To $TShapeMiddleUp @{minlen = $TShapeLeftLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $TShapeMiddleUp -To $TShapeRight @{minlen = $TShapeRightLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $TShapeMiddleUp -To $TShapeMiddleDown @{minlen = $TShapeMiddleDownLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }


        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}