. $PSScriptRoot\_InitializeTests.ps1

Describe "Test-Image" {
    It "Returns true if extension is in @( .jpeg, .jpg, .png )" {
        Test-Image -Path 'Diagrammer.png' | Should -Be $true
    }
    It "Returns $false if extension is not in @( .jpeg, .jpg, .png )" {
        Test-Image -Path 'Diagrammer.pdf' | Should -Be $false
    }
}