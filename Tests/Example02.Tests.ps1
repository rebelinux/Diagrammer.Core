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

    Context "Format Parameter Tests" {
        It "Should exist Example1.Dot" {
            ($RunFile).FullName | Should -Exist
        }
        It "Should exist Example1.png" {
            (& $ProjectRoot\Examples\Example02.ps1 @PassParamsPng).FullName | Should -Exist
        }
        It "Should return error about unsupported Format" {
            { & $ProjectRoot\Examples\Example02.ps1 @PassParamsTif } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'Format'. The argument `"tif`" does not belong to the set `"pdf,svg,png,dot,base64,jpg`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }
    }
    Context "Graphviz Dot source Tests" {
        It "Should match HTML label with embedded image" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,"

            $DotContent | Should -Match $ExpectedText
        }
        It "Should match Web01 node" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "Web01"

            $DotContent | Should -Match $ExpectedText
        }
        It "Should match App01 node" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "App01"

            $DotContent | Should -Match $ExpectedText
        }
        It "Should match DB01 node" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "DB01"

            $DotContent | Should -Match $ExpectedText
        }
        It "Should match Web01 -> App01 edge" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "Web01 -> App01"

            $DotContent | Should -Match $ExpectedText
        }
        It "Should match App01 -> DB01 edge" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "App01 -> DB01"

            $DotContent | Should -Match $ExpectedText
        }
    }
}