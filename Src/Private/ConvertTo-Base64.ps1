function ConvertTo-Base64 {
    <#
    .SYNOPSIS
        Function to export diagram to base64 format.
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
    [OutputType([string])]
    Param
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
        Write-Verbose "Trying to convert Graphviz object to Base64 format."
        # Code used to output image to base64 format
        try {
            $Base64 = [convert]::ToBase64String((Get-Content $ImageInput -Encoding byte))
        } catch {
            Write-Verbose "Unable to convert Graphviz object to Base64 format."
            Write-Verbose $($_.Exception.Message)
        }
        if ($Base64) {
            if ($Delete) {
                Write-Verbose -Message "Deleting Temporary PNG file: $($ImageInput)"
                Remove-Item -Path $ImageInput
            }
            Write-Verbose "Successfully converted Graphviz object to Base64 format."
            return $Base64
        } else {
            Write-Verbose -Message "Deleting Temporary PNG file: $($ImageInput)"
            Remove-Item -Path $ImageInput
        }
    }
    end {}
}