function ConvertTo-Dot {
    <#
    .SYNOPSIS
        Function to export diagram to dot format.
    .DESCRIPTION
        Export a diagram in PDF/PNG/SVG formats using PSgraph.
    .NOTES
        Version:        0.1.8
        Author:         Jonathan Colon
        Twitter:        @jcolonfzenpr
        Github:         rebelinux
    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>
    [CmdletBinding()]
    [OutputType([String])]
    Param
    (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            HelpMessage = 'Please provide the graphviz dot object'
        )]
        $GraphObj,
        [Parameter(
            Position = 1,
            Mandatory = $true,
            HelpMessage = 'Please provide the file path to export the diagram'
        )]
        [string] $DestinationPath
    )
    process {
        if ($WaterMarkText) {
            Write-ColorOutput -Color 'Red' -String "WaterMark option is not supported with the dot format."
        }

        try {
            Write-Verbose "Trying to convert Graphviz object to DOT format. Destination Path: $DestinationPath."
            $Document = Export-PSGraph -Source $GraphObj -DestinationPath $DestinationPath -OutputFormat 'dot' -GraphVizPath $GraphvizPath
        } catch {
            Write-Verbose "Unable to convert Graphviz object to DOT format."
            Write-Verbose $($_.Exception.Message)
        }
        if ($Document) {
            if ($Document) {
                Write-Verbose "Successfully converted Graphviz object to DOT format. Saved Path: $DestinationPath."
                Get-ChildItem -Path $Document
            }
        }
    }
    end {}
}