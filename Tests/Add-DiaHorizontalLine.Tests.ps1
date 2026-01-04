BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaHorizontalLine.ps1')
}

Describe Add-DiaHorizontalLine {
    BeforeAll {
        [string]$DotOutPut = Add-DiaHorizontalLine
        [string]$DotOutPutDebug = Add-DiaHorizontalLine -DraftMode $true
        [string]$DotOutPutWithParams = Add-DiaHorizontalLine -HStart 'First' -HEnd 'Last'
        [string]$DotOutPutWithParamsArrowsTest = Add-DiaHorizontalLine -Arrowtail box -Arrowhead diamond
        [string]$DotOutPutWithParamsLineTest = Add-DiaHorizontalLine -LineStyle solid -LineWidth 3 -LineColor red
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
        [string]$DotOutPutWithParamsLineLengthTest = Add-DiaHorizontalLine -HStartLineLength 3
        [string]$DotOutPutWithAllParamsTest = Add-DiaHorizontalLine -HStart 'HStart' -HEnd 'HEnd' -Arrowtail box -Arrowhead diamond -LineStyle solid -LineWidth 3 -LineColor red -HStartLineLength 3
        [string]$DotOutPutWithAllParamsDebugTest = Add-DiaHorizontalLine -HStart 'HStart' -HEnd 'HEnd' -Arrowtail box -Arrowhead diamond -LineStyle solid -LineWidth 3 -LineColor red -HStartLineLength 3 -DraftMode $true

    }

    It 'Should return a Graphviz dot source with 2 nodes forming a horizontal line' {
        $MatchHStart = '"HStart" \[.*\]'
        $MatchHEnd = '"HEnd" \[.*\]'
        $MatchRankSame = '{ rank=same;  "HStart"; "HEnd"; }'
        $MatchEdge = '"HStart"->"HEnd" \[.*\]'
        $DotOutPut | Should -Match $MatchHStart
        $DotOutPut | Should -Match $MatchHEnd
        $DotOutPut | Should -Match $MatchRankSame
        $DotOutPut | Should -Match $MatchEdge

    }
    It 'Should return a Graphviz dot source with 2 nodes forming a horizontal line with debug information' {
        $Matchfillcolor = 'fillcolor="red";'
        $Matchcolor = 'color="red";'
        $DotOutPutDebug | Should -Match $Matchfillcolor
        $DotOutPutDebug | Should -Match $Matchcolor
    }
    It 'Should return a Graphviz dot source with 2 nodes forming a horizontal line with custom Node Names' {
        $MatchFirst = '"First" \[.*\]'
        $MatchLast = '"Last" \[.*\]'
        $MatchRankSame = '{ rank=same;  "First"; "Last"; }'
        $MatchEdge = '"First"->"Last" \[.*\]'
        $DotOutPutWithParams | Should -Match $MatchFirst
        $DotOutPutWithParams | Should -Match $MatchLast
        $DotOutPutWithParams | Should -Match $MatchRankSame
        $DotOutPutWithParams | Should -Match $MatchEdge
    }
    # It "Should return a Graphviz dot source with 2 nodes forming a horizontal line with custom Arrowhead and Arrowtail" {
    #     $DotOutPutWithParamsArrowsTest | Should -BeExactly @('"HStart" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '"HEnd" [color="black";width="0.001";shape="point";fixedsize="true";style="invis";fillcolor="transparent";height="0.001";]', '{ rank=same;  "HStart"; "HEnd"; }', '"HStart"->"HEnd" [arrowhead="diamond";color="black";minlen="1";style="solid";penwidth="1";arrowtail="box";]')
    # }
    It 'Should return a Graphviz dot source with custom line length range validation' {
        [string]$DotOutPutMinLineLength = Add-DiaHorizontalLine -HStartLineLength 1
        [string]$DotOutPutMaxLineLength = Add-DiaHorizontalLine -HStartLineLength 10
        $DotOutPutMinLineLength | Should -Match 'minlen="1"'
        $DotOutPutMaxLineLength | Should -Match 'minlen="10"'
    }

    It 'Should return a error: HStartLineLength out of range' {
        $scriptBlock = { Add-DiaHorizontalLine -HStartLineLength 11 }
        $scriptBlock | Should -Throw
    }

    It 'Should return a Graphviz dot source with custom line width range validation' {
        [string]$DotOutPutMinWidth = Add-DiaHorizontalLine -LineWidth 1
        [string]$DotOutPutMaxWidth = Add-DiaHorizontalLine -LineWidth 10
        $DotOutPutMinWidth | Should -Match 'penwidth="1"'
        $DotOutPutMaxWidth | Should -Match 'penwidth="10"'
    }

    It 'Should return a error: LineWidth out of range' {
        $scriptBlock = { Add-DiaHorizontalLine -LineWidth 0 }
        $scriptBlock | Should -Throw
    }

    It 'Should return a Graphviz dot source with dotted line style' {
        [string]$DotOutPutDotted = Add-DiaHorizontalLine -LineStyle dotted
        $DotOutPutDotted | Should -Match 'style="dotted"'
    }

    It 'Should return a Graphviz dot source with dashed line style' {
        [string]$DotOutPutDashed = Add-DiaHorizontalLine -LineStyle dashed
        $DotOutPutDashed | Should -Match 'style="dashed"'
    }

    It 'Should return a Graphviz dot source with bold line style' {
        [string]$DotOutPutBold = Add-DiaHorizontalLine -LineStyle bold
        $DotOutPutBold | Should -Match 'style="bold"'
    }

    It 'Should return a error: Invalid line style' {
        $scriptBlock = { Add-DiaHorizontalLine -LineStyle invalid }
        $scriptBlock | Should -Throw
    }

    It 'Should accept multiple arrow types for Arrowhead' {
        [string]$DotOutPutNormal = Add-DiaHorizontalLine -Arrowhead normal
        [string]$DotOutPutCrow = Add-DiaHorizontalLine -Arrowhead crow
        [string]$DotOutPutDotArrow = Add-DiaHorizontalLine -Arrowhead dot
        $DotOutPutNormal | Should -Match 'arrowhead="normal"'
        $DotOutPutCrow | Should -Match 'arrowhead="crow"'
        $DotOutPutDotArrow | Should -Match 'arrowhead="dot"'
    }

    It 'Should accept multiple arrow types for Arrowtail' {
        [string]$DotOutPutNormal = Add-DiaHorizontalLine -Arrowtail normal
        [string]$DotOutPutOpen = Add-DiaHorizontalLine -Arrowtail open
        [string]$DotOutPutVee = Add-DiaHorizontalLine -Arrowtail vee
        $DotOutPutNormal | Should -Match 'arrowtail="normal"'
        $DotOutPutOpen | Should -Match 'arrowtail="open"'
        $DotOutPutVee | Should -Match 'arrowtail="vee"'
    }

    It 'Should return a Graphviz dot source with custom node names and all line parameters' {
        [string]$DotOutPut = Add-DiaHorizontalLine -HStart 'Source' -HEnd 'Target' -LineStyle dashed -LineWidth 2 -LineColor blue
        $DotOutPut | Should -Match '"Source"'
        $DotOutPut | Should -Match '"Target"'
        $DotOutPut | Should -Match 'style="dashed"'
        $DotOutPut | Should -Match 'penwidth="2"'
        $DotOutPut | Should -Match 'color="blue"'
    }
    It "Should return a error: Cannot validate argument on parameter 'Arrowtail'" {
        $scriptBlock = { Add-DiaHorizontalLine @DotOutPutWithParamsArrowsTestError }
        $scriptBlock | Should -Throw -ExpectedMessage 'Cannot validate argument on parameter ''Arrowtail''. The argument "baba" does not belong to the set "none,normal,inv,dot,invdot,odot,invodot,diamond,odiamond,ediamond,crow,box,obox,open,halfopen,empty,invempty,tee,vee,icurve,lcurve,rcurve,icurve,box,obox,diamond,odiamond,ediamond,crow,tee,vee,dot,odot,inv,invodot,invempty,invbox,invodiamond,invtee,invvee,none" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again.'
    }
    It 'Should correctly apply custom LineStyle, LineWidth, and LineColor to the horizontal line' {
        $DotOutPutWithParamsLineTest | Should -Match '"HStart"->"HEnd" \[.*style="solid";.*\]'
        $DotOutPutWithParamsLineTest | Should -Match '"HStart"->"HEnd" \[.*penwidth="3";.*\]'
        $DotOutPutWithParamsLineTest | Should -Match '"HStart"->"HEnd" \[.*color="red";.*\]'
    }
    It "Should return a error: Cannot validate argument on parameter 'LineWidth'" {
        $scriptBlock = { Add-DiaHorizontalLine @DotOutPutWithParamsLineTestError }
        $scriptBlock | Should -Throw
    }
    It 'Should return a Graphviz dot source with 2 nodes forming a horizontal line with custom HStartLineLength' {
        $DotOutPutWithParamsLineLengthTest | Should -Match 'minlen="3";'
    }
    It 'Should return a Graphviz dot source with 2 nodes forming a horizontal line with all parameters' {
        $DotOutPutWithAllParamsTest | Should -Match 'arrowhead="diamond";'
        $DotOutPutWithAllParamsTest | Should -Match 'arrowtail="box";'
        $DotOutPutWithAllParamsTest | Should -Match 'style="solid";'
        $DotOutPutWithAllParamsTest | Should -Match 'penwidth="3";'
        $DotOutPutWithAllParamsTest | Should -Match 'color="red";'
        $DotOutPutWithAllParamsTest | Should -Match 'minlen="3";'
    }
    It 'Should return a Graphviz dot source with 2 nodes forming a horizontal line with all parameters and DraftMode' {
        $DotOutPutWithAllParamsDebugTest | Should -Match 'fillcolor="red";'
        $DotOutPutWithAllParamsDebugTest | Should -Match 'color="red";'
    }
}