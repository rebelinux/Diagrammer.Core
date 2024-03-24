function Test-Logo {
    <#
    .SYNOPSIS
        Used by Diagrammer to validate logo path.
    .DESCRIPTION
    .NOTES
        Version:        0.1.1
        Author:         Joanthan Colon
    .EXAMPLE
        Test-Logo -LogoPath (Get-ChildItem -Path $Logo).FullName -IconPath $IconPath -ImagesObj $Images
    .LINK
    #>

    [CmdletBinding()]
    [OutputType([String])]
    param(

        [parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [System.IO.FileInfo]$LogoPath,
        [System.IO.FileInfo]$IconPath,
        [hashtable] $ImagesObj
    )

    PROCESS {
        if (((Test-Path -Path $LogoPath) -and (Test-Path -Path $IconPath)) -and (Test-Image -Path $LogoPath)) {
            # Add logo path to the Image variable
            Copy-Item -Path $LogoPath -Destination $IconPath
            $outputLogoFile = Split-Path $LogoPath -Leaf
            if ($outputLogoFile) {
                $ImageName = "Custom-$(Get-Random)"
                $ImagesObj.Add($ImageName, $outputLogoFile)
                return $ImageName
            }
        } else {
            throw "Logo isn't a supported image file. Please use the following format [.jpeg, .jpg, .png]"
        }
    }
}