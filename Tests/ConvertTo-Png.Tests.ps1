BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Png.ps1')
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
            DestinationPath = 'TestDriv:\output.png'
        }
    }

    It 'Should return output.png path' {
        (ConvertTo-Png @PassParams).FullName | Should -Exist
    }
    It 'Should Not return output.png path' {
        $scriptBlock = { ConvertTo-Png @FailParams }
        $scriptBlock | Should -Not -Exist
    }
}