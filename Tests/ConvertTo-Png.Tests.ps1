BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\ConvertTo-Png.ps1
}

Describe ConvertTo-Png {
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
            DestinationPath = Join-Path $TestDrive 'output.png'
        }
        $FailParams = @{
            GraphObj = $GraphvizObj
            DestinationPath = "TestDriv:\output.png"
        }
    }

    It "Should return output.svg path" {
        (ConvertTo-Png @PassParams).FullName | Should -Exist
    }
    It -Skip "Should throw" {
        { ConvertTo-Png @FailParams } | Should -Throw
    }
}