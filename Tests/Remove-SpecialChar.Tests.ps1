BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Remove-SpecialChar.ps1')
}

Describe Remove-SpecialChar {
    It "Should return string without SpecialChar" {
        Remove-SpecialChar -String "Problem&with()char" -SpecialChars "()[]{}&." | Should -Be 'Problemwithchar'
    }
}