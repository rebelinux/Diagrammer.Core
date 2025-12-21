BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlFontProperty.ps1')
}

Describe Format-HtmlFontProperty {
    It 'Should create bold font property' {
        Format-HtmlFontProperty -Text 'Sample Text' -FontBold | Should -Be '<FONT FACE="Segoe Ui" POINT-SIZE="12" COLOR="black"><B>Sample Text</B></FONT>'
    }
    It 'Should create italic font property' {
        Format-HtmlFontProperty -Text 'Sample Text' -FontItalic | Should -Be '<FONT FACE="Segoe Ui" POINT-SIZE="12" COLOR="black"><I>Sample Text</I></FONT>'
    }
    It 'Should create underline font property' {
        Format-HtmlFontProperty -Text 'Sample Text' -FontUnderline | Should -Be '<FONT FACE="Segoe Ui" POINT-SIZE="12" COLOR="black"><U>Sample Text</U></FONT>'
    }
    It 'Should create subscript font property' {
        Format-HtmlFontProperty -Text 'Sample Text' -FontSubscript | Should -Be '<FONT FACE="Segoe Ui" POINT-SIZE="12" COLOR="black"><SUB>Sample Text</SUB></FONT>'
    }
    It 'Should create superscript font property' {
        Format-HtmlFontProperty -Text 'Sample Text' -FontSuperscript | Should -Be '<FONT FACE="Segoe Ui" POINT-SIZE="12" COLOR="black"><SUP>Sample Text</SUP></FONT>'
    }
    It 'Should create overline font property' {
        Format-HtmlFontProperty -Text 'Sample Text' -FontOverline | Should -Be '<FONT FACE="Segoe Ui" POINT-SIZE="12" COLOR="black"><O>Sample Text</O></FONT>'
    }
    It 'Should create strikethrough font property' {
        Format-HtmlFontProperty -Text 'Sample Text' -FontStrikeThrough | Should -Be '<FONT FACE="Segoe Ui" POINT-SIZE="12" COLOR="black"><S>Sample Text</S></FONT>'
    }
    It 'Should create font with 30 size and red color' {
        Format-HtmlFontProperty -Text 'Sample Text' -FontSize 30 -FontColor 'red' | Should -Be '<FONT FACE="Segoe Ui" POINT-SIZE="30" COLOR="red">Sample Text</FONT>'
    }
    It 'Should create a bold/italic font with 30 size and blue color' {
        Format-HtmlFontProperty -Text 'Sample Text' -FontBold -FontItalic -FontSize 30 -FontColor 'blue' | Should -Be '<FONT FACE="Segoe Ui" POINT-SIZE="30" COLOR="blue"><I><B>Sample Text</B></I></FONT>'
    }
}