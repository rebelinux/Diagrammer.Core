function ConvertTo-Pdf {
    <#
    .SYNOPSIS
        Function to export diagram to pdf format.
    .DESCRIPTION
        Export a diagram in PDF/PNG/SVG formats using PSgraph.
    .NOTES
        Version:        0.2.12
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux
    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>
    [CmdletBinding()]
    [OutputType([String])]
    param
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
        try {
            Write-Verbose -Message "Trying to convert Graphviz object to PDF format. Destination Path: $DestinationPath."
            $Document = Export-PSGraph -Source $GraphObj -DestinationPath $DestinationPath -OutputFormat 'pdf' -GraphVizPath $GraphvizPath
        } catch {
            Write-Verbose -Message 'Unable to convert Graphviz object to PNG format.'
            Write-Debug -Message $($_.Exception.Message)
        }
        if ($Document) {
            Write-Verbose -Message "Successfully converted Graphviz object to PDF format. Saved Path: $DestinationPath."
            Get-ChildItem -Path $Document
        }
    }
    end {}
}