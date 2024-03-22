. $PSScriptRoot\_InitializeTests.ps1

Describe "Get-DiaHTMLTable" {
    BeforeAll {
        $Images = @{
            "Main_Logo" = "Diagrammer.png"
            "ForestRoot" = "RootDomain.png"
        }
        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")
        $HTMLMultiColumn = Get-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -ColumnSize 2 -MultiColunms
        $HTMLSingleColumn = Get-DiaHTMLTable -Rows $SiteSubnets -Align "Center"
        $HTMLSingleColumnIcon = Get-DiaHTMLTable -Rows $SiteSubnets -Align "Center" -Logo "ForestRoot" -ImagesObj $Images
    }

    It "Should returns a single column HMLT table" {
        $HTMLSingleColumn | Should -BeExactly '<TABLE STYLE="ROUNDED" border="0" cellborder="0" cellpadding="5"><TR><TD valign="top" align="Center" colspan="2"><B><FONT POINT-SIZE="14">192.68.5.0/24</FONT></B></TD></TR><TR><TD valign="top" align="Center" colspan="2"><B><FONT POINT-SIZE="14">192.68.7.0/24</FONT></B></TD></TR><TR><TD valign="top" align="Center" colspan="2"><B><FONT POINT-SIZE="14">10.0.0.0/24</FONT></B></TD></TR></TABLE>'
    }
    It "Should returns a multi column HMLT table" {
        $HTMLMultiColumn | Should -BeExactly '<TABLE border="0" cellborder="0" cellpadding="5"><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.5.0/24</FONT></TD><TD align="Center" colspan="1"><FONT POINT-SIZE="14">192.68.7.0/24</FONT></TD></TR><TR><TD align="Center" colspan="1"><FONT POINT-SIZE="14">10.0.0.0/24</FONT></TD></TR></TABLE>'
    }
    It "Should returns a multi column HMLT table with single Icon" {
        $HTMLSingleColumnIcon | Should -BeExactly '<TABLE STYLE="ROUNDED" border="0" cellborder="0" cellpadding="5"><TR><TD fixedsize="true" width="80" height="80" ALIGN="Center" colspan="1" rowspan="4"><img src="RootDomain.png"/></TD></TR><TR><TD valign="top" align="Center" colspan="2"><B><FONT POINT-SIZE="14">192.68.5.0/24</FONT></B></TD></TR><TR><TD valign="top" align="Center" colspan="2"><B><FONT POINT-SIZE="14">192.68.7.0/24</FONT></B></TD></TR><TR><TD valign="top" align="Center" colspan="2"><B><FONT POINT-SIZE="14">10.0.0.0/24</FONT></B></TD></TR></TABLE>'
    }
}