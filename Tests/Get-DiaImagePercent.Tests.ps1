BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Get-DiaImagePercent.ps1
}

Describe Get-DiaImagePercent {
    BeforeAll {
        $Logo = Join-Path "$($TestsFolder)\Icons" "Logo.png"
        $ImageFile = [System.IO.File]::ReadAllBytes($Logo)
        $Base64 = [convert]::ToBase64String($ImageFile)
        $FromBase64 = Get-DiaImagePercent -GraphObj $Base64
        $FromImg = Get-DiaImagePercent -ImageInput $Logo
        $ImageSizeByPercent = Get-DiaImagePercent -ImageInput $Logo -Percent 75
        $ImageSizeByPercent100 = Get-DiaImagePercent -ImageInput $Logo -Percent 100
    }

    It "Should return Height from image file" {
        $FromImg.Height | Should -Be 225
    }
    It "Should return Width from image file" {
        $FromImg.Width | Should -Be 225
    }

    It "Should return Height from base64 file" {
        $FromBase64.Height | Should -Be 225
    }
    It "Should return Width from base64 file" {
        $FromBase64.Width | Should -Be 225
    }
    It "Should return calculated Width and Height from image file by percent" {
        $ImageSizeByPercent.Width | Should -Be 168.75
        $ImageSizeByPercent.Height | Should -Be 168.75
    }
    It "Should return default Width and Height from image file by percent of 100" {
        $ImageSizeByPercent100.Width | Should -Be 225
        $ImageSizeByPercent100.Height | Should -Be 225
    }
    It "Should return error if percent is less than 1" {
        { Get-DiaImagePercent -ImageInput $Logo -Percent 0 } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'Percent'. The 0 argument is less than the minimum allowed range of 10. Supply an argument that is greater than or equal to 10 and then try the command again."
    }
    It "Should return error if percent is more than 100" {
        { Get-DiaImagePercent -ImageInput $Logo -Percent 1000 } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'Percent'. The 1000 argument is greater than the maximum allowed range of 100. Supply an argument that is less than or equal to 100 and then try the command again."
    }
    It "Should return throw" {
        { Get-DiaImagePercent } | Should -Throw -ExpectedMessage 'Error: Please provide a image path or a graphviz string to process.'
    }
}