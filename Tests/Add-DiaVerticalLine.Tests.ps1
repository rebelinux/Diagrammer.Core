BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaVerticalLine.ps1')
}

Describe Add-DiaVerticalLine {
    BeforeAll {
        [string]$DotOutPut = Add-DiaVerticalLine
        [string]$DotOutPutDebug = Add-DiaVerticalLine -DraftMode $true
        [string]$DotOutPutWithParams = Add-DiaVerticalLine -VStart "First" -VEnd "Last"
        [string]$DotOutPutWithParamsArrowsTest = Add-DiaVerticalLine -Arrowtail box -Arrowhead diamond
        [string]$DotOutPutWithParamsLineTest = Add-DiaVerticalLine -LineStyle solid -LineWidth 3 -LineColor red
        $DotOutPutWithParamsLineTestError = @{
            LineStyle = 'solid'
            LineWidth = 'baba'
            LineColor = 'red'
        }
        $DotOutPutWithParamsArrowsTestError = @{
            Arrowtail = 'baba'
            Arrowhead = 'diamond'
            ErrorAction = 'Stop'
        }
        [string]$DotOutPutWithParamsLineLengthTest = Add-DiaVerticalLine -VStartLineLength 3
        [string]$DotOutPutWithAllParamsTest = Add-DiaVerticalLine -VStart "VStart" -VEnd "VEnd" -Arrowtail box -Arrowhead diamond -LineStyle solid -LineWidth 3 -LineColor red -VStartLineLength 3
        [string]$DotOutPutWithAllParamsDebugTest = Add-DiaVerticalLine -VStart "VStart" -VEnd "VEnd" -Arrowtail box -Arrowhead diamond -LineStyle solid -LineWidth 3 -LineColor red -VStartLineLength 3 -DraftMode $true

    }

    It "Should return a Graphviz dot source with 2 nodes forming a vertical line" {
        $DotOutPut | Should -Match '"VStart"'
        $DotOutPut | Should -Match '"VEnd"'
        $DotOutPut | Should -Match '"VStart"->"VEnd"'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with debug information" {
        $DotOutPutDebug | Should -Match 'fillcolor="red"'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with custom Node Names" {
        $DotOutPutWithParams | Should -Match '"First"'
        $DotOutPutWithParams | Should -Match '"Last"'
        $DotOutPutWithParams | Should -Match '"First"->"Last"'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with custom Arrowhead and Arrowtail" {
        $DotOutPutWithParamsArrowsTest | Should -Match 'arrowhead="diamond"'
        $DotOutPutWithParamsArrowsTest | Should -Match 'arrowtail="box"'
    }
    It "Should return a error: Cannot validate argument on parameter 'Arrowtail'" {
        $scriptBlock = { Add-DiaVerticalLine @DotOutPutWithParamsArrowsTestError }
        $scriptBlock | Should -Throw
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with custom LineStyle, LineWidth and LineColor" {
        $DotOutPutWithParamsLineTest | Should -Match 'style="solid"'
        $DotOutPutWithParamsLineTest | Should -Match 'penwidth="3"'
        $DotOutPutWithParamsLineTest | Should -Match 'color="red"'
    }
    It "Should return a error: Cannot validate argument on parameter 'LineWidth'" {
        $scriptBlock = { Add-DiaVerticalLine @DotOutPutWithParamsLineTestError }
        $scriptBlock | Should -Throw
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with custom VStartLineLength" {
        $DotOutPutWithParamsLineLengthTest | Should -Match 'minlen="3"'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with all parameters" {
        $DotOutPutWithAllParamsTest | Should -Match 'style="solid"'
        $DotOutPutWithAllParamsTest | Should -Match 'penwidth="3"'
        $DotOutPutWithAllParamsTest | Should -Match 'color="red"'
        $DotOutPutWithAllParamsTest | Should -Match 'minlen="3"'
        $DotOutPutWithAllParamsTest | Should -Match 'arrowhead="diamond"'
        $DotOutPutWithAllParamsTest | Should -Match 'arrowtail="box"'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with all parameters and DraftMode" {
        $DotOutPutWithAllParamsDebugTest | Should -Match 'fillcolor="red"'
    }
}