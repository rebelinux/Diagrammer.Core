Function Get-DiaNodeFiller {
    <#
    .SYNOPSIS
        Function to create a html table used as Filler
    .DESCRIPTION
        Function to create a html table used as Filler
    .Example

        Get-DiaNodeFiller -IconDebug:$true
                    _________________
                    |               |
                    |      Icon     |
                    _________________

    .NOTES
        Version:        0.2.21
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
            Mandatory = $false,
            HelpMessage = 'Enables debug mode for icons, highlighting the table in red.'
        )]
        [bool] $IconDebug = $false
    )


    $ICON = 'BlankFiller.png'

    if ($IconDebug) {
        "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'>ICON</TD></TR></TABLE>"
    } else {
        "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='$($ICON)'/></TD></TR></TABLE>"
    }

}