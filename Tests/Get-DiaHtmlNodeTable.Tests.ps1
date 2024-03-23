BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Get-DiaHTMLNodeTable.ps1
}

Describe Get-DiaHTMLNodeTable {
    BeforeAll {
        $Images = @{
            "Main_Logo" = "Diagrammer.png"
            "DomainController" = "AD_DC.png"
        }
        $DCsArray = @("Server-dc-01v", "Server-dc-02v", "Server-dc-03v", "Server-dc-04v", "Server-dc-05v", "Server-dc-06v")

        $HTMLMultiColumn = Get-DiaHTMLNodeTable -inputObject $DCsArray -columnSize 3 -Align 'Center' -iconType "DomainController" -MultiIcon -ImagesObj $Images
        $HTMLMultiColumnDebug = Get-DiaHTMLNodeTable -inputObject $DCsArray -columnSize 3 -Align 'Center' -iconType "DomainController" -MultiIcon -ImagesObj $Images -IconDebug $true

        $HTMLSingleColumn = Get-DiaHTMLNodeTable -inputObject $DCsArray -Align 'Center' -iconType "DomainController" -ImagesObj $Images
        $HTMLSingleColumnDebug = Get-DiaHTMLNodeTable -inputObject $DCsArray -Align 'Center' -iconType "DomainController" -ImagesObj $Images -IconDebug $true
    }

    It "Should return a multi column HTML table with icon image at each cell" {
        $HTMLMultiColumn | Should -BeExactly '<TABLE PORT="EdgeDot" border="0" cellborder="0" cellpadding="5"><TR><TD ALIGN="Center" colspan="1"><img src="AD_DC.png"/></TD><TD ALIGN="Center" colspan="1"><img src="AD_DC.png"/></TD><TD ALIGN="Center" colspan="1"><img src="AD_DC.png"/></TD></TR><TR><TD PORT="Server-dc-01v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-01v</B></FONT></TD><TD PORT="Server-dc-02v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-02v</B></FONT></TD><TD PORT="Server-dc-03v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-03v</B></FONT></TD></TR><TR><TD ALIGN="Center" colspan="1"><img src="AD_DC.png"/></TD><TD ALIGN="Center" colspan="1"><img src="AD_DC.png"/></TD><TD ALIGN="Center" colspan="1"><img src="AD_DC.png"/></TD></TR><TR><TD PORT="Server-dc-04v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-04v</B></FONT></TD><TD PORT="Server-dc-05v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-05v</B></FONT></TD><TD PORT="Server-dc-06v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14"><B>Server-dc-06v</B></FONT></TD></TR></TABLE>'
    }
    It "Should return a multi column HTML table with ICON text at each cell in debug mode" {
        $HTMLMultiColumnDebug | Should -BeExactly '<TABLE PORT="EdgeDot" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD ALIGN="Center" colspan="1">ICON</TD><TD ALIGN="Center" colspan="1">ICON</TD><TD ALIGN="Center" colspan="1">ICON</TD></TR><TR><TD PORT="Server-dc-01v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-01v</FONT></TD><TD PORT="Server-dc-02v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-02v</FONT></TD><TD PORT="Server-dc-03v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-03v</FONT></TD></TR><TR><TD ALIGN="Center" colspan="1">ICON</TD><TD ALIGN="Center" colspan="1">ICON</TD><TD ALIGN="Center" colspan="1">ICON</TD></TR><TR><TD PORT="Server-dc-04v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-04v</FONT></TD><TD PORT="Server-dc-05v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-05v</FONT></TD><TD PORT="Server-dc-06v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-06v</FONT></TD></TR></TABLE>'
    }
    It "Should return a single column HTML table with ICON at top cell" {
        $HTMLSingleColumn | Should -BeExactly '<TABLE PORT="EdgeDot" border="0" cellborder="0" cellpadding="5"><TR><TD ALIGN="Center" colspan="6"><img src="AD_DC.png"/></TD></TR><TR><TD PORT="Server-dc-01v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-01v</FONT></TD></TR><TR><TD PORT="Server-dc-02v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-02v</FONT></TD></TR><TR><TD PORT="Server-dc-03v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-03v</FONT></TD></TR><TR><TD PORT="Server-dc-04v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-04v</FONT></TD></TR><TR><TD PORT="Server-dc-05v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-05v</FONT></TD></TR><TR><TD PORT="Server-dc-06v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-06v</FONT></TD></TR></TABLE>'
    }
    It "Should return a single column HTML table with ICON at top cell in debug mode" {
        $HTMLSingleColumnDebug | Should -BeExactly '<TABLE PORT="EdgeDot" COLOR="red" border="1" cellborder="1" cellpadding="5"><TR><TD ALIGN="Center" colspan="6">ICON</TD></TR><TR><TD PORT="Server-dc-01v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-01v</FONT></TD></TR><TR><TD PORT="Server-dc-02v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-02v</FONT></TD></TR><TR><TD PORT="Server-dc-03v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-03v</FONT></TD></TR><TR><TD PORT="Server-dc-04v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-04v</FONT></TD></TR><TR><TD PORT="Server-dc-05v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-05v</FONT></TD></TR><TR><TD PORT="Server-dc-06v" ALIGN="Center" colspan="1"><FONT POINT-SIZE="14">Server-dc-06v</FONT></TD></TR></TABLE>'
    }
    It 'Should Throw a Message' {
        { Get-DiaHTMLNodeTable -inputObject $DCsArray -Align 'Center' -iconType "DomainControlle" -ImagesObj $Images } | Should -Throw -ExpectedMessage 'Error: DomainControlle IconType not found in Images object'
    }
}