function Join-Hashtable {
    <#
    .SYNOPSIS
        Merges two hashtables into a single hashtable.

    .DESCRIPTION
        The Join-Hashtable function combines two hashtables, $PrimaryHash and $SecondaryHash, into a new hashtable.
        By default, values from $PrimaryHash take precedence when keys overlap.
        If the -PreferSecondary switch is specified, values from $SecondaryHash will overwrite those in $PrimaryHash for overlapping keys.

    .PARAMETER PrimaryHash
        The primary hashtable whose keys and values are merged first.

    .PARAMETER SecondaryHash
        The secondary hashtable whose keys and values are merged into the primary hashtable.

    .PARAMETER PreferSecondary
        If specified, values from the secondary hashtable will overwrite those from the primary hashtable for duplicate keys.
        If either hashtable is null or not provided, an empty hashtable is used in its place.

    .EXAMPLE
        $primary = @{ Name = "Alice"; Age = 30 }
        $secondary = @{ Age = 25; City = "Seattle" }
        $result = Join-Hashtable -PrimaryHash $primary -SecondaryHash $secondary -PreferSecondary

        # Result: @{ Name = "Alice"; Age = 25; City = "Seattle" }

    .EXAMPLE
        $primary = @{ Name = "Alice"; Age = 30 }
        $secondary = @{ Age = 25; City = "Seattle" }
        $result = Join-Hashtable -PrimaryHash $primary -SecondaryHash $secondary

        # Result: @{ Name = "Alice"; Age = 30; City = "Seattle" }

    .NOTES
        Author: Jonathan Colon
        Version: 0.2.30
        Twitter: @jcolonfzenpr
        Github: rebelinux
    #>
    param (
        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The primary hashtable to merge.'
        )]
        [hashtable] $PrimaryHash = @{},

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'The secondary hashtable to merge.'
        )]
        [hashtable] $SecondaryHash = @{},

        [Parameter(
            Mandatory = $false,
            HelpMessage = 'If specified, values from the secondary hashtable will overwrite those from the primary hashtable for duplicate keys.'
        )]
        [switch] $PreferSecondary
    )

    $merged = @{}

    # Copy primary hash
    foreach ($key in $PrimaryHash.Keys) {
        $merged[$key] = $PrimaryHash[$key]
    }

    # Merge secondary hash
    foreach ($key in $SecondaryHash.Keys) {
        if ($merged.ContainsKey($key)) {
            if ($PreferSecondary.IsPresent) {
                $merged[$key] = $SecondaryHash[$key]
            }
        } else {
            $merged[$key] = $SecondaryHash[$key]
        }
    }

    return $merged
}