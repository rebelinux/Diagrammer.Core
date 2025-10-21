function Add-DiaCrossShapeLine {
    <#
    .SYNOPSIS
        Adds a customizable cross-shaped line (plus sign) to a diagram.

                            (CrossShapeMiddleTop)
        Example:                    o
                                    |
                                    |
               (CrossShapeStart)o___o___o(CrossShapeEnd)
                                    |
                                    |
                                    o
                            (CrossShapeMiddleDown)


    .DESCRIPTION
        The Add-DiaCrossShapeLine function creates a cross-shaped (plus sign) line object within a diagram, using configurable node names and visual properties.
        The cross consists of a central node with lines extending vertically and horizontally, forming a symmetrical intersection.
        This is useful for representing intersections, connection points, or central hubs in diagrammatic representations.

        The function allows customization of:
            - Node names for each segment of the cross (start, end, middle, top, down)
            - Line style (solid, dashed, dotted, etc.)
            - Line color and width
            - Arrowhead and arrowtail styles
            - Individual segment lengths
            - Debug mode for visualizing node positions

    .PARAMETER CrossShapeStart
        Name of the node at the left end of the horizontal line in the cross shape. Default is 'CrossShapeStart'.

    .PARAMETER CrossShapeEnd
        Name of the node at the right end of the horizontal line in the cross shape. Default is 'CrossShapeEnd'.

    .PARAMETER CrossShapeMiddle
        Name of the central node where the vertical and horizontal lines intersect. Default is 'CrossShapeMiddle'.

    .PARAMETER CrossShapeMiddleTop
        Name of the node at the top end of the vertical line in the cross shape. Default is 'CrossShapeMiddleTop'.

    .PARAMETER CrossShapeMiddleDown
        Name of the node at the bottom end of the vertical line in the cross shape. Default is 'CrossShapeMiddleDown'.

    .PARAMETER Arrowtail
        Style of the arrow tail for the lines. Accepts various Graphviz arrow styles. Default is 'none'.

    .PARAMETER Arrowhead
        Style of the arrow head for the lines. Accepts various Graphviz arrow styles. Default is 'none'.

    .PARAMETER LineStyle
        Style of the line (e.g., solid, dashed, dotted, bold). Default is 'solid'.

    .PARAMETER LineWidth
        Width of the line (penwidth), from 1 to 10. Default is 1.

    .PARAMETER CrossShapeStartLineLength
        Length of the line from CrossShapeStart to CrossShapeMiddle. Default is 1.

    .PARAMETER CrossShapeEndLineLength
        Length of the line from CrossShapeMiddle to CrossShapeEnd. Default is 1.

    .PARAMETER CrossShapeMiddleTopLineLength
        Length of the line from CrossShapeMiddleTop to CrossShapeMiddle. Default is 1.

    .PARAMETER CrossShapeMiddleDownLineLength
        Length of the line from CrossShapeMiddle to CrossShapeMiddleDown. Default is 1.

    .PARAMETER LineColor
        Color of the cross-shaped line. Default is 'black'. Supports Graphviz color names.

    .PARAMETER IconDebug
        Switch to enable debug mode, which highlights the cross shape in red for easier visualization.

    .EXAMPLE
        # Adds a cross-shaped line to the diagram with default settings
        Add-DiaCrossShapeLine

        # Visual representation:
        #         o
        #         |
        #         |
        #  o------o------o
        #         |
        #         |
        #         o

    .NOTES
        Version:        0.2.31
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        GitHub:         rebelinux

    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>
    param(
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as Start Node Name'
        )]
        [string] $CrossShapeStart = 'CrossShapeStart',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $CrossShapeEnd = 'CrossShapeEnd',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as Middle Node Name'
        )]
        [string] $CrossShapeMiddle = 'CrossShapeMiddle',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as CrossShapeMiddleTop Node Name'
        )]
        [string] $CrossShapeMiddleTop = 'CrossShapeMiddleTop',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as CrossShapeMiddleDown Node Name'
        )]
        [string] $CrossShapeMiddleDown = 'CrossShapeMiddleDown',

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
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $CrossShapeStartLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $CrossShapeEndLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $CrossShapeMiddleTopLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $CrossShapeMiddleDownLineLength = 1,

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
                Node $CrossShapeStart, $CrossShapeEnd @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
                Node $CrossShapeStart, $CrossShapeMiddleTop, $CrossShapeMiddleDown, $CrossShapeEnd @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
                Node $CrossShapeMiddle @{color = $Color; shape = 'point'; fillColor = $fillColor; style = $Style }
            } else {
                Node $CrossShapeStart, $CrossShapeMiddleTop, $CrossShapeMiddleDown, $CrossShapeEnd @{color = $Color; shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = $fillColor; style = $Style }
                Node $CrossShapeMiddle @{color = $Color; shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = $fillColor; style = $Style }
            }


            Rank $CrossShapeStart, $CrossShapeMiddle, $CrossShapeEnd

            Edge -From $CrossShapeStart -To $CrossShapeMiddle @{minlen = $CrossShapeStartLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $CrossShapeMiddle -To $CrossShapeEnd @{minlen = $CrossShapeEndLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $CrossShapeMiddleTop -To $CrossShapeMiddle @{minlen = $CrossShapeMiddleTopLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $CrossShapeMiddle -To $CrossShapeMiddleDown @{minlen = $CrossShapeMiddleDownLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}