BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\ConvertTo-Dot.ps1
}

Describe ConvertTo-Dot {
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
            DestinationPath = Join-Path $TestDrive 'output.dot'
        }
        $FailParams = @{
            GraphObj = $GraphvizObj
            DestinationPath = "TestDriv:\output.dot"
        }
    }

    It "Should return output.dot path" {
        (ConvertTo-Dot @PassParams).FullName | Should -Exist
    }
    It -Skip "Should throw" {
        { ConvertTo-Dot @FailParams } | Should -Throw
    }
}