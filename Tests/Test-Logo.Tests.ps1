BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Test-Image.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Test-Logo.ps1')
}

Describe Test-Logo {
    BeforeAll {
        $IconPath = $TestDrive
        $Images = @{
            'Main_Logo' = 'Diagrammer.png'
        }
        $Logo = Join-Path -Path "$TestsFolder\Icons" -ChildPath 'Logo_Test.png'
        $ImageName = Test-Logo -LogoPath $Logo -IconPath $IconPath -ImagesObj $Images
        $LogoPath = Join-Path -Path $IconPath -ChildPath 'Logo_Test.png'
    }

    It 'Should return Logo_Test.png string from Images hashtable' {
        $Images[$ImageName] | Should -Be 'Logo_Test.png'
    }
    It 'Verified if Logo_Test.png is inside TestDrive:\ folder' {
        $LogoPath | Should -Exist
    }
}