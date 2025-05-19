BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Get-DiaNodeFiller.ps1
}

Describe Get-DiaNodeFiller {
    BeforeAll {
        $HTMLOutPut = Get-DiaNodeFiller
        $HTMLOutPutDebug = Get-DiaNodeFiller -IconDebug $true
    }

    It "Should return a HTML table with BlankFiller.png icon" {
        $HTMLOutPut | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'><img src='BlankFiller.png'/></TD></TR></TABLE>"
    }
    It "Should return a HTML table with BlankFiller.png icon with IconDebug Enabled" {
        $HTMLOutPutDebug | Should -BeExactly "<TABLE color='red' border='1' cellborder='1' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' colspan='1'>Spacer</TD></TR></TABLE>"
    }
}