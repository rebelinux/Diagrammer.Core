BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
}

Describe Example14 {
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
        $RunFile = & $ProjectRoot\Examples\Example14.ps1 @PassParamsDot
    }

    Context "Format Parameter Tests" {
        It "Should exist Example1.Dot" {
            ($RunFile).FullName | Should -Exist
        }
        It "Should exist Example1.png" {
            (& $ProjectRoot\Examples\Example14.ps1 @PassParamsPng).FullName | Should -Exist
        }
        It "Should return error about unsupported Format" {
            { & $ProjectRoot\Examples\Example14.ps1 @PassParamsTif } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'Format'. The argument `"tif`" does not belong to the set `"pdf,svg,png,dot,base64,jpg`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }
    }
    Context "Graphviz Dot Node Tests" {
        Context "Graphviz Dot Main Label Tests" {
            It "Should match HTML label with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
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
            It "Should match Firewall node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "Firewall"

                $DotContent | Should -Match $ExpectedText
            }
        }

        Context "Graphviz Dot Node Icon (Label) Tests" {
            It "Should match HTML label Web01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = 'label=<<TABLE COLOR="gray" STYLE="dashed,rounded" PORT="EdgeDot" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="3"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="20"><B>Web Server Farm</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_Ubuntu.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Ubuntu Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 24</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 11</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Edition: Enterprise</FONT></TD></TR></TABLE>>,'

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label App01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>App-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Windows Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 2019</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 17763.3163</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Datacenter</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label DB01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label DB01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label Router01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label WAN node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Server.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Db-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Oracle Server</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 8</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 8.2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Edition: Enterprise</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label RouterNetworkInfo node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = 'label=<<TABLE COLOR="black" STYLE="solid,rounded" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="center" colspan="2"><FONT FACE="Segoe Ui" Color="#565656" POINT-SIZE="14"><B>Interfaces Table</B></FONT></TD></TR><TR><TD align="center" colspan="1"><FONT POINT-SIZE="14">S0/0:</FONT></TD><TD align="center" colspan="1"><FONT POINT-SIZE="14">164.42.203.10/30</FONT></TD></TR><TR><TD align="center" colspan="1"><FONT POINT-SIZE="14">G0/0:</FONT></TD><TD align="center" colspan="1"><FONT POINT-SIZE="14">192.168.5.10/24</FONT></TD></TR></TABLE>>,'

                $DotContent | Should -Match $ExpectedText
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
        It "Should match WAN -> Firewall edge" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "WAN -> Firewall"
            $ExpectedEdgeLabel = "port1"

            $DotContent | Should -Match $ExpectedText
            $DotContent | Should -Match $ExpectedEdgeLabel
        }
        It "Should match Router01 -> RouterNetworkInfo edge" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "Router01 -> RouterNetworkInfo"

            $DotContent | Should -Match $ExpectedText
        }
        It "Should match Firewall -> Router01 edge" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = "Firewall -> Router01"
            $ExpectedEdgeLabel = "Serial0/0"

            $DotContent | Should -Match $ExpectedText
            $DotContent | Should -Match $ExpectedEdgeLabel
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
            $DotContent | Should -Match $ExpectedText
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
    Context "Graphviz Attributes Tests" {
        It "Should match Graphviz attribute shape" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'shape=rectangle'
            $DotContent | Should -Match $ExpectedText
        }
        It "Should match Graphviz attribute headlabel" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'headlabel="Serial0/0"'
            $DotContent | Should -Match $ExpectedText
        }
        It "Should match Graphviz attribute taillabel" {
            $DotFile = ($RunFile).FullName
            $DotContent = Get-Content -Path $DotFile -Raw
            $ExpectedText = 'taillabel=port2'
            $DotContent | Should -Match $ExpectedText
        }
    }
}