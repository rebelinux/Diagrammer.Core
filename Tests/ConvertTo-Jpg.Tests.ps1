BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Jpg.ps1')
}

Describe ConvertTo-Jpg {
    BeforeAll {
        $GraphvizObj = 'digraph g {
            compound="true";
            "web1"->"database1"
            "web1"->"database2"
            "web2"->"database1"
            "web2"->"database2"
        }'
        $InvalidGraphvizObj = 'digraph g {
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
            DestinationPath = "F:\output.png"
        }
    }

    It "Should return output.jpg path" {
        (ConvertTo-Jpg @PassParams).FullName | Should -Exist
    }
    It "Should Not return output.jpg path" {
        $scriptBlock = { ConvertTo-Jpg @FailParams }
        $scriptBlock | Should -Not -Exist
    }
}