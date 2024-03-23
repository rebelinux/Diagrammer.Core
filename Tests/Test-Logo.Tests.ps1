BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Test-Image.ps1
    . $ProjectRoot\SRC\private\Test-Logo.ps1
}

Describe Test-Logo {
    BeforeAll {
        $IconPath = 'TestDrive:\'
        $Images = @{
            "Main_Logo" = "Diagrammer.png"
        }
        $Logo = Join-Path $TestsFolder "Logo.png"
        $ImageName = Test-Logo -LogoPath $Logo -IconPath $IconPath -ImagesObj $Images
        $LogoPath = Join-Path $IconPath 'Logo.png'
    }

    It "Should return Logo.png string from Images hashtable" {
        $Images[$ImageName] | Should -Be 'Logo.png'
    }
    It "Vefified if Logo.png is inside TestDrive:\ folder" {
        $LogoPath | Should -Exist
    }
}