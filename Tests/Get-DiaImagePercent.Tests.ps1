. $PSScriptRoot\_InitializeTests.ps1

Describe "Get-DiaImagePercent" {
    BeforeAll {
        $Logo = Join-Path $TestsFolder "Logo.png"
        $ImageFile = [System.IO.File]::ReadAllBytes($Logo)
        $Base64 = [convert]::ToBase64String($ImageFile)
        $FromBase64 = Get-DiaImagePercent -GraphObj $Base64
        $FromImg = Get-DiaImagePercent -ImageInput $Logo
    }

    It "Should returns Height from image file" {
        $FromImg.Height | Should -Be 225
    }
    It "Should returns Width from image file" {
        $FromImg.Width | Should -Be 225
    }

    It "Should returns Height from base64 file" {
        $FromBase64.Height | Should -Be 225
    }
    It "Should returns Width from base64 file" {
        $FromBase64.Width | Should -Be 225
    }
    It "Should returns throw" {
        { Get-DiaImagePercent } | Should -Throw -ExpectedMessage 'Error: Please provide a image path or a graphviz string to process.'
    }
}