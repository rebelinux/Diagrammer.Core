BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\ConvertTo-Pdf.ps1
}

Describe ConvertTo-Pdf {
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
            DestinationPath = Join-Path $TestDrive 'output.pdf'
        }
        $FailParams = @{
            GraphObj = $GraphvizObj
            DestinationPath = "F:\output.png"
        }
    }

    It "Should return output.pdf path" {
        (ConvertTo-Pdf @PassParams).FullName | Should -Exist
    }
    It "Should Not return output.pdf path" {
        $scriptBlock = { ConvertTo-Pdf @FailParams }
        $scriptBlock | Should -Not -Exist
    }
}