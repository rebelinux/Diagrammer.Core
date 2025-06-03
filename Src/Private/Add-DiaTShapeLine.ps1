function Add-DiaTShapeLine {
    <#
    .SYNOPSIS
        Function to create a T shape object in the diagram.
    .DESCRIPTION
        Function to create a T shape object in the diagram.
    .NOTES
        Version:        0.6.30
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>

    # Todo: Add support for creating more than 1 line and able to join them with Rank parameter.
    [CmdletBinding()]

    [CmdletBinding()]
    [OutputType([System.String])]
    param(
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as Start Node Name'
        )]
        [string] $StartName = 'TStart',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $EndName = 'TEnd',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $MiddleTop = 'TMiddleTop',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $MiddleDown = 'TMiddleDown',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $Arrowtail = 'none',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
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
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [ValidateRange(1, 10)]
        [int] $LineSize = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a color to be used in the line. Default is black. Supported color https://graphviz.org/doc/info/colors.html'
        )]
        [string] $LineColor = "black"
    )

    begin {
    }

    process {
        try {
            Node $StartName, $MiddleDown, $EndName @{shape = 'none'; fixedsize = 'true'; width = .001 ; height = .001; fillColor = 'transparent'; style = 'invis' }
            Node $MiddleTop @{shape = 'point'; fixedsize = 'true'; width = .001 ; height = .001; fillColor = 'transparent'; style = 'filled' }
            Rank $StartName, $MiddleTop, $EndName
            Edge -From $StartName -To $MiddleTop @{minlen = $LineSize; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor }
            Edge -From $MiddleTop -To $EndName @{minlen = $LineSize; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor }
            Edge -From $MiddleTop -To $MiddleDown @{minlen = $LineSize; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor }


        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}