BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
}

Describe Example13 -Skip:$($PSVersionTable.Platform -eq 'Unix') {
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
        $RunFile = & $ProjectRoot\Examples\Example13.ps1 @PassParamsDot
    }

    Context "Format Parameter Tests" {
        It "Should exist Example1.Dot" {
            ($RunFile).FullName | Should -Exist
        }
        It "Should exist Example1.png" {
            (& $ProjectRoot\Examples\Example13.ps1 @PassParamsPng).FullName | Should -Exist
        }
        It "Should return error about unsupported Format" {
            { & $ProjectRoot\Examples\Example13.ps1 @PassParamsTif } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'Format'. The argument `"tif`" does not belong to the set `"pdf,svg,png,dot,base64,jpg`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }
    }
    Context "Graphviz Dot Node Tests" {
        Context "Graphviz Dot Main Label Tests" {
            It "Should match HTML label with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $DotContent | Should -Match 'img src="Diagrammer.png"'
                $DotContent | Should -Match '>Web Application Diagram<'
            }
        }

        Context "Graphviz Dot Node Icon Tests" {

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
            It "Should match Router01 node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "Router01"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match WAN node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "WAN"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match RouterNetworkInfo node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "RouterNetworkInfo"

                $DotContent | Should -Match $ExpectedText
            }
        }

        Context "Graphviz Dot Node Icon (Label) Tests" {
            It "Should match HTML label Web01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw

                $DotContent | Should -Match 'img src="Server.png"'
                $DotContent | Should -Match '>Web-Server-01<'
                $DotContent | Should -Match 'OS: Redhat Linux'
                $DotContent | Should -Match 'Version: 10'
                $DotContent | Should -Match 'Build: 10.1'
                $DotContent | Should -Match 'Edition: Enterprise'
            }
            It "Should match HTML label App01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw

                $DotContent | Should -Match 'img src="Server.png"'
                $DotContent | Should -Match '>Web-Server-02<'
                $DotContent | Should -Match 'OS: Redhat Linux'
                $DotContent | Should -Match 'Version: 10'
                $DotContent | Should -Match 'Build: 10.1'
                $DotContent | Should -Match 'Edition: Enterprise'
            }
            It "Should match HTML label DB01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw

                $DotContent | Should -Match 'img src="Server.png"'
                $DotContent | Should -Match '>Db-Server-01<'
                $DotContent | Should -Match 'OS: Oracle Server'
                $DotContent | Should -Match 'Version: 8'
                $DotContent | Should -Match 'Build: 8.2'
                $DotContent | Should -Match 'Edition: Enterprise'
            }
            It "Should match HTML label Router01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $DotContent | Should -Match 'img src="Router.png"'
                $DotContent | Should -Match '>Core-Router<'
                $DotContent | Should -Match 'Version: 15.2'
            }
            It "Should match HTML label Wan node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw

                $DotContent | Should -Match "img src='Cloud.png'"
                $DotContent | Should -Match 'WAN'
            }
            It "Should match HTML label RouterNetworkInfo node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $DotContent | Should -Match '>Interfaces Table<'
                $DotContent | Should -Match '>S0/0:<'
                $DotContent | Should -Match '>164.42.203.10/30<'
                $DotContent | Should -Match '>G0/0:<'
                $DotContent | Should -Match '>192.168.5.10/24<'
            }
        }
    }
    Context "Graphviz Dot Edge Tests" {
        It "Should match minlen=3 edge attribute" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "minlen=3"

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
        It "Should match Router01 -> Web01 edge" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "Router01 -> Web01"
            $ExpectedEdgeLabel = "GE0/0"

            $DotContent | Should -Match $ExpectedText
            $DotContent | Should -Match $ExpectedEdgeLabel
        }
        It "Should match WAN -> Router01 edge" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "WAN -> Router01"
            $ExpectedEdgeLabel = "Serial0/0"

            $DotContent | Should -Match $ExpectedText
            $DotContent | Should -Match $ExpectedEdgeLabel
        }
        It "Should match Router01 -> RouterNetworkInfo edge" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "Router01 -> RouterNetworkInfo"

            $DotContent | Should -Match $ExpectedText
        }
    }
    Context "Graphviz Dot Rank Tests" {
        It "Should match Router01 -> RouterNetworkInfo rank=same" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'rank=same'
            ([regex]::Matches($DotContent, $ExpectedText)).count | Should -Be 2
        }
    }
    Context "Signature Tests" {
        It "Should match subgraph clusterSignatureLabel" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'label=<<TABLE STYLE="rounded,dashed" border="2" cellborder="0" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="left" colspan="1" rowspan="4"><img src="Signature_Logo.png"/></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Author: Bugs Bunny</FONT></B></TD></TR><TR><TD valign="top" align="left" colspan="2"><B><FONT POINT-SIZE="14">Company: ACME Inc.</FONT></B></TD></TR></TABLE>>,'

            $DotContent | Should -Match 'img src="Signature_Logo.png"'
            $DotContent | Should -Match '>Author: Bugs Bunny<'
            $DotContent | Should -Match '>Company: ACME Inc.<'

        }
        It "Should match Graphviz attribute labeljust" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'labeljust=right'
            $DotContent | Should -Match $ExpectedText
        }
        It "Should match Graphviz attribute labelloc" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'labelloc=b'
            $DotContent | Should -Match $ExpectedText
        }
    }
}