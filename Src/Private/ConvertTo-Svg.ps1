function ConvertTo-Svg {
    <#
    .SYNOPSIS
        Function to export diagram to svg format.
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
        [string] $DestinationPath,

        [Parameter(
            Position = 2,
            Mandatory = $false,
            HelpMessage = 'Please provide the angle degree to rotate svg image'
        )]
        [string] $Angle
    )
    process {

        try {
            Write-Verbose "Trying to convert Graphviz object to SVG format. Destination Path: $DestinationPath."
            $Document = Export-PSGraph -Source $GraphObj -DestinationPath $DestinationPath -OutputFormat 'svg' -GraphVizPath $GraphvizPath
        } catch {
            Write-Verbose "Unable to convert Graphviz object to SVG format"
            Write-Verbose $($_.Exception.Message)
        }

        if ($Document) {
            #Fix icon path issue with svg output
            $images = Select-String -Path $($Document.fullname) -Pattern '<image xlink:href=".*png".*>' -AllMatches
            foreach ($match in $images) {
                $matchFound = $match -Match '"(.*png)"'
                if ($matchFound -eq $false) {
                    continue
                }
                $iconName = $Matches.Item(1)
                $iconNamePath = "$IconPath\$($Matches.Item(1))"
                if ($Angle -ne 0) {
                    $iconNamePath = (ConvertTo-RotateImage -ImageInput $iconNamePath -Angle 270).FullName
                }
                $iconContents = Get-Content $iconNamePath -Encoding byte
                $iconEncoded = [convert]::ToBase64String($iconContents)
                ((Get-Content -Path $($Document.fullname) -Raw) -Replace $iconName, "data:image/png;base64,$($iconEncoded)") | Set-Content -Path $($Document.fullname)
            }
            if ($DeleteImage) {
                if ($Document) {
                    Remove-Item -Path $Document
                }
            } else {
                if ($Document) {
                    Write-Verbose "Successfully converted Graphviz object to SVG format. Saved Path: $DestinationPath."
                    Get-ChildItem -Path $Document
                }
            }
        }
    }
    end {}
}