BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaHtmlSignatureTable.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlFontProperty.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlTable.ps1')
}

Describe Add-DiaHtmlSignatureTable {
    BeforeAll {
        $Images = @{
            'Main_Logo' = 'Diagrammer.png'
            'ForestRoot' = 'RootDomain.png'
        }
        $Rows = @('Jonathan Colon', 'Zen PR Solutions')
        $HTMLSignaturewithLogo = Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows $Rows -Align 'Center' -Logo 'Main_Logo'
        $HTMLSignaturewithLogoDebug = Add-DiaHtmlSignatureTable -ImagesObj $Images -Rows $Rows -Align 'Center' -Logo 'Main_Logo' -IconDebug $true

    }

    It 'Should return a multiple column HTML table with an Logo' {
        $HTMLSignaturewithLogo | Should -BeExactly '<TABLE PORT="EdgeDot" STYLE="rounded,dashed" BORDER="0" CELLBORDER="0" CELLSPACING="5" CELLPADDING="5" BGCOLOR="white" COLOR="#000000"><TR><TD fixedsize="true" width="80" height="80" ALIGN="Center" colspan="1" rowspan="4"><img src="Diagrammer.png"/></TD></TR><TR><TD valign="top" align="Center" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Jonathan Colon</FONT></TD></TR><TR><TD valign="top" align="Center" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Zen PR Solutions</FONT></TD></TR></TABLE>'
    }
    It 'Should return a multiple column HTML table with an Logo in Debug Mode' {
        $HTMLSignaturewithLogoDebug | Should -BeExactly '<TABLE PORT="EdgeDot" STYLE="rounded,dashed" BORDER="0" CELLBORDER="0" CELLSPACING="5" CELLPADDING="5" BGCOLOR="white" COLOR="black"><TR><TD bgcolor="#FFCCCC" ALIGN="Center" colspan="1" rowspan="4">Diagrammer.png</TD></TR><TR><TD valign="top" align="Center" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Jonathan Colon</FONT></TD></TR><TR><TD valign="top" align="Center" colspan="2"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Zen PR Solutions</FONT></TD></TR></TABLE>'
    }
}