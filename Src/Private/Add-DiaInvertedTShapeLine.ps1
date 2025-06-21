function Add-DiaInvertedTShapeLine {
    <#
    .SYNOPSIS
        Creates an inverted T-shaped ( _|_ ) connector in a diagram, linking four nodes with customizable line styles, colors, and attributes.

        Example:
                            (InvertedTMiddleTop)
                                    o
                                    |
                (InvertedTStart)o___|___o(InvertedTEnd)
                                    o
                            (InvertedTMiddleDown)

    .DESCRIPTION
        The Add-DiaInvertedTShapeLine function generates an inverted T-shaped structure in a diagram by connecting four specified nodes:
            - InvertedTStart: The left endpoint of the horizontal line.
            - InvertedTEnd: The right endpoint of the horizontal line.
            - InvertedTMiddleTop: The top endpoint of the vertical line.
            - InvertedTMiddleDown: The intersection point (center of the T).

        The function allows customization of line style, color, width, and arrowheads/tails for each segment. It also supports a debug mode to visually highlight the nodes for troubleshooting.

    .PARAMETER InvertedTStart
        The name of the node at the start (left) of the horizontal line. Default is 'InvertedTStart'.

    .PARAMETER InvertedTEnd
        The name of the node at the end (right) of the horizontal line. Default is 'InvertedTEnd'.

    .PARAMETER InvertedTMiddleTop
        The name of the node at the top of the vertical line. Default is 'InvertedTMiddleTop'.

    .PARAMETER InvertedTMiddleDown
        The name of the node at the intersection (center) of the T. Default is 'InvertedTMiddleDown'.

    .PARAMETER Arrowtail
        The style of the arrow tail for the lines. Accepts various Graphviz arrow types. Default is 'none'.

    .PARAMETER Arrowhead
        The style of the arrow head for the lines. Accepts various Graphviz arrow types. Default is 'none'.

    .PARAMETER LineStyle
        The style of the line connecting the nodes. Options include 'dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered'. Default is 'solid'.

    .PARAMETER InvertedTStartLineLength
        The minimum length of the line from InvertedTStart to InvertedTMiddleDown (1-10). Default is 1.

    .PARAMETER InvertedTEndLineLength
        The minimum length of the line from InvertedTMiddleDown to InvertedTEnd (1-10). Default is 1.

    .PARAMETER InvertedTMiddleTopLength
        The minimum length of the line from InvertedTMiddleTop to InvertedTMiddleDown (1-10). Default is 1.

    .PARAMETER LineWidth
        The width of the lines (penwidth), from 1 to 10. Default is 1.

    .PARAMETER LineColor
        The color of the lines. Accepts any valid Graphviz color. Default is 'black'.

    .PARAMETER IconDebug
        Switch to enable debug mode, which highlights the nodes and lines in red for easier troubleshooting. Default is $false.

    .EXAMPLE
        Add-DiaInvertedTShapeLine -InvertedTStart "A" -InvertedTEnd "B" -InvertedTMiddleTop "C" -InvertedTMiddleDown "D" -LineColor "blue" -LineStyle "dashed"

        Creates an inverted T-shaped connector with custom node names, blue dashed lines, and default arrow styles.

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
        [string] $InvertedTStart = 'InvertedTStart',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $InvertedTEnd = 'InvertedTEnd',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $InvertedTMiddleTop = 'InvertedTMiddleTop',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $InvertedTMiddleDown = 'InvertedTMiddleDown',

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
        [int] $InvertedTStartLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $InvertedTEndLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $InvertedTMiddleTopLength = 1,

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
                Node $InvertedTStart, $InvertedTMiddleTop, $InvertedTEnd, $InvertedTMiddleDown @{scolor = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
            } else {
                Node $InvertedTStart, $InvertedTMiddleTop, $InvertedTEnd, $InvertedTMiddleDown @{shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = 'transparent'; style = $Style }
            }

            Rank $InvertedTStart, $InvertedTMiddleDown, $InvertedTEnd

            Edge -From $InvertedTStart -To $InvertedTMiddleDown @{minlen = $InvertedTStartLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }

            Edge -From $InvertedTMiddleDown -To $InvertedTEnd @{minlen = $InvertedTEndLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }

            Edge -From $InvertedTMiddleTop -To $InvertedTMiddleDown @{minlen = $InvertedTMiddleTopLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }


        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}