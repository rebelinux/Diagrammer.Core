function Add-DiaInvertedLShapeLine {
    <#
    .SYNOPSIS
        Adds an inverted L-shaped line to a diagram, connecting three nodes with customizable styles and attributes.

                (InvertedLShapeUp)  o___o (InvertedLShapeRight)
        Example:                    |
                                    o
                            (InvertedLShapeDown)

    .DESCRIPTION
        The Add-DiaInvertedLShapeLine function creates an inverted L-shaped connector in a diagram by linking three nodes:
        - The "Up" node (vertical start)
        - The "Down" node (vertical end)
        - The "Right" node (horizontal branch)

        The function allows customization of arrow styles, line styles, widths, colors, and node appearance. It is useful for visually representing relationships or flows in diagrams where an inverted L-shape is needed.

    .PARAMETER InvertedLShapeUp
        The name of the starting node at the top of the inverted L-shape (vertical segment).

    .PARAMETER InvertedLShapeDown
        The name of the ending node at the bottom of the inverted L-shape (vertical segment).

    .PARAMETER InvertedLShapeRight
        The name of the node at the right end of the horizontal segment of the inverted L-shape.

    .PARAMETER Arrowtail
        The arrow style at the start of the line (tail). Accepts various Graphviz arrow styles.

    .PARAMETER Arrowhead
        The arrow style at the end of the line (head). Accepts various Graphviz arrow styles.

    .PARAMETER LineStyle
        The style of the line connecting the nodes (e.g., solid, dashed, dotted, bold, etc.).

    .PARAMETER LineWidth
        The width of the line (penwidth), from 1 to 10.

    .PARAMETER InvertedLShapeUpLineLength
        The minimum length of the vertical segment (from Up to Down), from 1 to 10.

    .PARAMETER InvertedLShapeRightLineLength
        The minimum length of the horizontal segment (from Up to Right), from 1 to 10.

    .PARAMETER LineColor
        The color of the line. Accepts any color supported by Graphviz (see https://graphviz.org/doc/info/colors.html).

    .PARAMETER IconDebug
        If set to $true, enables debug mode for icons, highlighting the nodes and lines in red for easier visualization.

    .EXAMPLE
        Add-DiaInvertedLShapeLine -InvertedLShapeUp "NodeA" -InvertedLShapeDown "NodeB" -InvertedLShapeRight "NodeC" -Arrowhead "normal" -LineStyle "dashed" -LineColor "blue"

        Creates an inverted L-shaped line from NodeA down to NodeB and right to NodeC, with a normal arrowhead, dashed blue line.

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
            HelpMessage = 'Name of the starting node (Up direction) for the L shape.'
        )]
        [string] $InvertedLShapeUp = 'InvertedLShapeUp',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the ending node (Down direction) for the L shape.'
        )]
        [string] $InvertedLShapeDown = 'InvertedLShapeDown',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the right node (Right direction) for the L shape.'
        )]
        [string] $InvertedLShapeRight = 'InvertedLShapeRight',

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
            HelpMessage = 'Width of the line (penwidth), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LineWidth = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Length of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $InvertedLShapeUpLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Width of the line (minlen), from 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $InvertedLShapeRightLineLength = 1,

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
                Node $InvertedLShapeDown, $InvertedLShapeRight, $InvertedLShapeUp @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
            } else {
                Node $InvertedLShapeDown, $InvertedLShapeRight, $InvertedLShapeUp @{shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = 'transparent'; style = $Style }
            }

            Rank $InvertedLShapeRight, $InvertedLShapeUp

            Edge -From $InvertedLShapeUp -To $InvertedLShapeDown @{minlen = $InvertedLShapeUpLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $InvertedLShapeUp -To $InvertedLShapeRight @{minlen = $InvertedLShapeRightLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }


        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}