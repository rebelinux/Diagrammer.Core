BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
}

Describe Example02 {
    BeforeAll {
        $PassParamsDot = @{
            Path = $TestDrive
            Format = @('dot')
        }
        $PassParamsPng = @{
            Path = $TestDrive
            Format = @('png')
        }
        $PassParamsTif = @{
            Path = $TestDrive
            Format = @('tif')
        }
        $FailParams = @{
            Path = 'C:\logo.png'
            Format = @('dot')
        }

        $RunFile = & $ProjectRoot\Examples\Example02.ps1 @PassParamsDot
    }

    Context 'Format Parameter Tests' {
        It 'Should exist Example1.Dot' {
            ($RunFile).FullName | Should -Exist
        }
        It 'Should exist Example1.png' {
            (& $ProjectRoot\Examples\Example02.ps1 @PassParamsPng).FullName | Should -Exist
        }
        It 'Should return error about unsupported Format' {
            { & $ProjectRoot\Examples\Example02.ps1 @PassParamsTif } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'Format'. The argument `"tif`" does not belong to the set `"pdf,svg,png,dot,base64,jpg`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }
    }
    Context 'Graphviz Dot source Tests' {
        It 'Should match HTML label with embedded image' {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw

            $DotContent | Should -Match 'img src="Diagrammer.png"'
            $DotContent | Should -Match '>Web Application Diagram<'

        }
        It 'Should match Web-Server-01 node' {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'Web-Server-01'

            $DotContent | Should -Match $ExpectedText
        }
        It 'Should match App-Server-01 node' {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'App-Server-01'

            $DotContent | Should -Match $ExpectedText
        }
        It 'Should match DB-Server-01 node' {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'DB-Server-01'

            $DotContent | Should -Match $ExpectedText
        }
        It 'Should match Web-Server-01 -> App-Server-01 edge' {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = '"Web-Server-01" -> "App-Server-01"'

            $DotContent | Should -Match $ExpectedText
        }
        It 'Should match App-Server-01 -> DB-Server-01 edge' {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = '"App-Server-01" -> "DB-Server-01"'

            $DotContent | Should -Match $ExpectedText
        }
    }
}