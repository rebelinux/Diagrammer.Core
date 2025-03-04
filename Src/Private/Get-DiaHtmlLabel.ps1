Function Get-DiaHTMLLabel {
    <#
    .SYNOPSIS
        Converts a string to an HTML table for the report main logo and title.
    .DESCRIPTION
        This function takes a string and converts it into an HTML table format used for the report's main logo and title. It supports customization of the logo, font, and debug options.
    .EXAMPLE
        $MainGraphLabel = Switch ($DiagramType) {
            'Forest' { 'Active Directory Forest Diagram' }
            'Domain' { 'Active Directory Domain Diagram' }
            'Sites' { 'Active Directory Site Inventory Diagram' }
            'SitesTopology' { 'Active Directory Site Topology Diagram' }
        }
        $CustomLogo = "Logo Path"
        $IconDebug = $false
        Get-DiaHTMLLabel -Label $MainGraphLabel -IconType $CustomLogo -IconDebug $IconDebug
        # This will generate an HTML table with the specified label and logo.
    .NOTES
        Version:        0.2.17
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        GitHub:         rebelinux
    .PARAMETER Label
        The string used to set the Diagram Title. This parameter is mandatory.
    .PARAMETER SubgraphLabel
        Switch to create a table used to add a logo to a Graphviz subgraph.
    .PARAMETER IconType
        Specifies the main diagram logo type.
    .PARAMETER ImagesObj
        Hashtable containing the IconName to IconPath translation.
    .PARAMETER IconDebug
        Enables the table debug mode if set to $true.
    .PARAMETER IconWidth
        Specifies the width of the subgraph icon. Default is 40.
    .PARAMETER IconHeight
        Specifies the height of the subgraph icon. Default is 40.
    .PARAMETER Fontsize
        Specifies the font size of the label. Default is 1.
    .PARAMETER fontName
        Specifies the font name for the cell text. Default is "Segoe Ui Black".
    .PARAMETER fontColor
        Specifies the font color for the cell text. Default is "#565656".
    #>

    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide Label string to process'
        )]
        [string] $Label,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide Image hashtable to process'
        )]
        [Hashtable] $ImagesObj = @{},
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide Icon type to process'
        )]
        [string] $IconType,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Please provide SubgraphLabel to process'
        )]
        [Switch] $SubgraphLabel,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon width'
        )]
        [int] $IconWidth = 40,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a subgraph icon height'
        )]
        [int] $IconHeight = 40,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Enable the icon debug mode'
        )]
        [bool] $IconDebug,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a label font size'
        )]
        [int] $Fontsize = 1,
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font name'
        )]
        [string] $fontName = "Segoe Ui Black",
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The cell text font color'
        )]
        [string] $fontColor = "#565656"
    )

    if ($IconType -eq 'NoIcon') {
        $ICON = 'NoIcon'
    } elseif ($IconDebug) {
        $ICON = 'NoIcon'
    } elseif ($ImagesObj[$IconType]) {
        $ICON = $ImagesObj[$IconType]
    } else { $ICON = "no_icon.png" }

    if (-Not $SubgraphLabel) {
        # Todo add IconWidth and Icon Height
        if ($ICON -ne 'NoIcon') {
            if ($IconWidth -and $IconHeight) {
                return "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='$($IconWidth)' height='$($IconHeight)'><img src='$($ICON)'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='$($fontName)' Color='$($fontColor)' POINT-SIZE='$($Fontsize)'>$Label</FONT></TD></TR></TABLE>"

            } else {
                return "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='$($ICON)'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='$($fontName)' Color='$($fontColor)' POINT-SIZE='$($Fontsize)'>$Label</FONT></TD></TR></TABLE>"

            }
        } else {
            return "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'>Main Logo</TD></TR><TR><TD bgcolor='#FFCCCC' ALIGN='center' ><FONT FACE='$($fontName)' Color='$($fontColor)' POINT-SIZE='$($Fontsize)'>$Label</FONT></TD></TR><TR><TD ALIGN='center'><font color='red'>Debug ON</font></TD></TR></TABLE>"
        }
    }
    if ($SubgraphLabel) {
        if ($ICON -ne 'NoIcon') {
            return "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='$($IconWidth)' height='$($IconHeight)'><img src='$($ICON)'/></TD><TD ALIGN='center'><FONT FACE='$($fontName)' Color='$($fontColor)' POINT-SIZE='$($Fontsize)'>$Label</FONT></TD></TR></TABLE>"
        } else {
            return "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'>Subgraph Logo</TD><TD bgcolor='#FFCCCC' ALIGN='center'><FONT FACE='$($fontName)' Color='$($fontColor)' POINT-SIZE='$($Fontsize)'>$Label</FONT></TD></TR></TABLE>"
        }
    }
}