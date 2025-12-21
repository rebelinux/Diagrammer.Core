BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaNodeSpacer.ps1')
}

Describe Add-DiaNodeSpacer {
    BeforeAll {
        $HTMLOutPut = Add-DiaNodeSpacer -Name 'Spacer' -ShapeWidth 1 -ShapeHeight 1 -DraftMode $false
        $HTMLOutPutDebug = Add-DiaNodeSpacer -Name 'Spacer' -ShapeWidth 1 -ShapeHeight 1 -DraftMode $true
    }

    It 'Should return a dummy node with rectangle shape' {
        $MatchRectangle = 'shape="rectangle"'
        $MatchNameSpacer = '"Spacer"'
        $MatchLabelSpacer = 'label="Spacer"'
        $HTMLOutPut | Should -Match $MatchNameSpacer
        $HTMLOutPut | Should -Match $MatchLabelSpacer
        $HTMLOutPut | Should -Match $MatchRectangle
    }
    It 'Should return a dummy node with rectangle shape with IconDebug Enabled' {
        $MatchRectangle = 'shape="rectangle"'
        $MatchNameSpacer = '"Spacer"'
        $MatchLabelSpacer = 'label="Spacer"'
        $MatchColorRed = 'color="red"'
        $MatchColorBackground = 'fillcolor="#FFCCCC"'
        $HTMLOutPut | Should -Match $MatchNameSpacer
        $HTMLOutPut | Should -Match $MatchLabelSpacer
        $HTMLOutPut | Should -Match $MatchRectangle
        $HTMLOutPutDebug | Should -Match $MatchNameSpacer
    }
}