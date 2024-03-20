. $PSScriptRoot\_InitializeTests.ps1

BeforeAll {
    $IconPath = 'TestDrive:\'
    $Images = @{
        "Main_Logo" = "Diagrammer.png"
    }
    $Logo = Join-Path $TestsFolder "Logo.png"
    $ImageName = Test-Logo -LogoPath $Logo -IconPath $IconPath -ImagesObj $Images
    $LogoPath = Join-Path $IconPath 'Logo.png'
}

Describe "Test-Logo" {
    It "Returns Logo.png string from Images hashtable" {
        $Images[$ImageName] | Should -Be 'Logo.png'
    }
    It "Vefified if Logo.png is inside icons folder" {
        $LogoPath | Should -Exist
    }
}