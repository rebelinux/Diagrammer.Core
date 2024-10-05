BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Get-DiaNodeIcon.ps1
}

Describe Get-DiaNodeIcon {
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

    It "Should return a HMLT table" {
        $HTMLOutPut | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='0'><TR><TD ALIGN='Center' colspan='1'><img src='RootDomain.png'/></TD></TR><TR><TD align='Center'><B><FONT POINT-SIZE='14'>Server-DC-01v</FONT></B></TD></TR><TR><TD align='Center' colspan='1'><FONT POINT-SIZE='14'>Memory: 4GB</FONT></TD></TR></TABLE>"
    }
    It "Should return a HMLT table with the IMG tag" {
        $HTMLOutPut | Should -Match "<img src='RootDomain.png'/>"
    }
    It "Should return a HMLT table with red colored table" {
        $HTMLOutPutDebug | Should -Match "color='red'"
    }
    It "Should return a HMLT table without the IMG tag" {
        $HTMLOutPutDebug | Should -Not -Match "<img src='RootDomain.png'/>"
    }
}