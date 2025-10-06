function Add-DiaVerticalLine {
    <#
    .SYNOPSIS
        Adds a customizable vertical line between two nodes in a diagram.

        Example:

            (VStart)o
                    |
                    |
                    o(VEnd)

        Demonstrates a vertical line connecting two nodes labeled 'VStart' and 'VEnd'.

    .DESCRIPTION
        The Add-DiaVerticalLine function creates a vertical line connecting two specified nodes within a diagram,
        supporting a variety of customization options. You can control the line's style (solid, dashed, etc.),
        length, width, and color, as well as the appearance of arrowheads or tails at either end. This function
        is ideal for visually representing relationships or connections between vertically aligned nodes in
        diagramming scenarios, such as organizational charts, flow diagrams, or network topologies.

    .PARAMETER VStart
        The name of the starting node for the vertical line. Defaults to 'VStart'.

    .PARAMETER VEnd
        The name of the ending node for the vertical line. Defaults to 'VEnd'.

    .PARAMETER Arrowtail
        Specifies the arrow style at the start (tail) of the line. Accepts Graphviz-supported arrow types
        such as 'none', 'normal', 'dot', 'diamond', etc.

    .PARAMETER Arrowhead
        Specifies the arrow style at the end (head) of the line. Accepts Graphviz-supported arrow types
        such as 'none', 'normal', 'dot', 'diamond', etc.

    .PARAMETER LineStyle
        Sets the style of the line. Valid values include 'solid', 'dashed', 'dotted', 'bold', 'invis',
        'filled', and 'tapered'.

    .PARAMETER VStartLineLength
        Determines the minimum length of the vertical line (minlen), in units from 1 to 10.

    .PARAMETER LineWidth
        Sets the thickness of the vertical line (penwidth), in units from 1 to 10.

    .PARAMETER LineColor
        Specifies the color of the vertical line. Accepts any color name or code supported by Graphviz.
        Defaults to 'black'.

    .PARAMETER IconDebug
        Switch to enable debug mode, which highlights the line and nodes for troubleshooting purposes.
        When enabled, nodes and lines are rendered in red for visibility.

    .EXAMPLE
        Add-DiaVerticalLine -VStart "NodeA" -VEnd "NodeB" -LineStyle "dashed" -LineColor "blue" -LineWidth 2

        Draws a dashed blue vertical line of width 2 between nodes "NodeA" and "NodeB".

    .EXAMPLE
        Add-DiaVerticalLine -IconDebug $true

        Draws a vertical line between the default nodes, highlighting the line and nodes in red for debugging.

    .NOTES
        Version:        0.2.31
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        GitHub:         rebelinux

    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>

    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Start node name for the vertical line.'
        )]
        [string] $VStart = 'VStart',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'End node name for the vertical line.'
        )]
        [string] $VEnd = 'VEnd',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Arrow style at the start of the line. See Graphviz documentation for supported types.'
        )]
        [ValidateSet(
            'none', 'normal', 'inv', 'dot', 'invdot', 'odot', 'invodot', 'diamond', 'odiamond', 'ediamond', 'crow', 'box', 'obox', 'open', 'halfopen', 'empty', 'invempty', 'tee', 'vee', 'icurve', 'lcurve', 'rcurve', 'icurve', 'box', 'obox', 'diamond', 'odiamond', 'ediamond', 'crow', 'tee', 'vee', 'dot', 'odot', 'inv', 'invodot', 'invempty', 'invbox', 'invodiamond', 'invtee', 'invvee', 'none'
        )]
        [string] $Arrowtail = 'none',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Arrow style at the end of the line. See Graphviz documentation for supported types.'
        )]
        [ValidateSet(
            'none', 'normal', 'inv', 'dot', 'invdot', 'odot', 'invodot', 'diamond', 'odiamond', 'ediamond', 'crow', 'box', 'obox', 'open', 'halfopen', 'empty', 'invempty', 'tee', 'vee', 'icurve', 'lcurve', 'rcurve', 'icurve', 'box', 'obox', 'diamond', 'odiamond', 'ediamond', 'crow', 'tee', 'vee', 'dot', 'odot', 'inv', 'invodot', 'invempty', 'invbox', 'invodiamond', 'invtee', 'invvee', 'none'
        )]
        [string] $Arrowhead = 'none',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Line style (e.g., solid, dashed, dotted, bold, invis, filled, tapered).'
        )]
        [ValidateSet('dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered')]
        [string] $LineStyle = 'solid',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the vertical line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $VStartLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Line width (penwidth), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LineWidth = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Line color. Default is black. See https://graphviz.org/doc/info/colors.html for supported colors.'
        )]
        [string] $LineColor = "black",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enable debug mode to highlight the line and nodes for troubleshooting.'
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
                Node $VStart, $VEnd @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
            } else {
                Node $VStart, $VEnd @{color = $Color; shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = $fillColor; style = $Style }
            }

            Edge -From $VStart -To $VEnd @{minlen = $VStartLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }

        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}