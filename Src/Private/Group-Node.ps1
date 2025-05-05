function Group-Node {
    <#
    .SYNOPSIS
        Function to split node array
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
    [OutputType([System.Management.Automation.ScriptBlock])]
    Param
    (
        [Parameter(
            Position = 0,
            Mandatory = $true,
            HelpMessage = 'Please provide the objects to process'
        )]
        [Array] $InputObject,
        [Parameter(
            Position = 1,
            Mandatory = $true,
            HelpMessage = 'Delete temporary image file'
        )]
        [int] $SplitinGroups,
        [Parameter(
            Position = 2,
            Mandatory = $true,
            HelpMessage = 'Delete temporary image file'
        )]
        [string] $Style,
        [Parameter(
            Position = 3,
            Mandatory = $true,
            HelpMessage = 'Delete temporary image file'
        )]
        [string] $Color,
        [Parameter(
            Position = 4,
            Mandatory = $false,
            HelpMessage = 'Delete temporary image file'
        )]
        [string] $Minlen = 1
    )
    process {
        Write-Verbose -Message "Trying to convert Graphviz object to Base64 format."
        # Code used to output image to base64 format
        $Output = &{
            $Group = Split-array -inArray $InputObject -size $SplitinGroups
            $Start = 0
            $LocalPGNum = 1
            while ($LocalPGNum -ne $Group.Length) {
                Edge -From $Group[$Start] -To $Group[$LocalPGNum] @{minlen = $Minlen; style = $Style; color = $Color }
                $Start++
                $LocalPGNum++
            }
        }
        return $Output
    }
    end {}
}