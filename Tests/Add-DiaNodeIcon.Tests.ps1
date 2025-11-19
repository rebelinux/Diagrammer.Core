BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaNodeIcon.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlFontProperty.ps1')
}

Describe Add-DiaNodeIcon {
    BeforeAll {
        $Images = @{
            "Main_Logo" = "Diagrammer.png"
            "ForestRoot" = "RootDomain.png"
        }
        $DC = "Server-DC-01v"
        $DCRows = [ordered]@{
            Memory = "4GB"
        }
        $HTMLOutPut = Add-DiaNodeIcon -Name $DC -IconType "ForestRoot" -Align "Center" -Rows $DCRows -ImagesObj $Images
        $HTMLOutPutDebug = Add-DiaNodeIcon -Name $DC -IconType "ForestRoot" -Align "Center" -Rows $DCRows -ImagesObj $Images -IconDebug $true
    }

    It "Should return a HTML table" {
        $HTMLOutPut | Should -BeExactly '<TABLE PORT="EdgeDot" border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="Center" colspan="1" rowspan="1" valign="Middle"><img src="RootDomain.png"/></TD></TR><TR><TD align="Center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000"><B>Server-DC-01v</B></FONT></TD></TR><TR><TD PORT="Memory" align="Center" colspan="1"><FONT POINT-SIZE="14">Memory: 4GB</FONT></TD></TR></TABLE>'
    }
    It "Should return a HTML table with the IMG tag" {
        [string]$HTMLOutPut | Should -Match 'img src="RootDomain.png"'
    }
    It "Should return a HTML table with red colored table" {
        $HTMLOutPutDebug | Should -Match 'color="red"'
    }
    It "Should return a HTML table without the IMG tag" {
        $HTMLOutPutDebug | Should -Not -Match "<img src='RootDomain.png'/>"
    }
}