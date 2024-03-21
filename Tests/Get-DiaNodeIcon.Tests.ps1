BeforeAll {
    $Images = @{
        "Main_Logo" = "Diagrammer.png"
        "ForestRoot" = "RootDomain.png"
    }
    $DC = "Server-DC-01v"
    $DCRows = [ordered]@{
        CPU = "2"
        Memory = "4GB"
    }
    $HTMLOutPut = Get-DiaNodeIcon -Name $DC -IconType "ForestRoot" -Align "Center" -Rows $DCRows -ImagesObj $Images
    $HTMLOutPutDebug = Get-DiaNodeIcon -Name $DC -IconType "ForestRoot" -Align "Center" -Rows $DCRows -ImagesObj $Images -IconDebug $true
}

Describe "Get-DiaNodeIcon" {
    It "Returns a HMLT table" {
        $HTMLOutPut | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='0'><TR><TD ALIGN='Center' colspan='1'><img src='RootDomain.png'/></TD></TR><TR><TD align='Center'><B>Server-DC-01v</B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>CPU: 2</FONT></TD></TR> <TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>Memory: 4GB</FONT></TD></TR></TABLE>"
    }
    It "Returns a HMLT table with the IMG tag" {
        $HTMLOutPut | Should -Match "<img src='RootDomain.png'/>"
    }
    It "Returns a HMLT table with red colored table" {
        $HTMLOutPutDebug | Should -Match "color='red'"
    }
    It "Returns a HMLT table without the IMG tag" {
        $HTMLOutPutDebug | Should -Not -Match "<img src='RootDomain.png'/>"
    }
}