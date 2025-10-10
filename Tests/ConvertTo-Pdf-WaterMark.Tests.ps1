BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Pdf-WaterMark.ps1')
}

Describe ConvertTo-Pdf-WaterMark -Skip {
    BeforeAll {
        # Set the path to the ImageMagick executable (magick.exe)
        $ImageMagickPath = Join-Path $ProjectRoot '\ImageMagick'
        # Force the redirection of TMP to the TestDrive folder
        # $env:TMP = $TestDrive

        $IconsPath = Join-Path -Path $TestsFolder -ChildPath 'Icons'

        $PassParamsValidParameters = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            DestinationPath = Join-Path -Path $TestDrive -ChildPath 'output.pdf'
        }
        $PassParamsInvalidImagePath = @{
            ImageInput = "AsBuiltReport.png"
            DestinationPath = Join-Path -Path $TestDrive -ChildPath 'output.pdf'
        }
        $PassParamsNoDestinationPath = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
        }
    }

    It "Should return output.pdf path" {
        (ConvertTo-Pdf-WaterMark @PassParamsValidParameters).FullName | Should -Exist
    }
    It "Should throw not found exception when ImageInput does not exist" {
        $scriptBlock = { ConvertTo-Pdf-WaterMark @PassParamsInvalidImagePath -ErrorAction Stop }
        $scriptBlock | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'ImageInput'. File AsBuiltReport.png not found!"
    }
    It "Should throw missing mandatory parameters" {
        $scriptBlock = { ConvertTo-Pdf-WaterMark @PassParamsNoDestinationPath -ErrorAction Stop }
        $scriptBlock | Should -Throw -ExpectedMessage "Cannot process command because of one or more missing mandatory parameters: DestinationPath."
    }
}