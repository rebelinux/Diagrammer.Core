

# Get assemblies files and import them
$assemblyName = @(Get-ChildItem -Path ("$PSScriptRoot{0}Src{0}Bin{0}Assemblies{0}*.dll" -f [System.IO.Path]::DirectorySeparatorChar) -ErrorAction SilentlyContinue)

foreach ($Assembly in $assemblyName) {
    try {
        Write-Verbose -Message "Loading assembly '$($Assembly.Name)'."
        Add-Type -Path $Assembly.FullName -Verbose
    } catch {
        Write-Error -Message "Failed to add assembly $($Assembly.FullName): $_"
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