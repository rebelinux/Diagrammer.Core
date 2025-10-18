function Convert-DiaTableToHTML {
    <#
    .SYNOPSIS
    Creates a html table object

    .DESCRIPTION
    Creates a table object that contains rows of data.

    .PARAMETER Name
    The table name for this record

    .PARAMETER Label
    The label to use for the headder of the table.

    .PARAMETER FontName
    The table shape based on: https://graphviz.org/doc/info/shapes.html.

    .PARAMETER FontSize
    The table font size.

    .PARAMETER Style
    The table drawing style based on: https://graphviz.org/docs/attr-types/style/.

    .PARAMETER Penwidth
    The table line width.

    .PARAMETER FillColor
    The table fill color.

    .PARAMETER HeaderColor
    The table header cell color.

    .PARAMETER HeaderFontColor
    The table header font color.

    .PARAMETER BorderColor
    The table border color.

    .PARAMETER Row
    An array of strings/objects to place in this record

    .PARAMETER RowScript
    A script to run on each row

    .PARAMETER ScriptBlock
    A sub expression that contains Row commands

    .PARAMETER IconDebug
    Set the table debug mode

    .EXAMPLE

    .NOTES
    Early release version of this command.
    A lot of stuff is hard coded that should be exposed as attributes

    #>
    [OutputType('System.String')]
    [cmdletbinding(DefaultParameterSetName = 'Script')]
    param(
        [Parameter(
            Mandatory,
            Position = 0,
            HelpMessage = "The table name for this record"
        )]
        [alias('ID', 'Node')]
        [string]
        $Name,

        [Parameter(
            Position = 1,
            ValueFromPipeline,
            ParameterSetName = 'Strings',
            HelpMessage = "An array of strings/objects to place in this record"
        )]
        [alias('Rows')]
        [Object[]]
        $Row,

        [Parameter(
            Position = 1,
            ParameterSetName = 'Script',
            HelpMessage = "A sub expression that contains Row commands"
        )]
        [ScriptBlock]
        $ScriptBlock,

        [Parameter(
            Position = 2,
            HelpMessage = "A script to run on each row"
        )]
        [ScriptBlock]
        $RowScript,

        [Parameter(
            HelpMessage = "The label to use for the header of the table."
        )]
        [string]
        $Label,

        [Parameter(
            HelpMessage = "The table shape based on: https://graphviz.org/doc/info/shapes.html."
        )]
        [string]
        $FontName = "Segoe UI",

        [Parameter(
            HelpMessage = "The table font size."
        )]
        [int]
        $FontSize = 14,

        [Parameter(
            HelpMessage = "The table drawing style based on: https://graphviz.org/docs/attr-types/style/."
        )]
        [string]
        $Style = "filled",

        [Parameter(
            HelpMessage = "The table fill color."
        )]
        [string]
        $Fillcolor = "white",

        [Parameter(
            HelpMessage = "The table header cell color."
        )]
        [string]
        $HeaderColor = "black",

        [Parameter(
            HelpMessage = "The table header font color."
        )]
        [string]
        $HeaderFontColor = "white",

        [Parameter(
            HelpMessage = "The table border color."
        )]
        [string]
        $BorderColor = "white",

        [Parameter(
            HelpMessage = "Set to output HTML."
        )]
        [bool]
        $HTMLOutput,

        [Parameter(
            HelpMessage = "Set the table debug mode."
        )]
        [bool]
        $IconDebug
    )
    begin {
        $tableData = [System.Collections.ArrayList]::new()
        if ( [string]::IsNullOrEmpty($Label) ) {
            $Label = $Name
        }
    }
    process {
        if ( $null -ne $ScriptBlock ) {
            $Row = $ScriptBlock.Invoke()
        }

        if ( $null -ne $RowScript ) {
            $Row = foreach ( $node in $Row ) {
                @($node).ForEach($RowScript)
            }
        }

        $results = foreach ( $node in $Row ) {
            Row -Label $node
        }

        foreach ( $node in $results ) {
            [void]$tableData.Add($node)
        }
    }
    end {
        if ($IconDebug) {
            if ($HTMLOutput) {
                "<TABLE COLOR='red' CELLBORDER='1' BORDER='0' CELLSPACING='0'><TR><TD bgcolor='red' align='center'><font color='$HeaderFontColor'><B>{0}</B></FONT></TD></TR>{1}</TABLE>" -f $Label, ($tableData -join '')
            } else {
                $html = "<TABLE COLOR='red' CELLBORDER='1' BORDER='0' CELLSPACING='0'><TR><TD bgcolor='red' align='center'><font color='$HeaderFontColor'><B>{0}</B></FONT></TD></TR>{1}</TABLE>" -f $Label, ($tableData -join '')
                Node $Name @{label = $html; shape = 'none'; fontname = $Fontname; fontsize = $FontSize; style = $Style; penwidth = 1; fillcolor = $Fillcolor; color = $BorderColor }
            }

        } else {
            if ($HTMLOutput) {
                "<TABLE CELLBORDER='1' BORDER='0' CELLSPACING='0'><TR><TD bgcolor='$HeaderColor' align='center'><font color='$HeaderFontColor'><B>{0}</B></FONT></TD></TR>{1}</TABLE>" -f $Label, ($tableData -join '')
            } else {
                $html = "<TABLE CELLBORDER='1' BORDER='0' CELLSPACING='0'><TR><TD bgcolor='$HeaderColor' align='center'><font color='$HeaderFontColor'><B>{0}</B></FONT></TD></TR>{1}</TABLE>" -f $Label, ($tableData -join '')
                Node $Name @{label = $html; shape = 'none'; fontname = $Fontname; fontsize = $FontSize; style = $Style; penwidth = 1; fillcolor = $Fillcolor; color = $BorderColor }
            }
        }
    }
}