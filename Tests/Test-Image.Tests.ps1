BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Test-Image.ps1
}
Describe Test-Image {
    It "Should return true if extension is in @( .jpeg, .jpg, .png )" {
        Test-Image -Path 'Diagrammer.png' | Should -Be $true
    }
    It "Should return false if extension is not in @( .jpeg, .jpg, .png )" {
        Test-Image -Path 'Diagrammer.pdf' | Should -Be $false
    }
}