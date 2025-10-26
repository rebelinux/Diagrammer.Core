

$assemblyName = "SixLabors.ImageSharp"
$loadedAssembly = [System.AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GetName().Name -eq $assemblyName }

if ($loadedAssembly) {
    Write-Verbose -Message "Assembly '$assemblyName' is already loaded."
} else {
    Write-Verbose -Message "Loading assembly '$assemblyName'."
    Add-Type -Path "$PSScriptRoot{0}Src{0}Bin{0}Assemblies{0}SixLabors.ImageSharp.dll" -f [System.IO.Path]::DirectorySeparatorChar
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