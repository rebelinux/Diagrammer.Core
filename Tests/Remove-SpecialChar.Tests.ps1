Describe "Remove-SpecialChar" {
    It "Returns string without SpecialChar" {
        Remove-SpecialChar -String "Problem&with()char" -SpecialChars "()[]{}&."| Should -Be 'Problemwithchar'
    }
}