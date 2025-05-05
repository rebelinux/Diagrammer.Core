function ConvertTo-Jpg {
    <#
    .SYNOPSIS
        Function to export diagram to jpg format.
    .DESCRIPTION
        Export a diagram in JPG/PDF/PNG/SVG formats using PSgraph.
    .NOTES
        Version:        0.2.20
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
        try {
            Write-Verbose -Message "Trying to convert Graphviz object to JPG format. Destination Path: $DestinationPath."
            $Document = Export-PSGraph -Source $GraphObj -DestinationPath $DestinationPath -OutputFormat 'jpg' -GraphVizPath $GraphvizPath
        } catch {
            Write-Verbose -Message "Unable to convert Graphviz object to JPG format."
            Write-Debug -Message $($_.Exception.Message)
        }
        if ($Document) {
            if ($Document) {
                Write-Verbose -Message "Successfully converted Graphviz object to JPG format. Saved Path: $DestinationPath."
                Get-ChildItem -Path $Document
            }
        }
    }
    end {}
}