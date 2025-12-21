BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlFontProperty.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaHtmlTable.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-NodeObject.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlTable.ps1')
}

Describe Add-DiaHtmlTable {
    BeforeAll {
        $Images = @{
            "Main_Logo" = "Diagrammer.png"
            "ForestRoot" = "RootDomain.png"
        }
        $SiteSubnets = @("192.68.5.0/24", "192.68.7.0/24", "10.0.0.0/24")

        $HTMLMultiColumn = Add-DiaHtmlTable -Name "SiteSubnets" -Rows $SiteSubnets -ALIGN "Center" -ColumnSize 2
        $HTMLMultiColumnDebug = Add-DiaHtmlTable -Name "SiteSubnets" -Rows $SiteSubnets -ALIGN "Center" -ColumnSize 2 -DraftMode $true

        $HTMLSingleColumn = Add-DiaHtmlTable -Name "SiteSubnets" -Rows $SiteSubnets -ALIGN "Center" -ColumnSize 1
        $HTMLSingleColumnDebug = Add-DiaHtmlTable -Name "SiteSubnets" -Rows $SiteSubnets -ALIGN "Center" -ColumnSize 1 -DraftMode $true
    }
    # Todo
    # 1. Add test for Subgraph

    It "Should return a single column HTML table" {
        $HTMLSingleColumn | Should -BeExactly '<TABLE PORT="EdgeDot" STYLE="SOLID" BORDER="0" CELLBORDER="0" CELLSPACING="5" CELLPADDING="5" BGCOLOR="#ffffff" COLOR="#000000"><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.68.5.0/24</FONT></TD></TR><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.68.7.0/24</FONT></TD></TR><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">10.0.0.0/24</FONT></TD></TR></TABLE>'
    }
    It "Should return a single column HTML table with draftmode enabled" {
        $HTMLSingleColumnDebug | Should -BeExactly '<TABLE PORT="EdgeDot" STYLE="SOLID" BORDER="1" CELLBORDER="0" CELLSPACING="5" CELLPADDING="5" BGCOLOR="#ffffff" COLOR="red"><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.68.5.0/24</FONT></TD></TR><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.68.7.0/24</FONT></TD></TR><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">10.0.0.0/24</FONT></TD></TR></TABLE>'
    }
    It "Should return a multi column HTML table" {
        $HTMLMultiColumn | Should -BeExactly '<TABLE PORT="EdgeDot" STYLE="SOLID" BORDER="0" CELLBORDER="0" CELLSPACING="5" CELLPADDING="5" BGCOLOR="#ffffff" COLOR="#000000"><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.68.5.0/24</FONT></TD><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.68.7.0/24</FONT></TD></TR><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">10.0.0.0/24</FONT></TD></TR></TABLE>'
    }
    It "Should return a multi column HTML table with draftmode enabled" {
        $HTMLMultiColumnDebug | Should -BeExactly '<TABLE PORT="EdgeDot" STYLE="SOLID" BORDER="1" CELLBORDER="0" CELLSPACING="5" CELLPADDING="5" BGCOLOR="#ffffff" COLOR="red"><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.68.5.0/24</FONT></TD><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">192.68.7.0/24</FONT></TD></TR><TR><TD ALIGN="Center" COLSPAN="1"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">10.0.0.0/24</FONT></TD></TR></TABLE>'
    }
}