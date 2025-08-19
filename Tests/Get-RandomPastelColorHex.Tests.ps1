BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Get-RandomPastelColorHex.ps1
}

Describe Get-RandomPastelColorHex {
    It "Should return string type" {
        Get-RandomPastelColorHex | Should -BeOfType String
    }
    It "Should return a rgb color hex" {
        Get-RandomPastelColorHex | Should -Match '^#[0-9A-F]{6}$'
    }
}
