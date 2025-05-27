Function Add-DiaNodeFiller {
    <#
    .SYNOPSIS
        Function to create a html table used as Filler
    .DESCRIPTION
        Function to create a html table used as Filler
    .Example

        Add-DiaNodeFiller -IconDebug:$true
                    _________________
                    |               |
                    |      Icon     |
                    _________________

    .NOTES
        Version:        0.2.27
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux

    .PARAMETER IconDebug
        Enables debug mode for icons, highlighting the table in red.

    #>

    [CmdletBinding()]
    [Alias('Get-DiaNodeFiller')]
    [OutputType([System.String])]

    param(

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enables debug mode for icons, highlighting the table in red.'
        )]
        [bool] $IconDebug = $false,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Direction of the icon.'
        )]
        [ValidateSet('Vertical', 'Horizontal')]
        [string] $Direction = 'Vertical',

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide the Image Hashtable Object'
        )]
        [Hashtable] $ImagesObj,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the subgraph table icon'
        )]
        [ValidateScript({
                if ($ImagesObj) {
                    $true
                } else {
                    throw "ImagesObj table needed if IconType option is especified."
                }
            })]
        [string]$IconType = 'BlankFiller'
    )


    $ICON = 'BlankFiller.png'

    if ($IconDebug) {
        "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'>Spacer</TD></TR></TABLE>"
    } else {
        "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='$($ICON)'/></TD></TR></TABLE>"
    }

}