BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlTable.ps1')
}
Describe 'Format-HtmlTable' {
    Context 'basic behavior' {
        It 'returns an HTML TABLE wrapper' {
            $html = Format-HtmlTable -TableRowContent '<TR><TD>Cell</TD></TR>'
            $html | Should -Match '^<TABLE\b.*>.*</TABLE>$'
        }

        It 'includes default attributes' {
            $html = Format-HtmlTable -TableRowContent '<TR><TD>Cell</TD></TR>'
            $html | Should -Match 'PORT="EdgeDot"'
            $html | Should -Match 'STYLE="Solid"'
            $html | Should -Match 'BORDER="1"'
            $html | Should -Match 'CELLBORDER="1"'
            $html | Should -Match 'CELLSPACING="1"'
            $html | Should -Match 'CELLPADDING="1"'
            $html | Should -Match 'BGCOLOR="white"'
            $html | Should -Match 'COLOR="black"'
        }
    }

    Context 'custom parameters' {
        It 'honors provided attributes' {
            $content = '<TR><TD port="p1">X</TD></TR>'
            $html = Format-HtmlTable -Port 'p1' -TableStyle 'Rounded' -TableBackgroundColor 'red' -TableBorder 2 -TableBorderColor 'blue' -CellBorder 0 -CellSpacing 3 -CellPadding 4 -TableRowContent $content
            $html | Should -Match 'PORT="p1"'
            $html | Should -Match 'STYLE="Rounded"'
            $html | Should -Match 'BORDER="2"'
            $html | Should -Match 'CELLBORDER="0"'
            $html | Should -Match 'CELLSPACING="3"'
            $html | Should -Match 'CELLPADDING="4"'
            $html | Should -Match 'BGCOLOR="red"'
            $html | Should -Match 'COLOR="blue"'
            $html | Should -Match $content
        }

        It 'returns the exact expected string when fully specified' {
            $port = 'p2'; $style = 'Dashed'; $bg = 'yellow'; $border = 5; $borderColor = 'green'; $cellBorder = 2; $cellSpacing = 6; $cellPadding = 7; $content = '<TR><TD>Y</TD></TR>'
            $expectedAttrs = 'PORT="{0}" STYLE="{1}" BORDER="{2}" CELLBORDER="{3}" CELLSPACING="{4}" CELLPADDING="{5}" BGCOLOR="{6}" COLOR="{7}"' -f $port, $style, $border, $cellBorder, $cellSpacing, $cellPadding, $bg, $borderColor
            $expected = "<TABLE $expectedAttrs>$content</TABLE>"
            $html = Format-HtmlTable -Port $port -TableStyle $style -TableBackgroundColor $bg -TableBorder $border -TableBorderColor $borderColor -CellBorder $cellBorder -CellSpacing $cellSpacing -CellPadding $cellPadding -TableRowContent $content
            $html | Should -Be $expected
        }
    }

    Context 'content handling' {
        It 'preserves HTML content passed in TableRowContent' {
            $content = '<TR><TD><B>bold &amp; <I>italic</I></B></TD></TR>'
            $html = Format-HtmlTable -TableRowContent $content
            $html | Should -Match $content
        }

        It 'handles empty cell content' {
            $content = '<TR><TD></TD></TR>'
            $html = Format-HtmlTable -TableRowContent $content
            $html | Should -Match '<TD></TD>'
        }
    }
}
