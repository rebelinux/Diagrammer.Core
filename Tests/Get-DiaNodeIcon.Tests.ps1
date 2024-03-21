. $PSScriptRoot\_InitializeTests.ps1

BeforeAll {
    $Images = @{
        "Main_Logo" = "Diagrammer.png"
        "ForestRoot" = "RootDomain.png"
    }
    $DC = "Server-DC-01v"
    $DCRows = [ordered]@{
        Memory = "4GB"
    }
    $HTMLOutPut = Get-DiaNodeIcon -Name $DC -IconType "ForestRoot" -Align "Center" -Rows $DCRows -ImagesObj $Images
    $HTMLOutPutDebug = Get-DiaNodeIcon -Name $DC -IconType "ForestRoot" -Align "Center" -Rows $DCRows -ImagesObj $Images -IconDebug $true
}

Describe "Get-DiaNodeIcon" {
    It "Should returns a HMLT table" {
        $HTMLOutPut | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='0'><TR><TD ALIGN='Center' colspan='1'><img src='RootDomain.png'/></TD></TR><TR><TD align='Center'><B>Server-DC-01v</B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>Memory: 4GB</FONT></TD></TR></TABLE>"
    }
    It "Should returns a HMLT table with the IMG tag" {
        $HTMLOutPut | Should -Match "<img src='RootDomain.png'/>"
    }
    It "Should returns a HMLT table with red colored table" {
        $HTMLOutPutDebug | Should -Match "color='red'"
    }
    It "Should returns a HMLT table without the IMG tag" {
        $HTMLOutPutDebug | Should -Not -Match "<img src='RootDomain.png'/>"
    }
}