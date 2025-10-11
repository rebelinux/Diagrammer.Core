BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Pdf-WaterMark.ps1')
}

Describe ConvertTo-Pdf-WaterMark {
    BeforeAll {
        # Set the path to the ImageMagick executable
        $ImageMagickPath = switch ($PSVersionTable.Platform) {
            'Unix' {
                & {
                    if (Test-Path -Path '/usr/bin/magick') {
                        '/usr/bin/magick'
                    } elseif (Test-Path -Path '/bin/magick') {
                        '/bin/magick'
                    } elseif (Test-Path -Path '/usr/local/bin/magick') {
                        '/usr/local/bin/magick'
                    } elseif (Test-Path -Path '/opt/homebrew/bin/magick') {
                        '/opt/homebrew/bin/magick'
                    } else {
                        throw "ImageMagick 'magick' executable not found in standard Unix paths. Please install ImageMagick."
                    }
                }
            }
            default { Join-Path $RootPath 'ImageMagick\magick.exe' }
        }
        # Force the redirection of TMP to the TestDrive folder
        $env:TMP = $TestDrive

        $IconsPath = Join-Path -Path $TestsFolder -ChildPath 'Icons'

        $PassParamsValidParameters = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            DestinationPath = "$TestDrive\output.pdf"
        }
        $PassParamsInvalidImagePath = @{
            ImageInput = "AsBuiltReport.png"
            DestinationPath = "$TestDrive\output.pdf"
        }
        $PassParamsNoDestinationPath = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            DestinationPath = "WrongPath"
        }
    }

    It "Should return output.pdf path" {
        (ConvertTo-Pdf-WaterMark @PassParamsValidParameters).FullName | Should -Exist
    }
    It "Should throw not found exception when ImageInput does not exist" {
        $scriptBlock = { ConvertTo-Pdf-WaterMark @PassParamsInvalidImagePath -ErrorAction Stop }
        $scriptBlock | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'ImageInput'. File AsBuiltReport.png not found!"
    }
    It "Should throw Folder does not exist" {
        $scriptBlock = { ConvertTo-Pdf-WaterMark @PassParamsNoDestinationPath -ErrorAction Stop }
        $scriptBlock | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'DestinationPath'. Folder does not exist"
    }
}