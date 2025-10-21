function Format-NodeObject {
    <#
        .SYNOPSIS
            Create a Graphviz Node object.

        .DESCRIPTION
            This function creates a Graphviz Node object with a specified name, HTML label, and optional additional attributes.

        .EXAMPLE
            $Node = Format-NodeObject -Name "MyNode" -HtmlObject $HTMLContent -GraphvizAttributes @{style="filled"; color="lightgrey"}
            MyNode [label=<HTMLContent>, shape=plain, fillcolor=transparent, fontsize=14, style=filled, color=lightgrey]

        .NOTES
            Version:        0.2.32
            Author:         Jonathan Colon
            Bluesky:        @jcolonfpr.bsky.social
            Github:         rebelinux

        .PARAMETER Name
            The name of the Node.

        .PARAMETER HtmlObject
            The HTML object to be used as the node label.

        .PARAMETER GraphvizAttributes
            Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(
            Mandatory,
            HelpMessage = "The name of the Node.")]
        [string] $Name,

        [Parameter(
            Mandatory,
            HelpMessage = "The HTML object to be used as the node label.")]
        [string] $HtmlObject,

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'Additional Graphviz attributes to add to the node (e.g., style=filled,color=lightgrey)'
        )]
        [hashtable] $GraphvizAttributes = @{}
    )
    begin {
        Write-Verbose -Message "Creating Node Object: $Name"
    }
    process {
        $JoinHash = Join-Hashtable -PrimaryHash @{label = $HtmlObject; shape = 'plain'; fillcolor = 'transparent'; fontsize = 14 } -SecondaryHash $GraphvizAttributes -PreferSecondary

        Node -Name $Name -Attributes $JoinHash
    }
    end {}
}