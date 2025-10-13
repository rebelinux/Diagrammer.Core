function Add-DiaLeftLShapeLine {
    <#
    .SYNOPSIS
        Adds a left-oriented L-shaped connector to a diagram, composed of two lines and three nodes.

        Example:
                        (LeftLShapeUp)
        (LeftLShapeLeft) o______o
                                |
                                |
                                o (LeftLShapeDown)

    .DESCRIPTION
        The Add-DiaLeftLShapeLine function creates a left-facing L-shaped connector for use in diagram generation, such as with Graphviz.
        The connector consists of two lines (vertical and horizontal) and three nodes, allowing for customizable styles, colors, arrowheads, and lengths.
        This function is useful for visually representing relationships or flows in diagrams where an L-shaped connection is required.

    .PARAMETER LeftLShapeUp
        The name of the starting node at the top of the L shape (vertical segment). Default is 'LeftLShapeUp'.

    .PARAMETER LeftLShapeDown
        The name of the ending node at the bottom of the L shape (vertical segment). Default is 'LeftLShapeDown'.

    .PARAMETER LeftLShapeLeft
        The name of the node at the left end of the L shape (horizontal segment). Default is 'LeftLShapeLeft'.

    .PARAMETER Arrowtail
        The arrow style at the start of the line (arrowtail). Accepts various Graphviz arrow styles. Default is 'none'.

    .PARAMETER Arrowhead
        The arrow style at the end of the line (arrowhead). Accepts various Graphviz arrow styles. Default is 'none'.

    .PARAMETER LineStyle
        The style of the line (e.g., solid, dashed, dotted, etc.). Default is 'solid'.

    .PARAMETER LeftLShapeUpLineLength
        The length (minlen) of the vertical segment of the L shape, from 1 to 10. Default is 1.

    .PARAMETER LeftLShapeLeftLineLength
        The length (minlen) of the horizontal segment of the L shape, from 1 to 10. Default is 1.

    .PARAMETER LineWidth
        The width (penwidth) of the lines, from 1 to 10. Default is 1.

    .PARAMETER LineColor
        The color of the lines. Accepts any color supported by Graphviz. Default is 'black'.

    .PARAMETER IconDebug
        If set to $true, enables debug mode, highlighting the nodes and lines in red for easier visualization during development.

    .EXAMPLE
        Add-DiaLeftLShapeLine -LeftLShapeUp "StartNode" -LeftLShapeDown "EndNode" -LeftLShapeLeft "LeftNode" -LineColor "blue" -LineStyle "dashed"

        Creates a blue, dashed, left-oriented L-shaped connector between the specified nodes.

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
        [string] $LeftLShapeUp = 'LeftLShapeUp',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the ending node (Down direction) for the L shape.'
        )]
        [string] $LeftLShapeDown = 'LeftLShapeDown',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the right node (Right direction) for the L shape.'
        )]
        [string] $LeftLShapeLeft = 'LeftLShapeLeft',

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
        [int] $LeftLShapeUpLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LeftLShapeLeftLineLength = 1,

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
                Node $LeftLShapeUp, $LeftLShapeDown, $LeftLShapeLeft @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }

            } else {
                Node $LeftLShapeUp, $LeftLShapeDown, $LeftLShapeLeft @{shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = 'transparent'; style = $Style }
            }

            Rank $LeftLShapeUp, $LeftLShapeLeft
            Edge -From $LeftLShapeUp -To $LeftLShapeDown @{minlen = $LeftLShapeUpLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $LeftLShapeLeft -To $LeftLShapeUp @{minlen = $LeftLShapeLeftLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }


        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}