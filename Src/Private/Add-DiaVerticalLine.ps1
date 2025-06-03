function Add-DiaVerticalLine {
    <#
    .SYNOPSIS
        Function to create a vertical line in the diagram.
    .DESCRIPTION
        Function to create a vertical line in the diagram.
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
        [string] $StartName = 'VStart',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide a string to be used as End Node Name'
        )]
        [string] $EndName = 'VEnd',

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
            Node $StartName, $EndName @{shape = 'none'; fixedsize = 'true'; width = .2 ; height = .2; fillColor = 'transparent'; style = 'invis' }
            Edge -From $StartName -To $EndName @{minlen = $LineSize; arrowtail = $Arrowtail; arrowhead = $Arrowhead; style = $LineStyle; color = $LineColor }

        } catch {
            Write-Verbose -Message $_.Exception.Message
        }
    }
    end {}
}