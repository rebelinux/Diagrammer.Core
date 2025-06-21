function Add-DiaTShapeLine {
    <#
    .SYNOPSIS
        Creates a T-shaped connector in a diagram, linking specified nodes with customizable line styles, widths, and colors.
        Example:
                                (TShapeMiddleUpper)
               (TShapeStart)o___o___o(TShapeEnd)
                                |
                                o
                                (TShapeMiddleDown)

    .DESCRIPTION
        The Add-DiaTShapeLine function generates a T-shaped (⊥) structure in a diagram by connecting four nodes: a horizontal line between a start node, a middle top node, and an end node, with a vertical line extending down from the middle node to a lower node.
        The function allows customization of node names, line style, arrowhead/tail types, line length, width, and color.
        It also supports a debug mode to visually highlight the nodes for troubleshooting.

    .PARAMETER StartName
        The name of the starting node on the horizontal line. Default is 'TShapeStart'.

    .PARAMETER EndName
        The name of the ending node on the horizontal line. Default is 'TShapeEnd'.

    .PARAMETER MiddleTop
        The name of the node at the intersection of the T (top of the vertical line). Default is 'TShapeMiddleUpper'.

    .PARAMETER MiddleDown
        The name of the node at the bottom of the vertical line. Default is 'TShapeMiddleDown'.

    .PARAMETER Arrowtail
        The style of the arrow tail for the connecting lines. Accepts various Graphviz arrow types. Default is 'none'.

    .PARAMETER Arrowhead
        The style of the arrow head for the connecting lines. Accepts various Graphviz arrow types. Default is 'none'.

    .PARAMETER LineStyle
        The style of the connecting lines (e.g., solid, dashed, dotted, bold). Default is 'solid'.

    .PARAMETER LineLength
        The minimum length of each line segment (Graphviz minlen). Range: 1-10. Default is 1.

    .PARAMETER LineWidth
        The width (penwidth) of the lines. Range: 1-10. Default is 1.

    .PARAMETER LineColor
        The color of the lines. Accepts any Graphviz-supported color. Default is 'black'.

    .PARAMETER IconDebug
        Switch to enable debug mode, which highlights the nodes and lines in red for easier troubleshooting. Default is $false.

    .EXAMPLE
        Add-DiaTShapeLine -StartName "A" -EndName "B" -MiddleTop "C" -MiddleDown "D" -LineStyle "dashed" -LineColor "blue"

        Creates a T-shaped connector with custom node names, dashed blue lines, and default arrow styles.

    .NOTES
        Author: Jonathan Colon
        Version: 0.6.30
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
        [string] $StartName = 'TShapeStart',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $EndName = 'TShapeEnd',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $MiddleTop = 'TShapeMiddleUpper',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $MiddleDown = 'TShapeMiddleDown',

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
        [int] $LineLength = 1,

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
                Node $StartName, $MiddleDown, $EndName, $MiddleTop @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
            } else {
                Node $StartName, $MiddleDown, $EndName @{color = $Color; shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = $fillColor; style = $Style }
                Node $MiddleTop @{color = $Color; shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = $fillColor; style = $Style }
            }

            Rank $StartName, $MiddleTop, $EndName
            Edge -From $StartName -To $MiddleTop @{minlen = $LineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $MiddleTop -To $EndName @{minlen = $LineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $MiddleTop -To $MiddleDown @{minlen = $LineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }


        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}