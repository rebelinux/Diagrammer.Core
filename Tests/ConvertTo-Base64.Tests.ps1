BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Base64.ps1')
}

Describe ConvertTo-Base64 {
    BeforeAll {
        $IconsPath = Join-Path -Path $TestsFolder -ChildPath 'Icons'

        $PassParams = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath 'Logo.png'
            Delete = $false
        }
        $FailParams = @{
            ImageInput = 'C:\logo.png'
            Delete = $false
        }
    }

    It 'Should return string type' {
        ConvertTo-Base64 @PassParams | Should -BeOfType String
    }
    It 'Should return throw' {
        { ConvertTo-Base64 @FailParams } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'ImageInput'. File C:\logo.png not found!"
    }
}