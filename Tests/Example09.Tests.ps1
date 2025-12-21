BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
}

Describe Example09 {
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
        $RunFile = & $ProjectRoot\Examples\Example09.ps1 @PassParamsDot
    }

    Context 'Format Parameter Tests' {
        It 'Should exist Example1.Dot' {
            ($RunFile).FullName | Should -Exist
        }
        It 'Should exist Example1.png' {
            (& $ProjectRoot\Examples\Example09.ps1 @PassParamsPng).FullName | Should -Exist
        }
        It 'Should return error about unsupported Format' {
            { & $ProjectRoot\Examples\Example09.ps1 @PassParamsTif } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'Format'. The argument `"tif`" does not belong to the set `"pdf,svg,png,dot,base64,jpg`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }
    }
    Context 'Graphviz Dot Node Tests' {
        Context 'Graphviz Dot Main Label Tests' {
            It 'Should match HTML label with embedded image' {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw

                $DotContent | Should -Match 'img src="Diagrammer.png"'
                $DotContent | Should -Match '>Web Application Diagram<'
            }
        }

        Context 'Graphviz Dot Node Icon Tests' {

            It 'Should match Web-Server-Farm node' {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = 'Web-Server-Farm'

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
        }

        Context 'Graphviz Dot Node Icon (Label) Tests' {
            It 'Should match HTML label Web-Server-Farm node with embedded image' {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw

                $DotContent | Should -Match 'img src="Server.png"'
                $DotContent | Should -Match 'Web-Server-Farm'
                $DotContent | Should -Match 'OS: Redhat Linux'
                $DotContent | Should -Match 'Version: 10'
                $DotContent | Should -Match 'Build: 10.1'
                $DotContent | Should -Match 'Edition: Enterprise'
            }
            It 'Should match HTML label App01 node with embedded image' {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw

                $DotContent | Should -Match 'img src="Server.png"'
                $DotContent | Should -Match 'Web-Server-02'
                $DotContent | Should -Match 'OS: Redhat Linux'
                $DotContent | Should -Match 'Version: 10'
                $DotContent | Should -Match 'Build: 10.1'
                $DotContent | Should -Match 'Edition: Enterprise'
            }
            It 'Should match HTML label DB01 node with embedded image' {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw

                $DotContent | Should -Match 'img src="Server.png"'
                $DotContent | Should -Match 'Db-Server-01'
                $DotContent | Should -Match 'OS: Oracle Server'
                $DotContent | Should -Match 'Version: 8'
                $DotContent | Should -Match 'Build: 8.2'
                $DotContent | Should -Match 'Edition: Enterprise'
            }
        }
    }
    Context 'Graphviz Dot Edge Tests' {
        It 'Should match minlen=3 edge attribute' {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'minlen=3'

            $DotContent | Should -Match $ExpectedText
        }
        It 'Should match Web-Server-Farm -> App-Server-01 edge' {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = '"Web-Server-Farm" -> "App-Server-01"'

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