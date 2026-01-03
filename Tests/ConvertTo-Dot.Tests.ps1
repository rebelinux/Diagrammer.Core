BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Dot.ps1')
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
            DestinationPath = Join-Path -Path $TestDrive -ChildPath 'output.dot'
        }
        $FailParams = @{
            GraphObj = $GraphvizObj
            DestinationPath = 'TestDriv:\output.dot'
        }
    }

    It 'Should return output.dot path' {
        (ConvertTo-Dot @PassParams).FullName | Should -Exist
    }
    It 'Should Not return output.dot path' {
        $scriptBlock = { ConvertTo-Dot @FailParams }
        $scriptBlock | Should -Not -Exist
    }
}