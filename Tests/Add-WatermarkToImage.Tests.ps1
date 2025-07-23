BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Add-WatermarkToImage.ps1
}

Describe Add-WatermarkToImage {
    BeforeAll {
        Add-Type -AssemblyName System.Windows.Forms
        $env:TMP = $TestDrive
        $GraphvizObj = 'digraph g {
            compound="true";
            "web1"->"database1"
            "web1"->"database2"
            "web2"->"database1"
            "web2"->"database2"
        }'
        $PassParamsNoDestinationPath = @{
            ImageInput = Join-Path $TestsFolder "AsBuiltReport.png"
            WaterMarkText = "Test"
            FontColor = "White"
        }
        $PassParamsNoFontColor = @{
            ImageInput = Join-Path $TestsFolder "AsBuiltReport.png"
            WaterMarkText = "Test"
        }
        $PassParamsDestinationPath = @{
            ImageInput = Join-Path $TestsFolder "AsBuiltReport.png"
            DestinationPath = Join-Path $TestDrive 'AsBuiltReportMarked.png'
            WaterMarkText = "Test"
            FontColor = "White"
        }
        $FailParams = @{
            ImageInput = "AsBuiltReport.png"
            DestinationPath = Join-Path $TestDrive 'AsBuiltReportMarked.png'
            WaterMarkText = "Test"
            FontColor = "White"
        }
    }

    It "Should return Temporary path" {
        (Add-WatermarkToImage @PassParamsNoDestinationPath).FullName | Should -Exist
    }
    It "Should return AsBuiltReportMarked.png DestinationPath" {
        Add-WatermarkToImage @PassParamsDestinationPath
        (Get-Item -Path $PassParamsDestinationPath.DestinationPath).FullName | Should -Exist
    }
    It "Should work without FontColor parameter" {
        (Add-WatermarkToImage @PassParamsNoFontColor).FullName | Should -Exist
    }
    It "Should throw not found exception when ImageInput does not exist" {
        $scriptBlock = { Add-WatermarkToImage @FailParams -ErrorAction Stop }
        $scriptBlock | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'ImageInput'. File AsBuiltReport.png not found!"
    }
}