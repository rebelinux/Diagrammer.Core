BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Join-Hashtable.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlFontProperty.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaNodeImage.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-NodeObject.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlTable.ps1')
}

Describe Add-DiaNodeImage {
    BeforeAll {
        $Images = @{
            'Main_Logo' = 'Diagrammer.png'
        }

        $IconPath = Join-Path -Path $TestsFolder -ChildPath 'Icons'

        $HTMLOutPut = Add-DiaNodeImage -Name 'WAN' -ImagesObj $Images -IconType 'Main_Logo' -IconPath $IconPath -ImageSizePercent 70
        $HTMLOutPutDebug = Add-DiaNodeImage -Name 'Wan' -ImagesObj $Images -IconType 'Main_Logo' -DraftMode $true

        $HTMLOutPutNodeObj = Add-DiaNodeImage -Name 'Wan' -ImagesObj $Images -IconType 'Main_Logo' -NodeObject
        $HTMLOutPutDebugNodeObj = Add-DiaNodeImage -Name 'Wan' -ImagesObj $Images -IconType 'Main_Logo' -DraftMode $true -NodeObject

        $HTMLOutPutGraphvizAttributes = Add-DiaNodeImage -Name 'WAN' -ImagesObj $Images -IconType 'Main_Logo' -IconPath $IconPath -NodeObject -GraphvizAttributes @{color = 'blue' }

    }

    It 'Should return a HTML table with Diagrammer.png image' {
        $HTMLOutPut | Should -BeExactly '<TABLE PORT="EdgeDot" STYLE="SOLID" BORDER="0" CELLBORDER="0" CELLSPACING="1" CELLPADDING="1" BGCOLOR="#FFFFFF" COLOR="#000000"><TR><TD STYLE="SOLID" ALIGN="Center" fixedsize="true" width="210" height="143.5" colspan="1"><img src="Diagrammer.png"/></TD></TR></TABLE>'
    }
    It 'Should return a HTML table with the IMG tag' {
        $HTMLOutPut | Should -Match '<img src="Diagrammer.png"/>'
    }
    It 'Should return a HTML table with red colored table' {
        $HTMLOutPutDebug | Should -Match 'COLOR="red"'
    }
    It 'Should return Wan as Name in the Node Object' {
        $HTMLOutPutNodeObj | Should -Match "`"Wan`""
    }
    It 'Should return a HTML table with WAN Image text' {
        $HTMLOutPutDebugNodeObj | Should -Match 'WAN'
    }
    It 'Should return a HTML table without the IMG tag' {
        $HTMLOutPutDebug | Should -Not -Match "<img src='Diagrammer.png'/>"
    }

    It 'Should throw an error when IconPath is not provided and ImageSizePercent is less than 100' {
        { Add-DiaNodeImage -Name 'WAN' -ImagesObj $Images -IconType 'Main_Logo' -ImageSizePercent 30 } | Should -Throw -ExpectedMessage 'IconPath is required when ImageSizePercent is less than 100.'
    }

    It "Should return a HTML table with color=`"blue`" text" {
        $HTMLOutPutGraphvizAttributes | Should -Match "color=`"blue`""
    }
}