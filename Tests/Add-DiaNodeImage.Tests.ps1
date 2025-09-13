BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Join-Hashtable.ps1
    . $ProjectRoot\SRC\private\Add-DiaNodeImage.ps1
}

Describe Add-DiaNodeImage {
    BeforeAll {
        $Images = @{
            "Main_Logo" = "Diagrammer.png"
        }

        $IconPath = Join-Path -Path $TestsFolder -ChildPath "Icons"

        $HTMLOutPut = Add-DiaNodeImage -Name "WAN" -ImagesObj $Images -IconType "Main_Logo" -IconPath $IconPath -ImageSizePercent 30
        $HTMLOutPutDebug = Add-DiaNodeImage -Name 'Wan' -ImagesObj $Images -IconType "Main_Logo" -DraftMode $true

        $HTMLOutPutNodeObj = Add-DiaNodeImage -Name 'Wan' -ImagesObj $Images -IconType "Main_Logo" -NodeObject
        $HTMLOutPutDebugNodeObj = Add-DiaNodeImage -Name 'Wan' -ImagesObj $Images -IconType "Main_Logo" -DraftMode $true -NodeObject

        $HTMLOutPutGraphvizAttributes = Add-DiaNodeImage -Name "WAN" -ImagesObj $Images -IconType "Main_Logo" -IconPath $IconPath -NodeObject -GraphvizAttributes @{color = 'blue' }

    }

    It "Should return a HTML table with Diagrammer.png image" {
        $HTMLOutPut | Should -BeExactly "<TABLE border='0' color='#000000' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='Center' fixedsize='true' width='30' height='24.6' colspan='1'><img src='Diagrammer.png'/></TD></TR></TABLE>"
    }
    It "Should return a HTML table with the IMG tag" {
        $HTMLOutPut | Should -Match "<img src='Diagrammer.png'/>"
    }
    It "Should return a HTML table with red colored table" {
        $HTMLOutPutDebug | Should -Match "color='red'"
    }
    It "Should return Wan as Name in the Node Object" {
        $HTMLOutPutNodeObj | Should -Match "`"Wan`""
    }
    It "Should return a HTML table with WAN Image text" {
        $HTMLOutPutDebugNodeObj | Should -Match "WAN Image"
    }
    It "Should return a HTML table without the IMG tag" {
        $HTMLOutPutDebug | Should -Not -Match "<img src='Diagrammer.png'/>"
    }

    It "Should throw an error when IconPath is not provided and ImageSizePercent is less than 100" {
        { Add-DiaNodeImage -Name "WAN" -ImagesObj $Images -IconType "Main_Logo" -ImageSizePercent 30 } | Should -Throw -ExpectedMessage "IconPath is required when ImageSizePercent is less than 100."
    }

    It "Should return a HTML table with color=`"blue`" text" {
        $HTMLOutPutGraphvizAttributes | Should -Match "color=`"blue`""
    }
}