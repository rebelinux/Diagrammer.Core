BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-RotateImage.ps1')
    if ($PSVersionTable.Platform -ne 'Unix') {
        Add-Type -Path "$ProjectRoot\Src\Bin\Assemblies\Diagrammer.dll"
        Add-Type -Path "$ProjectRoot\Src\Bin\Assemblies\SixLabors.ImageSharp.dll"
    }
}

Describe ConvertTo-RotateImage {
    BeforeAll {
        # Force the redirect of TMP to the TestDrive folder
        # $env:TMP = $TestDrive

        $IconsPath = Join-Path -Path $TestsFolder -ChildPath 'Icons'

        # Create Rotated folder in TestDrive
        New-Item -Path (Join-Path -Path $TestDrive -ChildPath "Rotated") -ItemType Directory

        $PassParamsValidParameters = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            DestinationPath = Join-Path -Path $TestDrive -ChildPath "Rotated"
            Angle = 90
        }
        $PassParamsInvalidImagePath = @{
            ImageInput = "AsBuiltReport.png"
            DestinationPath = Join-Path -Path $TestDrive -ChildPath "Rotated"
            Angle = 90
        }
        $PassParamsNoDestinationPath = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            Angle = 90
        }
        $PassParamsDeleteImage = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            DestinationPath = Join-Path -Path $TestDrive -ChildPath "Rotated"
            Angle = 90
            DeleteImage = $true
        }
        $PassParamsAngleParameters = @{
            ImageInput = Join-Path -Path $IconsPath -ChildPath "AsBuiltReport.png"
            DestinationPath = Join-Path -Path $TestDrive -ChildPath "Rotated"
        }
    }

    AfterAll {
        # Delete files or perform other cleanup tasks
        if (Test-Path -Path (Join-Path -Path $TestsFolder -ChildPath "AsBuiltReport_Rotated.png")) {
            Remove-Item (Join-Path -Path $TestsFolder -ChildPath "AsBuiltReport_Rotated.png")
        }
    }

    It "Should create AsBuiltReport_Rotated.png rotated file image" {
        ConvertTo-RotateImage @PassParamsValidParameters
        $RotatedImagePath = Join-Path -Path $PassParamsValidParameters.DestinationPath -ChildPath "AsBuiltReport_Rotated.png"
        $RotatedImagePath | Should -Exist
    }
    It "Should return rotated image FullName Path" {
        (ConvertTo-RotateImage @PassParamsNoDestinationPath).FullName | Should -Exist
    }
    It "Should throw 'ParameterBindingException' not found exception when ImagePath does not exist" {
        $scriptBlock = { ConvertTo-RotateImage @PassParamsInvalidImagePath -ErrorAction Stop }
        $scriptBlock | Should -Throw -ExceptionType ([System.Management.Automation.ParameterBindingException])
    }
    It "Should delete the TempImageOutput temporary file when DeleteImage switch is used" {
        ConvertTo-RotateImage @PassParamsDeleteImage
        $RotatedImagePath = Join-Path -Path $PassParamsDeleteImage.DestinationPath -ChildPath "AsBuiltReport_Rotated.png"
        "$env:TMP\AsBuiltReport_Rotated.png" | Should -Not -Exist
    }
    It "Should not delete the TempImageOutput temporary file when DeleteImage switch isn't used" {
        ConvertTo-RotateImage @PassParamsValidParameters
        $RotatedImagePath = Join-Path -Path $PassParamsValidParameters.DestinationPath -ChildPath "AsBuiltReport_Rotated.png"
        "$env:TMP\AsBuiltReport_Rotated.png" | Should -Not -Exist
    }
    It "Should rotated image to a 90 degree angle" {
        ConvertTo-RotateImage @PassParamsAngleParameters -Angle 90
        $expectedHash = "FCD60222B8AF7F5E206B2DEF91C9257D15B04CFF151D8BD226413ECC3B295EB8"
        $RotatedImagePath = Join-Path -Path $PassParamsAngleParameters.DestinationPath -ChildPath "AsBuiltReport_Rotated.png"
        $calculatedHash = (Get-FileHash -Path $RotatedImagePath -Algorithm SHA256).Hash
        $calculatedHash | Should -Be $expectedHash
    }
    It "Should rotated image to a 180 degree angle" {
        ConvertTo-RotateImage @PassParamsAngleParameters -Angle 180
        $expectedHash = "B3067CA010C1AF7EF2B2B7825A20298F0F64C2598CAE7DC51AB615C91BCBE4D1"
        $RotatedImagePath = Join-Path -Path $PassParamsAngleParameters.DestinationPath -ChildPath "AsBuiltReport_Rotated.png"
        $calculatedHash = (Get-FileHash -Path $RotatedImagePath -Algorithm SHA256).Hash
        $calculatedHash | Should -Be $expectedHash
    }
    It "Should rotated image to a 270 degree angle" {
        ConvertTo-RotateImage @PassParamsAngleParameters -Angle 270
        $expectedHash = "61B54E22853B8F866D2FAD1A21D7B328662DBEDFE9D6C8776C73D04727BF494D"
        $RotatedImagePath = Join-Path -Path $PassParamsAngleParameters.DestinationPath -ChildPath "AsBuiltReport_Rotated.png"
        $calculatedHash = (Get-FileHash -Path $RotatedImagePath -Algorithm SHA256).Hash
        $calculatedHash | Should -Be $expectedHash
    }
}