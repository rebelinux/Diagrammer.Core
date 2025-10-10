BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-RotateImage.ps1')
}

Describe ConvertTo-RotateImage {
    BeforeAll {
        # Force the redirect-BeExactlyion of TMP to the TestDrive folder
        # $env:TMP = $TestDrive

        $IconsPath = Join-Path -Path $TestsFolder -ChildPath 'Icons'

        $PassParamsValidParameters = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            DestinationPath = $TestDrive
            Angle = 90
        }
        $PassParamsInvalidImagePath = @{
            ImageInput = "AsBuiltReport.png"
            DestinationPath = $TestDrive
            Angle = 90
        }
        $PassParamsNoDestinationPath = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            Angle = 90
        }
        $PassParamsDeleteImage = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            DestinationPath = $TestDrive
            Angle = 90
            DeleteImage = $true
        }
        $PassParamsAngleParameters = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            DestinationPath = $TestDrive
        }
    }

    AfterAll {
        # Delete files or perform other cleanup tasks
        if (Test-Path -Path "$TestsFolder\AsBuiltReport_Rotated.png") {
            Remove-Item "$TestsFolder\AsBuiltReport_Rotated.png"
        }
    }

    It "Should create AsBuiltReport_Rotated.png rotated file image" {
        ConvertTo-RotateImage @PassParamsValidParameters
        "$TestDrive\AsBuiltReport_Rotated.png" | Should -Exist
    }
    It "Should return rotated image FullName Path" {
        (ConvertTo-RotateImage @PassParamsNoDestinationPath).FullName | Should -Exist
    }
    It "Should throw 'ParameterBindingException' not found exception when ImagePath does not exist" {
        $scriptBlock = { Resize-Image @PassParamsInvalidImagePath -ErrorAction Stop }
        $scriptBlock | Should -Throw -ExceptionType ([System.Management.Automation.ParameterBindingException])
    }
    It "Should delete the TempImageOutput temporary file when DeleteImage switch is used" {
        ConvertTo-RotateImage @PassParamsDeleteImage
        "$env:TMP\AsBuiltReport_Rotated.png" | Should -Not -Exist
    }
    It "Should not delete the TempImageOutput temporary file when DeleteImage switch isn't used" {
        ConvertTo-RotateImage @PassParamsValidParameters
        "$env:TMP\AsBuiltReport_Rotated.png" | Should -Exist
    }
    It "Should rotated image to a 90 degree angle" {
        ConvertTo-RotateImage @PassParamsAngleParameters -Angle 90
        $expectedHash = "D33CF5DCDD12785F03FC2EA456A32017D577A3B5061A90A25F9226B495853A5C"
        $calculatedHash = (Get-FileHash -Path "$TestDrive\AsBuiltReport_Rotated.png" -Algorithm SHA256).Hash
        $calculatedHash | Should -Be $expectedHash
    }
    It "Should rotated image to a 180 degree angle" {
        ConvertTo-RotateImage @PassParamsAngleParameters -Angle 180
        $expectedHash = "36D9369C881A0DA2EEB8D22DADF822C6622B5FB9CC77598DC9BB36F30C12ACC8"
        $calculatedHash = (Get-FileHash -Path "$TestDrive\AsBuiltReport_Rotated.png" -Algorithm SHA256).Hash
        $calculatedHash | Should -Be $expectedHash
    }
    It "Should rotated image to a 270 degree angle" {
        ConvertTo-RotateImage @PassParamsAngleParameters -Angle 270
        $expectedHash = "BED369C153B6A7FDB32CCA12DAE90C0BADF9078647A8076A49E0FC1E57304BC6"
        $calculatedHash = (Get-FileHash -Path "$TestDrive\AsBuiltReport_Rotated.png" -Algorithm SHA256).Hash
        $calculatedHash | Should -Be $expectedHash
    }
}