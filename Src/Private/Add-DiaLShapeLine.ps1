function Add-DiaLShapeLine {
    <#
    .SYNOPSIS
        Adds an L-shaped connector to a diagram, composed of two lines and three nodes.

        Example:
                    (LShapeUp)
                        o
                        |
            (LShapeDown)o___o(LShapeRight)

    .DESCRIPTION
        The Add-DiaLShapeLine function creates an L-shaped connector for use in diagram generation, such as with Graphviz or similar tools.
        The connector consists of two lines joined at a corner node, forming an "L" shape. The function allows customization of node names,
        arrow styles, line styles, lengths, widths, and colors. It also supports a debug mode for visualizing node placement.

    .PARAMETER LShapeUp
        The name of the starting node (vertical segment, "up" direction) for the L shape. Default is 'LShapeUp'.

    .PARAMETER LShapeDown
        The name of the corner node (where the vertical and horizontal segments meet, "down" direction). Default is 'LShapeDown'.

    .PARAMETER LShapeRight
        The name of the ending node (horizontal segment, "right" direction) for the L shape. Default is 'LShapeRight'.

    .PARAMETER Arrowtail
        The arrow style at the start of each line (Graphviz 'arrowtail' attribute). Accepts various styles such as 'none', 'normal', 'dot', etc. Default is 'none'.

    .PARAMETER Arrowhead
        The arrow style at the end of each line (Graphviz 'arrowhead' attribute). Accepts various styles such as 'none', 'normal', 'dot', etc. Default is 'none'.

    .PARAMETER LineStyle
        The style of the connector lines. Valid values are 'dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered'. Default is 'solid'.

    .PARAMETER LShapeUpLineLength
        The length of the vertical segment (minlen), from 1 to 10. Default is 1.

    .PARAMETER LShapeRightLineLength
        The length of the horizontal segment (minlen), from 1 to 10. Default is 1.

    .PARAMETER LineWidth
        The width of the connector lines (penwidth), from 1 to 10. Default is 1.

    .PARAMETER LineColor
        The color of the connector lines. Accepts any color supported by Graphviz (see https://graphviz.org/doc/info/colors.html). Default is 'black'.

    .PARAMETER IconDebug
        If set to $true, enables debug mode for icons, highlighting the nodes and lines in red for easier visualization. Default is $false.

    .EXAMPLE
        Add-DiaLShapeLine -LShapeUp "Start" -LShapeDown "Corner" -LShapeRight "End" -Arrowhead "normal" -LineStyle "dashed" -LineColor "blue"

        Creates an L-shaped connector from node "Start" down to "Corner", then right to "End", with a normal arrowhead, dashed blue lines.

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
            HelpMessage = 'Name of the starting node (Up direction) for the L shape.'
        )]
        [string] $LShapeUp = 'LShapeUp',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the ending node (Down direction) for the L shape.'
        )]
        [string] $LShapeDown = 'LShapeDown',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the right node (Right direction) for the L shape.'
        )]
        [string] $LShapeRight = 'LShapeRight',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Arrow style at the start of the line (arrowtail).'
        )]
        [ValidateSet(
            'none', 'normal', 'inv', 'dot', 'invdot', 'odot', 'invodot', 'diamond', 'odiamond', 'ediamond', 'crow', 'box', 'obox', 'open', 'halfopen', 'empty', 'invempty', 'tee', 'vee', 'icurve', 'lcurve', 'rcurve', 'icurve', 'box', 'obox', 'diamond', 'odiamond', 'ediamond', 'crow', 'tee', 'vee', 'dot', 'odot', 'inv', 'invodot', 'invempty', 'invbox', 'invodiamond', 'invtee', 'invvee', 'none'
        )]
        [string] $Arrowtail = 'none',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Arrow style at the end of the line (arrowhead).'
        )]
        [ValidateSet(
            'none', 'normal', 'inv', 'dot', 'invdot', 'odot', 'invodot', 'diamond', 'odiamond', 'ediamond', 'crow', 'box', 'obox', 'open', 'halfopen', 'empty', 'invempty', 'tee', 'vee', 'icurve', 'lcurve', 'rcurve', 'icurve', 'box', 'obox', 'diamond', 'odiamond', 'ediamond', 'crow', 'tee', 'vee', 'dot', 'odot', 'inv', 'invodot', 'invempty', 'invbox', 'invodiamond', 'invtee', 'invvee', 'none'
        )]
        [string] $Arrowhead = 'none',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Style of the line (e.g., solid, dashed, dotted, etc.).'
        )]
        [ValidateSet('dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered')]
        [string] $LineStyle = 'solid',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LShapeUpLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LShapeRightLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Width of the line (penwidth), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LineWidth = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Color of the line. See https://graphviz.org/doc/info/colors.html for supported colors.'
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
                Node $LShapeUp, $LShapeRight, $LShapeDown @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }

            } else {
                Node $LShapeUp, $LShapeRight, $LShapeDown @{shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = 'transparent'; style = $Style }
            }

            Rank $LShapeRight, $LShapeDown

            Edge -From $LShapeUp -To $LShapeDown @{minlen = $LShapeUpLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }

            Edge -From $LShapeDown -To $LShapeRight @{minlen = $LShapeRightLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }


        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}