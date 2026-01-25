# Get assemblies files and import them
$assemblyName = switch ($PSVersionTable.PSEdition) {
    'Core' {
        @(Get-ChildItem -Path ("$PSScriptRoot{0}Src{0}Bin{0}Assemblies{0}net90{0}*.dll" -f [System.IO.Path]::DirectorySeparatorChar) -ErrorAction SilentlyContinue)
    }
    'Desktop' {
        @(Get-ChildItem -Path ("$PSScriptRoot{0}Src{0}Bin{0}Assemblies{0}net48{0}*.dll" -f [System.IO.Path]::DirectorySeparatorChar) -ErrorAction SilentlyContinue)
    }
    default {
        @()
    }
}

$loadedassemblies = [System.AppDomain]::CurrentDomain.GetAssemblies().ManifestModule.Name

foreach ($Assembly in $assemblyName) {
    if ($Assembly.Name -notin $loadedassemblies) {
        try {
            Write-Verbose -Message "Loading assembly '$($Assembly.Name)'."
            Add-Type -Path $Assembly.FullName -Verbose
        } catch {
            Write-Error -Message "Failed to add assembly $($Assembly.FullName): $_"
        }
    }
}

# Get public and private function definition files and dot source them
$Public = @(Get-ChildItem -Path ("$PSScriptRoot{0}Src{0}Public{0}*.ps1" -f [System.IO.Path]::DirectorySeparatorChar) -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path ("$PSScriptRoot{0}Src{0}Private{0}*.ps1" -f [System.IO.Path]::DirectorySeparatorChar) -ErrorAction SilentlyContinue)

foreach ($Module in @($Public + $Private)) {
    try {
        . $Module.FullName
    } catch {
        Write-Error -Message "Failed to import function $($Module.FullName): $_"
    }
}

Export-ModuleMember -Function $Public.BaseName
Export-ModuleMember -Function $Private.BaseName