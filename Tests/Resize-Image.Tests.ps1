BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Resize-Image.ps1')
}

Describe Resize-Image -Skip {
    BeforeAll {
        # Force the redirection of TMP to the TestDrive folder
        # $env:TMP = $TestDrive

        $PassParamsValidParameters = @{
            ImagePath = Join-Path "$TestsFolder\Icons" "AsBuiltReport.png"
            DestinationPath = $TestDrive
            Width = 1000
            Height = 1000
        }
        $PassParamsInvalidImagePath = @{
            ImagePath = "AsBuiltReport.png"
            DestinationPath = $TestDrive
            Width = 1000
            Height = 1000

        }
        $PassParamsNoDestinationPath = @{
            ImagePath = Join-Path "$TestsFolder\Icons" "AsBuiltReport.png"
            Width = 1000
            Height = 1000
        }
    }

    AfterAll {
        # Delete files or perform other cleanup tasks
        if (Test-Path -Path "$TestsFolder\AsBuiltReport_resized.png") {
            Remove-Item "$TestsFolder\AsBuiltReport_resized.png"
        }
    }

    It "Should return resized image" {
        (Resize-Image @PassParamsValidParameters).FullName | Should -Exist
    }
    It "Should throw 'ParameterBindingException' not found exception when ImagePath does not exist" {
        $scriptBlock = { Resize-Image @PassParamsInvalidImagePath -ErrorAction Stop }
        $scriptBlock | Should -Throw -ExceptionType ([System.Management.Automation.ParameterBindingException])
    }
    It "Should throw missing mandatory parameters" {
        $scriptBlock = { Resize-Image @PassParamsNoDestinationPath -ErrorAction Stop }
        $scriptBlock | Should -Throw -ExpectedMessage "Cannot process command because of one or more missing mandatory parameters: DestinationPath."
    }

}