BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Join-Hashtable.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaNodeShape.ps1')
}

Describe Add-DiaNodeShape {
    BeforeAll {

        $HTMLOutPut = Add-DiaNodeShape -Name "AD-Forest" -Shape triangle -ShapeFillColor "lightblue" -ShapeFontSize 12 -ShapeFontColor "black" -ShapeFontName "Arial" -ShapeStyle "filled" -ShapeOrientation 0 -ShapeWidth 0.75 -ShapeHeight 0.5 -ShapeBorderSize 1 -ShapeLabelPosition "center"

        $HTMLOutPutDebug = Add-DiaNodeShape -Name "AD-Forest" -Shape triangle -ShapeFillColor "lightblue" -ShapeFontSize 12 -ShapeFontColor "black" -ShapeFontName "Arial" -ShapeStyle "filled" -ShapeOrientation 0 -ShapeWidth 0.75 -ShapeHeight 0.5 -ShapeBorderSize 1 -ShapeLabelPosition "center" -DraftMode $true

        $HTMLOutPutGraphvizAttributes = Add-DiaNodeShape -Name "AD-Forest" -Shape triangle -ShapeFillColor "lightblue" -ShapeFontSize 12 -ShapeFontColor "black" -ShapeFontName "Arial" -ShapeStyle "filled" -ShapeOrientation 0 -ShapeBorderSize 1 -ShapeLabelPosition "center" -GraphvizAttributes @{ margin = "0"; fixedsize = "true" }

        $HTMLOutPutGraphvizAttributesReplacement = Add-DiaNodeShape -Name "AD-Forest" -Shape triangle -ShapeFillColor "lightblue" -ShapeFontSize 12 -ShapeFontColor "black" -ShapeFontName "Arial" -ShapeStyle "filled" -ShapeOrientation 0 -ShapeBorderSize 1 -ShapeLabelPosition "center" -GraphvizAttributes @{ fillcolor = "yellow" }

    }

    It "Should return a Graphviz Node representation with triangle shape and filled style" {
        $HTMLOutPut | Should -BeExactly '"AD-Forest" [fillcolor="lightblue";width="0.75";color="black";label="AD-Forest";fontname="Arial";fontcolor="black";orientation="0";labelloc="c";height="0.5";shape="triangle";penwidth="1";fontsize="12";style="filled";]'
    }

    It "Should return a Graphviz Node representation with triangle shape and filled style in DraftMode" {
        $HTMLOutPutDebug | Should -Match 'color="red"'
    }

    It "Should return a Graphviz Node representation with triangle shape and filled style with additional Graphviz attributes" {
        $HTMLOutPutGraphvizAttributes | Should -Match 'fixedsize="true"'
    }
    It "Should return a Graphviz Node representation with triangle shape and filled style with replacement Graphviz attributes" {
        $HTMLOutPutGraphvizAttributesReplacement | Should -Match 'fillcolor="yellow"'
    }
}