BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Add-DiaHTMLTable.ps1
}

Describe Add-DiaHTMLTable {
    BeforeAll {
        $Images = @{
            "Main_Logo" = "Diagrammer.png"
            "ForestRoot" = "RootDomain.png"
        }
        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")

        $HTMLMultiColumn = Add-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -ColumnSize 2
        $HTMLMultiColumnDebug = Add-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -ColumnSize 2

        $HTMLSingleColumn = Add-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -ColumnSize 1
        $HTMLSingleColumnDebug = Add-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -ColumnSize 1

    }
    # Todo
    # 1. Add test for Subgraph

    It "Should return a single column HTML table" {
        $HTMLSingleColumn | Should -BeExactly '<TABLE STYLE="rounded,dashed" COLOR="#000000" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>'
    }
    It "Should return a multi column HTML table" {
        $HTMLMultiColumn | Should -BeExactly '<TABLE STYLE="rounded,dashed" COLOR="#000000" border="0" cellborder="0" cellpadding="5" cellspacing="5"><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>'
    }
}