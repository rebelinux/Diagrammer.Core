BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
}

Describe AdvancedExample02 {
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
        $RunFile = & $ProjectRoot\Examples\AdvancedExample02.ps1 @PassParamsDot
    }

    Context "Format Parameter Tests" {
        It "Should exist Example1.Dot" {
            ($RunFile).FullName | Should -Exist
        }
        It "Should exist Example1.png" {
            (& $ProjectRoot\Examples\Example15.ps1 @PassParamsPng).FullName | Should -Exist
        }
        It "Should return error about unsupported Format" {
            { & $ProjectRoot\Examples\Example15.ps1 @PassParamsTif } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'Format'. The argument `"tif`" does not belong to the set `"pdf,svg,png,dot,base64,jpg`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }
    }
    Context "Graphviz Dot Node Tests" {
        Context "Graphviz Dot Main Label Tests" {
            It "Should match HTML label with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='24'>Web Application Diagram</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
        }

        Context "Graphviz Dot Node Icon Tests" {

            It "Should match UK-WebServer-01 node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "UK-WebServer-01"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match UK-WebServer-02 node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "UK-WebServer-02"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match UK-WebServer-03 node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "UK-WebServer-03"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match UK-WebServer-04 node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "UK-WebServer-04"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match UK-WebServer-05 node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "UK-WebServer-05"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match UK-WebServer-06 node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "UK-WebServer-06"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match USA-WebServers node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "USA-WebServers"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match Info-Box node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "Info-Box"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match Info-Box2 node" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "Info-Box2"

                $DotContent | Should -Match $ExpectedText
            }
        }

        Context "Graphviz Dot Node Icon (Label) Tests" {
            It "Should match HTML label UK-WebServer-01 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-01</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label UK-WebServer-02 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-02</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label UK-WebServer-03 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-03</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label UK-WebServer-04 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-04</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label UK-WebServer-05 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-05</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label UK-WebServer-06 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='Linux_Server_RedHat.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='18'>Web-Server-06</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>OS: Redhat Linux</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Version: 10</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='18'>Build: 10.1</FONT></TD></TR></TABLE>>,"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label USA-WebServers node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = 'label=<<TABLE BGColor="#a8c3b8ff" COLOR="darkgray" STYLE="dashed,rounded" border="1" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD valign="BOTTOM" ALIGN="Center" colspan="1" fixedsize="true" width="40" height="40"><IMG src="Server.png"></IMG></TD></TR><TR><TD valign="TOP" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui Black" Color="#565656" POINT-SIZE="22"><B>Diagrammer SubGraph</B></FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="22"><TABLE COLOR="#000000" PORT="EdgeDot" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD PORT="Web-Server-01" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-01</B></FONT></TD><TD PORT="Web-Server-02" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-02</B></FONT></TD><TD PORT="Web-Server-03" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-03</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD><TD ALIGN="Center" colspan="1"><img src="Linux_Server_RedHat.png"/></TD></TR><TR><TD PORT="Web-Server-04" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-04</B></FONT></TD><TD PORT="Web-Server-05" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-05</B></FONT></TD><TD PORT="Web-Server-06" ALIGN="Center" colspan="1"><FONT POINT-SIZE="18"><B>Web-Server-06</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">OS: Redhat Linux</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Version: 10</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD><TD ALIGN="Center" colspan="1"><FONT POINT-SIZE="18">Build: 10.1</FONT></TD></TR></TABLE></FONT></TD></TR></TABLE>>,'

                $DotContent | Should -Match $ExpectedText
            }
        }

        Context "Graphviz Dot Node Icon (Label) Tests" {
            It "Should match HTML label Info-Box node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE STYLE='SOLID' bgcolor='#FFFF00' border='2' color='#FF0000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD STYLE='SOLID' ALIGN='Left' colspan='1'><FONT FACE='Segoe Ui' POINT-SIZE='30' COLOR='#0000FF'><B>This is a test text box.<BR/>It supports multiple lines of text.<BR/>You can customize the font, size, color, and background.</B></FONT></TD></TR></TABLE>>"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match HTML label Info-Box2 node with embedded image" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "label=<<TABLE border='0' color='#000000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Left' colspan='1'><FONT FACE='Segoe Ui' POINT-SIZE='20' COLOR='#0000FF'><B>Add-DiaHTMLSubGraph permit the use of edges to connect nodes inside and outside the SubGraph.<BR/>
        This is not possible with native Graphviz SubGraphs.<BR/></B></FONT></TD></TR></TABLE>>"

                $DotContent | Should -Match $ExpectedText
            }
        }

        Context "Graphviz Dot Edge Tests" {
            It "Should match minlen=2 edge attribute" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = "minlen=2"

                $DotContent | Should -Match $ExpectedText
            }
            It "Should match USA-WebServers -> Info-Box2 edge" {
                $DotFile = ($RunFile).FullName
                $DotContent = Get-Content -Path $DotFile -Raw
                $ExpectedText = '"USA-WebServers" -> "Info-Box2"'

                $DotContent | Should -Match $ExpectedText
            }
        }

    }

}