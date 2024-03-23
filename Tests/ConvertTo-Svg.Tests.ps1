BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\ConvertTo-Svg.ps1
}

Describe ConvertTo-Svg {
    BeforeAll {
        $GraphvizObj = 'digraph g {
            compound="true";
            "web1"->"database1"
            "web1"->"database2"
            "web2"->"database1"
            "web2"->"database2"
        }'
        $PassParams = @{
            GraphObj = $GraphvizObj
            DestinationPath = Join-Path $TestDrive 'output.svg'
        }
        $FailParams = @{
            GraphObj = $GraphvizObj
            DestinationPath = "TestDrive:\output.svg"
        }
    }

    It "Should returns output.svg path" {
        (ConvertTo-Svg @PassParams).FullName | Should -Exist
    }
    It "Should throw" {
        { ConvertTo-Svg @FailParams } | Should -Throw
    }
}