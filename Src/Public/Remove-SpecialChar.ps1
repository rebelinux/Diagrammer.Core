function Remove-SpecialChar {
    <#
    .SYNOPSIS
        Used by Diagrammer to remove unsupported graphviz dot characters.
    .DESCRIPTION
    .NOTES
        Version:        0.1.1
        Author:         Prateek Singh
    .EXAMPLE
        Remove-SpecialChar -String "Non Supported chars ()[]{}&."
    .LINK
    #>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param(
        [string]$String,
        [string]$SpecialChars = "()[]{}&."
    )
    process {
        if ($PSCmdlet.ShouldProcess($String, ("Remove {0} chars" -f $SpecialChars, $String))) {
            $String -replace $($SpecialChars.ToCharArray().ForEach( { [regex]::Escape($_) }) -join "|"), ""
        }
    }
}