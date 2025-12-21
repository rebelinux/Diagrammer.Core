BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'ConvertTo-Svg.ps1')
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
            DestinationPath = 'TestDriv:\output.svg'
        }
    }

    It 'Should return output.svg path' {
        (ConvertTo-Svg @PassParams).FullName | Should -Exist
    }
    It 'Should Not return output.svg path' {
        $scriptBlock = { ConvertTo-Svg @FailParams }
        $scriptBlock | Should -Not -Exist
    }
}