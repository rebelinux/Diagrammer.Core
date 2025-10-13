BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaNodeSpacer.ps1')
}

Describe Add-DiaNodeSpacer {
    BeforeAll {
        $HTMLOutPut = Add-DiaNodeSpacer -Name "Spacer" -ShapeWidth 1 -ShapeHeight 1 -DraftMode $false
        $HTMLOutPutDebug = Add-DiaNodeSpacer -Name "Spacer" -ShapeWidth 1 -ShapeHeight 1 -DraftMode $true
    }

    It "Should return a HTML table with BlankFiller.png icon" {
        $HTMLOutPut | Should -BeExactly '"Spacer" [style="invis";fillcolor="transparent";labelloc="c";shape="rectangle";color="black";penwidth="1";label="Spacer";orientation="0";width="1";height="1";]'
    }
    It "Should return a HTML table with BlankFiller.png icon with IconDebug Enabled" {
        $HTMLOutPutDebug | Should -BeExactly '"Spacer" [style="filled";fillcolor="#FFCCCC";labelloc="c";shape="rectangle";color="red";penwidth="1";label="Spacer";orientation="0";width="1";height="1";]'
    }
}