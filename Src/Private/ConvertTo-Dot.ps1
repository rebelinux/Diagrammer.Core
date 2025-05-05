function ConvertTo-Dot {
    <#
    .SYNOPSIS
        Function to export diagram to dot format.
    .DESCRIPTION
        Export a diagram in PDF/PNG/SVG formats using PSgraph.
    .NOTES
        Version:        0.2.12
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
            Write-Verbose -Message "WaterMark option is not supported with the dot format."
        }

        try {
            Write-Verbose -Message "Trying to convert Graphviz object to DOT format. Destination Path: $DestinationPath."
            $Document = Export-PSGraph -Source $GraphObj -DestinationPath $DestinationPath -OutputFormat 'dot' -GraphVizPath $GraphvizPath
        } catch {
            Write-Verbose -Message "Unable to convert Graphviz object to DOT format."
            Write-Debug -Message $($_.Exception.Message)
        }
        if ($Document) {
            if ($Document) {
                Write-Verbose -Message "Successfully converted Graphviz object to DOT format. Saved Path: $DestinationPath."
                Get-ChildItem -Path $Document
            }
        }
    }
    end {}
}