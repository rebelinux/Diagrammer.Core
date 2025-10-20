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
        $HTMLOutPut | Should -Match 'fillcolor="lightblue"'
        $HTMLOutPut | Should -Match 'label="AD-Forest"'
        $HTMLOutPut | Should -Match 'shape="triangle"'
        $HTMLOutPut | Should -Match 'style="filled"'
        $HTMLOutPut | Should -Match 'orientation="0"'
        $HTMLOutPut | Should -Match 'labelloc="c"'
        $HTMLOutPut | Should -Match '"AD-Forest"'
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