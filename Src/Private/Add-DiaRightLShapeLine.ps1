function Add-DiaRightLShapeLine {
    <#
    .SYNOPSIS
        Creates an Right L-shaped connector composed of two lines and nodes for use in diagram generation.
        Example:
                    (LShapeUp)
                        o_____o(LShapeRight)
                        |
            (LShapeDown)o

    .DESCRIPTION
        Function to create a Right L shape object in the diagram.
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
            HelpMessage = 'Name of the starting node (Up direction) for the L shape.'
        )]
        [string] $StartName = 'LShapeUp',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the ending node (Down direction) for the L shape.'
        )]
        [string] $EndName = 'LShapeDown',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Name of the right node (Right direction) for the L shape.'
        )]
        [string] $RightName = 'LShapeRight',

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
        [int] $LineLength = 1,

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
        [string] $LineColor = "black"
    )

    begin {
    }

    process {
        try {
            Node $StartName, $EndName @{shape = 'none'; fixedsize = 'true'; width = .001 ; height = .001; fillColor = 'transparent'; style = 'invis' }
            Node $RightName @{shape = 'point'; fixedsize = 'true'; width = .001 ; height = .001; fillColor = 'transparent'; style = 'filled' }
            Rank $StartName, $RightName
            Edge -From $StartName -To $EndName @{minlen = $LineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }
            Edge -From $StartName -To $RightName @{minlen = $LineLength; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor; penwidth = $LineWidth }


        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}