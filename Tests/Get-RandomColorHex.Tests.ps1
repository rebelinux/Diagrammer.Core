BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Get-RandomColorHex.ps1
}

Describe Get-RandomColorHex {
    It "Should return string type" {
        Get-RandomColorHex | Should -BeOfType String
    }
    It "Should return a rgb color hex" {
        Get-RandomColorHex | Should -Match '^#[0-9A-F]{6}$'
    }
}
