BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Test-Image.ps1')
}

Describe Test-Image {

    BeforeAll {
        $Logo = Join-Path "$TestsFolder\Icons" "Logo.png"
        New-Item -ItemType File -Name "filename.txt" -Path 'TestDrive:\'
    }

    It "Should return true if extension is in @( .jpeg, .jpg, .png )" {
        Test-Image -Path $Logo | Should -Be $true
    }
    It "Should return false if extension is not in @( .jpeg, .jpg, .png )" {
        Test-Image -Path "$TestDrive\filename.txt" | Should -Be $false
    }
}