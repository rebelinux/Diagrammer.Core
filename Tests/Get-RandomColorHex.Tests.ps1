BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Get-RandomColorHex.ps1')
}

Describe Get-RandomColorHex {
    It 'Should return string type' {
        Get-RandomColorHex | Should -BeOfType String
    }
    It 'Should return a rgb color hex' {
        Get-RandomColorHex | Should -Match '^#[0-9A-F]{6}$'
    }
}
