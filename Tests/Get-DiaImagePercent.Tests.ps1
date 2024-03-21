BeforeAll {
    $Logo = Join-Path $TestsFolder "Logo.png"
    $ImgProperties = Get-DiaImagePercent -ImageInput $Logo
}

Describe "Get-DiaImagePercent" {
    It "Returns image Height" {
        $ImgProperties.Height | Should -Be 225
    }
    It "Returns image Width" {
        $ImgProperties.Width | Should -Be 225
    }
}