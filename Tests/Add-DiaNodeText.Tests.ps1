BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Join-Hashtable.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlFontProperty.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaNodeText.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-NodeObject.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlTable.ps1')
}

Describe Add-DiaNodeText {
    BeforeAll {
        $HTMLOutPut = Add-DiaNodeText -Text "WAN" -Name 'Wan' -TextAlign 'Center' -FontSize 12 -FontColor 'black' -TableBorder 0 -TableBorderStyle 'SOLID' -IconDebug $false -TableBorderColor Blue
        $HTMLOutPutDebug = Add-DiaNodeText -Text "WAN" -Name 'Wan' -TextAlign 'Center' -FontSize 12 -FontColor 'black' -TableBorder 0 -TableBorderStyle 'SOLID' -IconDebug $true -TableBorderColor Blue
    }

    It "Should return a HTML table with Text 'WAN'" {
        $HTMLOutPut | Should -BeExactly '<TABLE PORT="EdgeDot" STYLE="SOLID" BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="1" BGCOLOR="#FFFFFF" COLOR="Blue"><TR><TD STYLE="SOLID" ALIGN="Center" colspan="1"><FONT FACE="Segoe Ui" POINT-SIZE="12" COLOR="black">WAN</FONT></TD></TR></TABLE>'
    }
    It "Should return Wan as Name in the Node Object" {
        $HTMLOutPut | Should -Match ">WAN<"
    }
    It "Should return a HTML table with color=`"blue`" text" {
        $HTMLOutPut | Should -Match "COLOR=`"Blue`""
    }
    It "Should return a HTML table with red colored table" {
        $HTMLOutPutDebug | Should -Match 'COLOR="red"'
    }
    It "Should return a HTML table with '#FFCCCC' colored table" {
        $HTMLOutPutDebug | Should -Match 'BGCOLOR="#FFCCCC"'
    }
}