. $PSScriptRoot\_InitializeTests.ps1

BeforeAll {
    $Logo = Join-Path $TestsFolder "Logo.png"
    $ImgProperties = Get-DiaImagePercent -ImageInput $Logo
}

Describe "Get-DiaImagePercent" {
    It "Should returns image Height" {
        $ImgProperties.Height | Should -Be 225
    }
    It "Should returns image Width" {
        $ImgProperties.Width | Should -Be 225
    }
}