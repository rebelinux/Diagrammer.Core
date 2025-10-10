BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Get-RandomPastelColorHex.ps1')
}

Describe Get-RandomPastelColorHex {
    It "Should return string type" {
        Get-RandomPastelColorHex | Should -BeOfType String
    }
    It "Should return a rgb color hex" {
        Get-RandomPastelColorHex | Should -Match '^#[0-9A-F]{6}$'
    }
}
