BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Export-Diagrammer.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Png.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Jpg.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Pdf.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Svg.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Dot.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Base64.ps1')
}

Describe Export-Diagrammer {
    BeforeAll {
        $dotSource = Get-Content -Path (Join-Path $TestsFolder GraphvizSource.dot)
        $base64Source = switch ($PSVersionTable.Platform) {
            'Unix' { Get-Content -Path (Join-Path $TestsFolder GraphvizBase64SourceLinux.txt) }
            default { Get-Content -Path (Join-Path $TestsFolder GraphvizBase64SourceWindows.txt) }
        }

        $GraphvizOutputPNG = @{
            FileName = 'Diagrammer.png'
            Format = 'png'
            GraphObj = $dotSource
            OutputFolderPath = $TestDrive
        }
        $GraphvizOutputJPG = @{
            FileName = 'Diagrammer.jpg'
            Format = 'jpg'
            GraphObj = $dotSource
            OutputFolderPath = $TestDrive
        }
        $GraphvizOutputPDF = @{
            FileName = 'Diagrammer.pdf'
            Format = 'pdf'
            GraphObj = $dotSource
            OutputFolderPath = $TestDrive
        }
        $GraphvizOutputSVG = @{
            FileName = 'Diagrammer.svg'
            Format = 'svg'
            GraphObj = $dotSource
            OutputFolderPath = $TestDrive
        }
        $GraphvizOutputDot = @{
            FileName = 'Diagrammer.dot'
            Format = 'dot'
            GraphObj = $dotSource
            OutputFolderPath = $TestDrive
        }
        $GraphvizOutputBase64 = @{
            Format = 'base64'
            GraphObj = $dotSource
            OutputFolderPath = $TestDrive
        }
        $GraphvizOutputNoFileName = @{
            GraphObj = $dotSource
            OutputFolderPath = $TestDrive
        }
        $GraphvizInvalidOutputFolderPath = @{
            FileName = 'Diagrammer.png'
            GraphObj = $dotSource
            Format = 'png'
            OutputFolderPath = 'D:\InvalidPath'
        }
        $GraphvizInvalidIconsPath = @{
            FileName = 'Diagrammer.png'
            GraphObj = $dotSource
            Format = 'png'
            OutputFolderPath = $TestDrive
            IconPath = 'D:\InvalidIconsPath'
        }
        $GraphvizInvalidRotate = @{
            FileName = 'Diagrammer.png'
            GraphObj = $dotSource
            Format = 'png'
            OutputFolderPath = $TestDrive
            Rotate = 80
        }
    }

    It 'Should return Diagrammer.png full path' {
        $GraphvizOutput = Export-Diagrammer @GraphvizOutputPNG
        ($GraphvizOutput).FullName | Should -Exist
    }
    It 'Should return Diagrammer.jpg full path' {
        $GraphvizOutput = Export-Diagrammer @GraphvizOutputJPG
        ($GraphvizOutput).FullName | Should -Exist
    }
    It 'Should return Diagrammer.pdf full path' {
        $GraphvizOutput = Export-Diagrammer @GraphvizOutputPDF
        ($GraphvizOutput).FullName | Should -Exist
    }
    It 'Should return Diagrammer.dot full path' {
        $GraphvizOutput = Export-Diagrammer @GraphvizOutputPDF
        ($GraphvizOutput).FullName | Should -Exist
    }
    It 'Should return Base64 string' {
        $GraphvizOutput = Export-Diagrammer @GraphvizOutputBase64
        $GraphvizOutput | Should -Be $base64Source
    }
    It 'Should return Diagrammer.svg full path' {
        $GraphvizOutput = Export-Diagrammer @GraphvizOutputSVG
        ($GraphvizOutput).FullName | Should -Exist
    }
    It 'Should return Diagrammer.dot full path' {
        $GraphvizOutput = Export-Diagrammer @GraphvizOutputDot
        ($GraphvizOutput).FullName | Should -Exist
    }
    It 'Should create Output.png file image' {
        $OutPutPath = Export-Diagrammer @GraphvizOutputNoFileName -Format 'png'
        $OutPutPath | Should -Exist
    }
    It 'Should create Output.jpg file image' {
        $OutPutPath = Export-Diagrammer @GraphvizOutputNoFileName -Format 'jpg'
        $OutPutPath | Should -Exist
    }
    It 'Should create Output.pdf file image' {
        $OutPutPath = Export-Diagrammer @GraphvizOutputNoFileName -Format 'pdf'
        $OutPutPath | Should -Exist
    }
    It 'Should create Output.svg file image' {
        $OutPutPath = Export-Diagrammer @GraphvizOutputNoFileName -Format 'svg'
        $OutPutPath | Should -Exist
    }
    It 'Should create Output.dot file image' {
        $OutPutPath = Export-Diagrammer @GraphvizOutputNoFileName -Format 'dot'
        $OutPutPath | Should -Exist
    }
    It 'Should throw error when invalid OutputFolderPath is provided' {
        $GraphvizOutput = { Export-Diagrammer @GraphvizInvalidOutputFolderPath -ErrorAction Stop }
        $GraphvizOutput | Should -Throw -ExpectedMessage 'Cannot validate argument on parameter ''OutputFolderPath''. Folder does not exist'
    }
    It 'Should throw error when invalid IconPath is provided' {
        $GraphvizOutput = { Export-Diagrammer @GraphvizInvalidIconsPath -ErrorAction Stop }
        $GraphvizOutput | Should -Throw -ExpectedMessage 'Cannot validate argument on parameter ''IconPath''. Folder does not exist'
    }
    It 'Should throw error when invalid Rotate value is provided' {
        $GraphvizOutput = { Export-Diagrammer @GraphvizInvalidRotate -ErrorAction Stop }
        $GraphvizOutput | Should -Throw -ExpectedMessage 'Cannot validate argument on parameter ''Rotate''. The argument "80" does not belong to the set "0,90,180,270" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again.'
    }
}