function Add-DiaCrossShapeLine {
    <#
    .SYNOPSIS
        Creates and adds a cross-shaped line object to the diagram with customizable nodes, style, and color options.
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
        Function to create a Cross shape object in the diagram.
    .NOTES
        Version:        0.6.30
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>

    [CmdletBinding()]

    [CmdletBinding()]
    [OutputType([System.String])]
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
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [ValidateRange(1, 10)]
        [int] $LineLength = 1,

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