. $PSScriptRoot\_InitializeTests.ps1

Describe Remove-SpecialChar {
    It "Should returns string without SpecialChar" {
        Remove-SpecialChar -String "Problem&with()char" -SpecialChars "()[]{}&." | Should -Be 'Problemwithchar'
    }
}