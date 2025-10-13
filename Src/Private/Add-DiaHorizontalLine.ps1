function Add-DiaHorizontalLine {
    <#
    .SYNOPSIS
        Creates a customizable horizontal line between two nodes in a diagram.
        Example:

                (HStart)o-----------------o(Hend)

    .DESCRIPTION
        The Add-DiaHorizontalLine function generates a horizontal line between two specified nodes, allowing for extensive customization of the line's appearance.
        You can specify the start and end node names, arrow styles at both ends, line style, length, width, and color.
        The function is designed for use with diagramming tools (such as Graphviz) and supports debug mode for visual troubleshooting.

    .PARAMETER HStart
        The name of the start node for the horizontal line. Default is 'HStart'.

    .PARAMETER HEnd
        The name of the end node for the horizontal line. Default is 'HEnd'.

    .PARAMETER Arrowtail
        The arrow style at the start of the line. Accepts values such as 'none', 'normal', 'inv', 'dot', etc. Default is 'none'.

    .PARAMETER Arrowhead
        The arrow style at the end of the line. Accepts values such as 'none', 'normal', 'inv', 'dot', etc. Default is 'none'.

    .PARAMETER LineStyle
        The style of the line. Valid values are 'dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered'. Default is 'solid'.

    .PARAMETER HStartLineLength
        The minimum length of the line (minlen). Valid range is 1 to 10. Default is 1.

    .PARAMETER LineWidth
        The width of the line (penwidth). Valid range is 1 to 10. Default is 1.

    .PARAMETER LineColor
        The color of the line. Default is 'black'. Refer to https://graphviz.org/doc/info/colors.html for supported color names.

    .PARAMETER IconDebug
        Switch to enable debug mode, which highlights the nodes and line in red for troubleshooting. Alias: DraftMode. Default is $false.

    .EXAMPLE
        Add-DiaHorizontalLine -HStart "NodeA" -HEnd "NodeB" -LineStyle "dashed" -LineColor "blue" -Arrowhead "normal"

        Creates a dashed blue horizontal line from NodeA to NodeB with a normal arrowhead at the end.

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
            HelpMessage = 'Specifies the name of the start node for the horizontal line.'
        )]
        [string] $HStart = 'HStart',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the name of the end node for the horizontal line.'
        )]
        [string] $HEnd = 'HEnd',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the arrow style at the start of the line. Default is "none".'
        )]
        [ValidateSet(
            'none', 'normal', 'inv', 'dot', 'invdot', 'odot', 'invodot', 'diamond', 'odiamond', 'ediamond', 'crow', 'box', 'obox', 'open', 'halfopen', 'empty', 'invempty', 'tee', 'vee', 'icurve', 'lcurve', 'rcurve', 'icurve', 'box', 'obox', 'diamond', 'odiamond', 'ediamond', 'crow', 'tee', 'vee', 'dot', 'odot', 'inv', 'invodot', 'invempty', 'invbox', 'invodiamond', 'invtee', 'invvee', 'none'
        )]
        [string] $Arrowtail = 'none',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the arrow style at the end of the line. Default is "none".'
        )]
        [ValidateSet(
            'none', 'normal', 'inv', 'dot', 'invdot', 'odot', 'invodot', 'diamond', 'odiamond', 'ediamond', 'crow', 'box', 'obox', 'open', 'halfopen', 'empty', 'invempty', 'tee', 'vee', 'icurve', 'lcurve', 'rcurve', 'icurve', 'box', 'obox', 'diamond', 'odiamond', 'ediamond', 'crow', 'tee', 'vee', 'dot', 'odot', 'inv', 'invodot', 'invempty', 'invbox', 'invodiamond', 'invtee', 'invvee', 'none'
        )]
        [string] $Arrowhead = 'none',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the style of the line. Valid values: dashed, dotted, solid, bold, invis, filled, tapered.'
        )]
        [ValidateSet('dashed', 'dotted', 'solid', 'bold', 'invis', 'filled', 'tapered')]
        [string] $LineStyle = 'solid',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the length of the line (minlen). Valid range: 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $HStartLineLength = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the width of the line (penwidth). Valid range: 1 to 10.'
        )]
        [ValidateRange(1, 10)]
        [int] $LineWidth = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Specifies the color of the line. Default is black. See https://graphviz.org/doc/info/colors.html for supported colors.'
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
                Node $HStart, $HEnd @{color = $Color; shape = $Shape; fillColor = $fillColor; style = $Style }
            } else {
                Node $HStart, $HEnd @{color = $Color; shape = $Shape; fixedsize = 'true'; width = .001 ; height = .001; fillColor = $fillColor; style = $Style }
            }
            Rank $HStart, $HEnd
            Edge -From $HStart -To $HEnd @{minlen = $HStartLineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }

        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}