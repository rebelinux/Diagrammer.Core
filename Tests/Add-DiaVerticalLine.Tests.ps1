BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaVerticalLine.ps1')
}

Describe Add-DiaVerticalLine {
    BeforeAll {
        $DotOutPut = Add-DiaVerticalLine
        $DotOutPutDebug = Add-DiaVerticalLine -DraftMode $true
        $DotOutPutWithParams = Add-DiaVerticalLine -VStart "First" -VEnd "Last"
        $DotOutPutWithParamsArrowsTest = Add-DiaVerticalLine -Arrowtail box -Arrowhead diamond
        $DotOutPutWithParamsLineTest = Add-DiaVerticalLine -LineStyle solid -LineWidth 3 -LineColor red
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
        $DotOutPutWithParamsLineLengthTest = Add-DiaVerticalLine -VStartLineLength 3
        $DotOutPutWithAllParamsTest = Add-DiaVerticalLine -VStart "VStart" -VEnd "VEnd" -Arrowtail box -Arrowhead diamond -LineStyle solid -LineWidth 3 -LineColor red -VStartLineLength 3
        $DotOutPutWithAllParamsDebugTest = Add-DiaVerticalLine -VStart "VStart" -VEnd "VEnd" -Arrowtail box -Arrowhead diamond -LineStyle solid -LineWidth 3 -LineColor red -VStartLineLength 3 -DraftMode $true

    }

    It "Should return a Graphviz dot source with 2 nodes forming a vertical line" {
        $DotOutPut | Should -BeExactly '"VStart" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VEnd" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VStart"->"VEnd" [arrowhead="none";color="black";minlen="1";style="solid";penwidth="1";arrowtail="none";]'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with debug information" {
        $DotOutPutDebug | Should -BeExactly '"VStart" [color="black";fillcolor="red";shape="plain";style="filled";]', '"VEnd" [color="black";fillcolor="red";shape="plain";style="filled";]', '"VStart"->"VEnd" [arrowhead="none";color="red";minlen="1";style="solid";penwidth="1";arrowtail="none";]'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with custom Node Names" {
        $DotOutPutWithParams | Should -BeExactly '"First" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"Last" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"First"->"Last" [arrowhead="none";color="black";minlen="1";style="solid";penwidth="1";arrowtail="none";]'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with custom Arrowhead and Arrowtail" {
        $DotOutPutWithParamsArrowsTest | Should -BeExactly '"VStart" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VEnd" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VStart"->"VEnd" [arrowhead="diamond";color="black";minlen="1";style="solid";penwidth="1";arrowtail="box";]'
    }
    It "Should return a error: Cannot validate argument on parameter 'Arrowtail'" {
        $scriptBlock = { Add-DiaVerticalLine @DotOutPutWithParamsArrowsTestError }
        $scriptBlock | Should -Throw
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with custom LineStyle, LineWidth and LineColor" {
        $DotOutPutWithParamsLineTest | Should -BeExactly '"VStart" [color="red";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VEnd" [color="red";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VStart"->"VEnd" [arrowhead="none";color="red";minlen="1";style="solid";penwidth="3";arrowtail="none";]'
    }
    It "Should return a error: Cannot validate argument on parameter 'LineWidth'" {
        $scriptBlock = { Add-DiaVerticalLine @DotOutPutWithParamsLineTestError }
        $scriptBlock | Should -Throw -ExpectedMessage 'Cannot process argument transformation on parameter ''LineWidth''. Cannot convert value "baba" to type "System.Int32". Error: "Input string was not in a correct format."'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with custom VStartLineLength" {
        $DotOutPutWithParamsLineLengthTest | Should -BeExactly '"VStart" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VEnd" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VStart"->"VEnd" [arrowhead="none";color="black";minlen="3";style="solid";penwidth="1";arrowtail="none";]'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with all parameters" {
        $DotOutPutWithAllParamsTest | Should -BeExactly '"VStart" [color="red";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VEnd" [color="red";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"VStart"->"VEnd" [arrowhead="diamond";color="red";minlen="3";style="solid";penwidth="3";arrowtail="box";]'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a vertical line with all parameters and DraftMode" {
        $DotOutPutWithAllParamsDebugTest | Should -BeExactly '"VStart" [color="black";fillcolor="red";shape="plain";style="filled";]', '"VEnd" [color="black";fillcolor="red";shape="plain";style="filled";]', '"VStart"->"VEnd" [arrowhead="diamond";color="red";minlen="3";style="solid";penwidth="3";arrowtail="box";]'
    }
}