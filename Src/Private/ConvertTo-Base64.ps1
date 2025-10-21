function ConvertTo-Base64 {
    <#
    .SYNOPSIS
        Function to export diagram to base64 format.
    .DESCRIPTION
        Export a diagram in PDF/PNG/SVG formats using PSgraph.
    .NOTES
        Version:        0.2.31
        Author:         Jonathan Colon
        Bluesky:        @jcolonfpr.bsky.social
        Github:         rebelinux
    .LINK
        https://github.com/rebelinux/Diagrammer.Core
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            HelpMessage = 'Please provide image file path'
        )]
        [ValidateScript( {
                if (Test-Path -Path $_) {
                    $true
                } else {
                    throw "File $_ not found!"
                }
            })]
        [System.IO.FileInfo] $ImageInput,
        [Parameter(
            Position = 1,
            Mandatory = $false,
            HelpMessage = 'Delete temporary image file'
        )]
        [Bool] $Delete = $true
    )
    process {
        Write-Verbose -Message "Trying to convert Graphviz object to Base64 format."
        # Code used to output image to base64 format
        try {
            $Base64 = [convert]::ToBase64String(([System.IO.File]::ReadAllBytes($ImageInput)))
        } catch {
            Write-Verbose -Message "Unable to convert Graphviz object to Base64 format."
            Write-Debug -Message $($_.Exception.Message)
        }
        if ($Base64) {
            if ($Delete) {
                Write-Verbose -Message "Deleting Temporary PNG file: $($ImageInput)"
                Remove-Item -Path $ImageInput
            }
            Write-Verbose -Message "Successfully converted Graphviz object to Base64 format."
            return $Base64
        } else {
            Write-Verbose -Message "Deleting Temporary PNG file: $($ImageInput)"
            Remove-Item -Path $ImageInput
        }
    }
    end {}
}