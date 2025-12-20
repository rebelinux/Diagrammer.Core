function Add-DiaNodeImage {
    <#
    .SYNOPSIS
        Generates an HTML table for visualizing an image with customizable properties, such as border, style, and image size.

    .DESCRIPTION
        The Add-DiaNodeImage function creates an HTML table to display an image, typically used for diagramming nodes.
        It supports customization of the image's appearance, including border width, color, style, and image size percentage.
        The function also allows for debug mode, which highlights the table for easier troubleshooting, and supports specifying the image via a hashtable object.

    .PARAMETER Name
        Specifies the name of the node to be illustrated. This is a required parameter.

    .PARAMETER IconDebug
        Enables debug mode for icons. When set to $true, the table border is highlighted in red to assist with visual debugging.

    .PARAMETER IconPath
        Optionally specifies the full path to the icon image file. If not provided, the default image path is used.

    .PARAMETER ImageSizePercent
        Sets the size of the icon image as a percentage of its original size. Accepts values from 10 to 100. Default is 100%.

    .PARAMETER ImagesObj
        A required hashtable object containing available images. Used to retrieve the icon image for the node.

    .PARAMETER IconType
        Specifies the type of icon to use from the ImagesObj hashtable. This parameter is required and validates that ImagesObj is provided.

    .PARAMETER TableBorder
        Sets the width of the HTML table border in pixels. Default is 0 (no border).

    .PARAMETER TableBorderColor
        Specifies the color of the table border using a hex color code. Default is "#000000" (black).

    .PARAMETER TableBorderStyle
        Defines the style of the table border. Accepted values are: ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED.

    .EXAMPLE
        Add-DiaNodeImage -Name "MyNode" -ImagesObj $Images -IconType "ServerWindows" -ImageSizePercent 50 -TableBorder 1 -TableBorderColor "#FF0000" -TableBorderStyle "Solid"

        ** Generates an HTML table with a "ServerWindows" icon, 50% size, red solid border. **
                    _________________
                    |               |
                    |     Image     |
                    |               |
                    |_______________|

    .NOTES
        Author: Jonathan Colon
        Version: 0.2.36
        Twitter: @jcolonfzenpr
        Github: rebelinux

    #>

    [CmdletBinding()]
    [OutputType([System.String])]

    param(

        [Parameter(
            Mandatory,
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
            HelpMessage = 'Include the full path for the icon images (default is false)'
        )]
        [System.IO.FileInfo] $IconPath,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Set the image size in percent (100% is default)'
        )]
        [ValidateRange(1, 100)]
        [int] $ImageSizePercent = 100,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Please provide the Image Hashtable Object'
        )]
        [Hashtable] $ImagesObj,

        [Parameter(
            Mandatory = $true,
            HelpMessage = 'Allow to set the subgraph table icon'
        )]
        [ValidateScript({
                if ($ImagesObj) {
                    $true
                } else {
                    throw "ImagesObj hashtable needed if IconType option is especified."
                }
            })]
        [string] $IconType,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the width of the html table border'
        )]
        [int] $TableBorder = 0,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table border color'
        )]
        [string] $TableBorderColor = "#000000",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set a table style (ROUNDED, RADIAL, SOLID, INVISIBLE, INVIS, DOTTED, and DASHED)'
        )]
        [ValidateSet("ROUNDED", "RADIAL", "SOLID", "INVISIBLE", "INVIS", "DOTTED", "DASHED")]
        [string] $TableBorderStyle = "SOLID",

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Allow to set the text align'
        )]
        [switch] $NodeObject,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)'
        )]
        [hashtable] $GraphvizAttributes = @{}
    )


    if ($ImagesObj[$IconType]) {
        $ICON = $ImagesObj[$IconType]
    } else { $ICON = "no_icon.png" }

    if ($ImageSizePercent -lt 100) {
        if (-not $IconPath) {
            throw "IconPath is required when ImageSizePercent is less than 100."
        }
        $ImageSize = Get-DiaImagePercent -ImageInput (Join-Path -Path $IconPath -Child $ICON) -Percent $ImageSizePercent
    }

    if ($IconDebug) {
        $TRContent = '<TR><TD STYLE="{0}" ALIGN="Center" colspan="1">{1}</TD></TR>' -f "SOLID", $ICON

        $HTML = Format-HtmlTable -TableBackgroundColor "#FFCCCC" -TableBorderColor "red" -CellBorder 0 -CellSpacing $CellSpacing -CellPadding $CellPadding -TableRowContent $TRContent

        Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes -AsHtml:(-not $NodeObject)
    } else {
        if ($ImageSize) {

            $TRContent = '<TR><TD STYLE="{0}" ALIGN="Center" fixedsize="true" width="{1}" height="{2}" colspan="1"><img src="{3}"/></TD></TR>' -f $TableBorderStyle, $ImageSize.Width, $ImageSize.Height, $ICON

            $HTML = Format-HtmlTable -TableStyle $TableBorderStyle -TableBorder $TableBorder -TableBorderColor $TableBorderColor -CellBorder 0 -TableRowContent $TRContent

            Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes -AsHtml:(-not $NodeObject)
        } else {

            $TRContent = '<TR><TD STYLE="{0}" ALIGN="Center" colspan="1"><img src="{1}"/></TD></TR>' -f $TableBorderStyle, $ICON

            $HTML = Format-HtmlTable -TableStyle $TableBorderStyle -TableBorder $TableBorder -TableBorderColor $TableBorderColor -CellBorder 0 -TableRowContent $TRContent

            Format-NodeObject -Name $Name -HtmlObject $HTML -GraphvizAttributes $GraphvizAttributes -AsHtml:(-not $NodeObject)
        }
    }

}