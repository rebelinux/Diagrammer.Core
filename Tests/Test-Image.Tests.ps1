. $PSScriptRoot\_InitializeTests.ps1

Describe "Test-Image" {
    It "Should returns true if extension is in @( .jpeg, .jpg, .png )" {
        Test-Image -Path 'Diagrammer.png' | Should -Be $true
    }
    It "Should returns false if extension is not in @( .jpeg, .jpg, .png )" {
        Test-Image -Path 'Diagrammer.pdf' | Should -Be $false
    }
}