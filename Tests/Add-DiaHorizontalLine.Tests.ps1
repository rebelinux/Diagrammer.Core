BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Add-DiaHorizontalLine.ps1
}

Describe Add-DiaHorizontalLine {
    BeforeAll {
        $DotOutPut = Add-DiaHorizontalLine
        $DotOutPutDebug = Add-DiaHorizontalLine -DraftMode $true
        $DotOutPutWithParams = Add-DiaHorizontalLine -HStart "First" -HEnd "Last"
        $DotOutPutWithParamsArrowsTest = Add-DiaHorizontalLine -Arrowtail box -Arrowhead diamond
        $DotOutPutWithParamsLineTest = Add-DiaHorizontalLine -LineStyle solid -LineWidth 3 -LineColor red
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
        $DotOutPutWithParamsLineLengthTest = Add-DiaHorizontalLine -HStartLineLength 3
        $DotOutPutWithAllParamsTest = Add-DiaHorizontalLine -HStart "HStart" -HEnd "HEnd" -Arrowtail box -Arrowhead diamond -LineStyle solid -LineWidth 3 -LineColor red -HStartLineLength 3
        $DotOutPutWithAllParamsDebugTest = Add-DiaHorizontalLine -HStart "HStart" -HEnd "HEnd" -Arrowtail box -Arrowhead diamond -LineStyle solid -LineWidth 3 -LineColor red -HStartLineLength 3 -DraftMode $true

    }

    It "Should return a Graphviz dot source with 2 nodes forming a horizontal line" {
        $DotOutPut | Should -BeExactly @('"HStart" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"HEnd" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '{ rank=same;  "HStart"; "HEnd"; }', '"HStart"->"HEnd" [arrowhead="none";color="black";minlen="1";style="solid";penwidth="1";arrowtail="none";]')

    }
    It "Should return a Graphviz dot source with 2 nodes forming a horizontal line with debug information" {
        $DotOutPutDebug | Should -BeExactly @('"HStart" [color="black";fillcolor="red";shape="plain";style="filled";]', '"HEnd" [color="black";fillcolor="red";shape="plain";style="filled";]', '{ rank=same;  "HStart"; "HEnd"; }', '"HStart"->"HEnd" [arrowhead="none";color="red";minlen="1";style="solid";penwidth="1";arrowtail="none";]')
    }
    It "Should return a Graphviz dot source with 2 nodes forming a horizontal line with custom Node Names" {
        $DotOutPutWithParams | Should -BeExactly @('"First" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"Last" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '{ rank=same;  "First"; "Last"; }', '"First"->"Last" [arrowhead="none";color="black";minlen="1";style="solid";penwidth="1";arrowtail="none";]')
    }
    It "Should return a Graphviz dot source with 2 nodes forming a horizontal line with custom Arrowhead and Arrowtail" {
        $DotOutPutWithParamsArrowsTest | Should -BeExactly @('"HStart" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"HEnd" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '{ rank=same;  "HStart"; "HEnd"; }', '"HStart"->"HEnd" [arrowhead="diamond";color="black";minlen="1";style="solid";penwidth="1";arrowtail="box";]')
    }
    It "Should return a error: Cannot validate argument on parameter 'Arrowtail'" {
        $scriptBlock = { Add-DiaHorizontalLine @DotOutPutWithParamsArrowsTestError }
        $scriptBlock | Should -Throw -ExpectedMessage 'Cannot validate argument on parameter ''Arrowtail''. The argument "baba" does not belong to the set "none,normal,inv,dot,invdot,odot,invodot,diamond,odiamond,ediamond,crow,box,obox,open,halfopen,empty,invempty,tee,vee,icurve,lcurve,rcurve,icurve,box,obox,diamond,odiamond,ediamond,crow,tee,vee,dot,odot,inv,invodot,invempty,invbox,invodiamond,invtee,invvee,none" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again.'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a horizontal line with custom LineStyle, LineWidth and LineColor" {
        $DotOutPutWithParamsLineTest | Should -BeExactly @('"HStart" [color="red";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"HEnd" [color="red";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '{ rank=same;  "HStart"; "HEnd"; }', '"HStart"->"HEnd" [arrowhead="none";color="red";minlen="1";style="solid";penwidth="3";arrowtail="none";]')
    }
    It "Should return a error: Cannot validate argument on parameter 'LineWidth'" {
        $scriptBlock = { Add-DiaHorizontalLine @DotOutPutWithParamsLineTestError }
        $scriptBlock | Should -Throw -ExpectedMessage 'Cannot process argument transformation on parameter ''LineWidth''. Cannot convert value "baba" to type "System.Int32". Error: "Input string was not in a correct format."'
    }
    It "Should return a Graphviz dot source with 2 nodes forming a horizontal line with custom HStartLineLength" {
        $DotOutPutWithParamsLineLengthTest | Should -BeExactly @('"HStart" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"HEnd" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '{ rank=same;  "HStart"; "HEnd"; }', '"HStart"->"HEnd" [arrowhead="none";color="black";minlen="3";style="solid";penwidth="1";arrowtail="none";]')
    }
    It "Should return a Graphviz dot source with 2 nodes forming a horizontal line with all parameters" {
        $DotOutPutWithAllParamsTest | Should -BeExactly @('"HStart" [color="red";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"HEnd" [color="red";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '{ rank=same;  "HStart"; "HEnd"; }', '"HStart"->"HEnd" [arrowhead="diamond";color="red";minlen="3";style="solid";penwidth="3";arrowtail="box";]')
    }
    It "Should return a Graphviz dot source with 2 nodes forming a horizontal line with all parameters and DraftMode" {
        $DotOutPutWithAllParamsDebugTest | Should -BeExactly @('"HStart" [color="black";fillcolor="red";shape="plain";style="filled";]', '"HEnd" [color="black";fillcolor="red";shape="plain";style="filled";]', '{ rank=same;  "HStart"; "HEnd"; }', '"HStart"->"HEnd" [arrowhead="diamond";color="red";minlen="3";style="solid";penwidth="3";arrowtail="box";]')
    }
}