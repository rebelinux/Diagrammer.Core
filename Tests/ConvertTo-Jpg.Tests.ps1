BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\ConvertTo-Jpg.ps1
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
            DestinationPath = Join-Path $TestDrive 'output.jpg'
        }
        $FailParams = @{
            GraphObj = $GraphvizObj
            DestinationPath = "TestDriv:\output.jpg"
        }
    }

    It "Should return output.svg path" {
        (ConvertTo-jpg @PassParams).FullName | Should -Exist
    }
    It "Should throw" {
        { ConvertTo-jpg @FailParams } | Should -Throw
    }
}