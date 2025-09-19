function Add-DiaNodeSpacer {
    <#
    .SYNOPSIS
        Function to create a node share (rectangle) used as Spacer
    .DESCRIPTION
        Function to create a node share (rectangle) used as Spacer
    .Example

        Add-DiaNodeSpacer -IconDebug:$true
                    _________________
                    |               |
                    |      Icon     |
                    _________________

    .NOTES
        Version:        0.2.30
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux

    .PARAMETER IconDebug
        Enables debug mode for icons, highlighting the table in red.

    #>

    [CmdletBinding()]
    [OutputType([System.String])]

    param(

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Name of the Node.'
        )]
        [string] $Name,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enables debug mode for icons, highlighting the table in red.'
        )]
        [Alias("DraftMode")]
        [bool] $IconDebug = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Width.'
        )]
        [ValidateRange(0, 10)]
        [float] $ShapeWidth = 2,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Height.'
        )]
        [ValidateRange(0, 10)]
        [float] $ShapeHeight = 1,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Shape Orientation (0-360 degrees).'
        )]
        [ValidateRange(0, 360)]
        [int] $ShapeOrientation = 0,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Direction of the icon.'
        )]
        [ValidateSet('Vertical', 'Horizontal')]
        [string] $Direction = 'Vertical'
    )


    if ($IconDebug) {
        Node -Name $Name @{label = $Name; labelloc = 'c'; color = 'red'; shape = 'rectangle'; fillcolor = '#FFCCCC'; style = 'filled'; orientation = $ShapeOrientation; height = $ShapeHeight; width = $ShapeWidth; penwidth = 1 }
    } else {
        Node -Name $Name @{label = $Name; labelloc = 'c'; color = 'black'; shape = 'rectangle'; fillcolor = 'transparent'; style = 'invis'; orientation = $ShapeOrientation; height = $ShapeHeight; width = $ShapeWidth; penwidth = 1 }
    }
}