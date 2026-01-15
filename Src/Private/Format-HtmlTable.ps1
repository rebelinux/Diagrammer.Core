function Format-HtmlTable {
    <#
        .SYNOPSIS
            Constructs an HTML <TABLE> element string from the provided layout and style parameters (Port, TableStyle, colors, borders, spacing, padding). Returns the generated HTML table markup as a string for embedding in Graphviz labels or HTML output.

        .DESCRIPTION
            Constructs an HTML <TABLE> element string based on the specified parameters, including Port, TableStyle, colors, borders, spacing, and padding. This function returns the generated HTML table markup as a string, suitable for embedding in Graphviz labels or HTML output.

        .PARAMETER Port
            The Node Port to name.

        .PARAMETER TableStyle
            The style of the table. Default is 'Solid'.

        .PARAMETER TableBackgroundColor
            The background color of the table. Default is 'white'.

        .PARAMETER TableBorder
            The border size of the table. Default is 1.

        .PARAMETER TableBorderColor
            The border color of the table. Default is 'white'.

        .PARAMETER CellBorder
            The border size of the table cells. Default is 1.

        .PARAMETER CellSpacing
            The spacing between table cells. Default is 1.

        .PARAMETER CellPadding
            The padding inside table cells. Default is 1.

        .PARAMETER TableRowContent
            The content of the table rows. Default is an empty string.
    #>
    param (
        [Parameter(
            HelpMessage = 'The text to be formatted.')]
        [string]$Port = 'EdgeDot',

        [Parameter(
            HelpMessage = "The style of the table. Default is 'Solid'."
        )]
        [string]$TableStyle = 'Solid',

        [Parameter(
            HelpMessage = "The background color of the table. Default is 'black'."
        )]
        [string]$TableBackgroundColor = 'white',

        [Parameter(
            HelpMessage = 'The border size of the table. Default is 1.'
        )]
        [int]$TableBorder = 1,

        [Parameter(
            HelpMessage = "The border color of the table. Default is 'black'."
        )]
        [string]$TableBorderColor = 'black',

        [Parameter(
            HelpMessage = 'Switch to underline the font.'
        )]
        [int]$CellBorder = 1,

        [Parameter(
            HelpMessage = 'The spacing between table cells. Default is 1.'
        )]
        [int]$CellSpacing = 1,

        [Parameter(
            HelpMessage = 'The padding inside table cells. Default is 1.'
        )]
        [int]$CellPadding = 1,

        [Parameter(
            Mandatory,
            HelpMessage = 'The Table Row content.'
        )]
        [AllowEmptyString()]
        [string]$TableRowContent
    )

    # Build an HTML table dynamically from the input parameters

    # Compose table attributes (using cellspacing/cellpadding for compatibility)
    $tableAttrs = 'PORT="{0}" STYLE="{1}" BORDER="{2}" CELLBORDER="{3}" CELLSPACING="{4}" CELLPADDING="{5}" BGCOLOR="{6}" COLOR="{7}"' -f $Port, $TableStyle, $TableBorder, $CellBorder, $CellSpacing, $CellPadding, $TableBackgroundColor, $TableBorderColor

    # Build the HTML table (single cell containing the Port). Adjust structure here to add rows/cols as needed.
    $html = "<TABLE $tableAttrs>$TableRowContent</TABLE>"

    return $html
}