function Add-DiaRightLShapeLine {
    <#
    .SYNOPSIS
        Adds a right-facing L-shaped connector to a diagram, composed of two lines and three nodes.
        Example:
                    (RightLShapeUp)
                            o_____o(RightLShapeRight)
                            |
          (RightLShapeDown) o

    .DESCRIPTION
        The Add-DiaRightLShapeLine function creates a right-facing L-shaped connector for use in diagram generation.
        It defines three nodes (Up, Down, and Right) and connects them with two lines to form an L shape:
            - A vertical line from the Up node to the Down node.
            - A horizontal line from the Up node to the Right node.
        The function allows customization of node names, line styles, arrow styles, colors, and lengths.
        It is intended for use with diagramming tools that support node and edge definitions, such as Graphviz.

    .PARAMETER RightLShapeUp
        The name of the starting node at the top of the L shape (Up direction). Default is 'RightLShapeUp'.

    .PARAMETER RightLShapeDown
        The name of the ending node at the bottom of the L shape (Down direction). Default is 'RightLShapeDown'.

    .PARAMETER RightLShapeRight
        The name of the rightmost node of the L shape (Right direction). Default is 'RightLShapeRight'.

    .PARAMETER Arrowtail
        The arrow style at the start of the line (arrowtail). Accepts various Graphviz arrow styles. Default is 'none'.

    .PARAMETER Arrowhead
        The arrow style at the end of the line (arrowhead). Accepts various Graphviz arrow styles. Default is 'none'.

    .PARAMETER LineStyle
        The style of the line (e.g., solid, dashed, dotted, bold, etc.). Default is 'solid'.

    .PARAMETER RightLShapeUpLineLength
        The minimum length of the vertical line from Up to Down. Range: 1 to 10. Default is 1.

    .PARAMETER RightLShapeDownLineLength
        The minimum length of the line from Down node (not used in current implementation). Range: 1 to 10. Default is 1.

    .PARAMETER RightLShapeRightLineLength
        The minimum length of the horizontal line from Up to Right. Range: 1 to 10. Default is 1.

    .PARAMETER LineWidth
        The width of the lines (penwidth). Range: 1 to 10. Default is 1.

    .PARAMETER LineColor
        The color of the lines. Accepts any valid Graphviz color. Default is 'black'.

    .PARAMETER IconDebug
        If set to $true, enables debug mode for icons, highlighting the nodes and lines in red for easier visualization.

    .EXAMPLE
        Add-DiaRightLShapeLine -RightLShapeUp "A" -RightLShapeDown "B" -RightLShapeRight "C" -LineColor "blue" -LineStyle "dashed"

        Creates a right-facing L-shaped connector with custom node names and a blue dashed line.

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
        [string] $RightLShapeUp = 'RightLShapeUp',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the ending node (Down direction) for the L shape.'
        )]
        [string] $RightLShapeDown = 'RightLShapeDown',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the right node (Right direction) for the L shape.'
        )]
        [string] $RightLShapeRight = 'RightLShapeRight',

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
        [int] $RightLShapeUpLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $RightLShapeDownLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $RightLShapeRightLineLength = 1,

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
                Node $RightLShapeUp, $RightLShapeDown, $RightLShapeRight @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
            } else {
                Node $RightLShapeUp, $RightLShapeDown, $RightLShapeRight @{color = $Color; shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = $fillColor; style = $Style }
            }

            Rank $RightLShapeUp, $RightLShapeRight

            Edge -From $RightLShapeUp -To $RightLShapeDown @{minlen = $RightLShapeUpLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $RightLShapeUp -To $RightLShapeRight @{minlen = $LineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }


        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}