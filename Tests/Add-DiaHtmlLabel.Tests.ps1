BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Format-HtmlFontProperty.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaHtmlLabel.ps1')
}

Describe Add-DiaHtmlLabel {
    BeforeAll {
        $MainGraphLabel = @{
            'Forest' = 'Active Directory Forest Diagram'
            'Domain' = 'Active Directory Domain Diagram'
            'Sites' = 'Active Directory Site Invetory Diagram'
            'SitesTopology' = 'Active Directory Site Topology Diagram'
        }

        $Images = @{
            "Main_Logo" = "Diagrammer.png"
        }

        $IconPath = Join-Path -Path $TestsFolder -ChildPath "Icons"

        $HTMLTableMainLabel = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -ImagesObj $Images
        $HTMLTableMainLabelDraftmode = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -IconDebug $true -ImagesObj $Images

        $HTMLTableSubgraphLabel = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -ImagesObj $Images -SubgraphLabel
        $HTMLTableSubgraphLabelDraftmode = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -IconDebug $true -ImagesObj $Images -SubgraphLabel

        $HTMLTableMainLabelSetImageWxH = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -ImagesObj $Images -IconWidth 300 -IconHeight 300

        $HTMLTableSubgraphLabelSetImageWxH = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -ImagesObj $Images -IconWidth 300 -IconHeight 300 -SubgraphLabel

        $HTMLTableMainLabelSetImagePercent = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -IconPath $IconPath -ImagesObj $Images -ImageSizePercent 70

        $HTMLTableSubgraphLabelSetImagePercent = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -IconPath $IconPath -ImagesObj $Images -ImageSizePercent 70 -SubgraphLabel

        $HTMLTableMainLabelNoIcon = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'NoIcon' -ImagesObj $Images
        $HTMLTableSubgraphLabelNoIcon = Add-DiaHtmlLabel -Label $MainGraphLabel['Forest'] -IconType 'NoIcon' -ImagesObj $Images -SubgraphLabel



    }

    Context "Display Label with Icon" {
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment)" {
            $HTMLTableMainLabel | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Active Directory Forest Diagram</FONT></TD></TR></TABLE>'
        }
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment) in Draftmode" {
            $HTMLTableMainLabelDraftmode | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD></TR><TR><TD bgcolor="#FFCCCC" ALIGN="center" ><FONT FACE="Segoe Ui" Color="#000000" POINT-SIZE="14">Active Directory Forest Diagram</FONT></TD></TR><TR><TD ALIGN="center"><FONT Color="red">DraftMode ON</FONT></TD></TR></TABLE>'
        }
    }
    Context "Display Label with Icon in Subgraph form (fits better in Subgraph)" {
        It "Should return a HTML Table with an Icon at left and a Label text at right (Horizontal Alignment)" {
            $HTMLTableSubgraphLabel | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="center" colspan="1"><img src="Diagrammer.png"/></TD><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Active Directory Forest Diagram</FONT></TD></TR></TABLE>'
        }
        It "Should return a HTML Table with an Icon at left and a Label text at right (Horizontal Alignment) in Draftmode" {
            $HTMLTableSubgraphLabelDraftmode | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD bgcolor="#FFCCCC" ALIGN="center" colspan="1">Diagrammer.png Logo</TD><TD bgcolor="#FFCCCC" ALIGN="Center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Active Directory Forest Diagram</FONT></TD></TR></TABLE>'
        }
    }

    Context "Display Label with Icon with custom Width and Height" {
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment) with custom Icon Width and Height" {
            $HTMLTableMainLabelSetImageWxH | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1" fixedsize="true" width="300" height="300"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Active Directory Forest Diagram</FONT></TD></TR></TABLE>'
        }

        It "Should return a HTML Table with an Icon at left and a Label text at right (Horizontal Alignment) with custom Icon Width and Height" {
            $HTMLTableSubgraphLabelSetImageWxH | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="center" colspan="1" fixedsize="true" width="300" height="300"><img src="Diagrammer.png"/></TD><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Active Directory Forest Diagram</FONT></TD></TR></TABLE>'
        }
    }

    Context "Display Label with Icon with custom Width and Height calculated in Percent of original image size" {
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment) with custom Icon size in Percent" {
            $HTMLTableMainLabelSetImagePercent | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center" colspan="1" fixedsize="true" width="210" height="143.5"><img src="Diagrammer.png"/></TD></TR><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Active Directory Forest Diagram</FONT></TD></TR></TABLE>'
        }

        It "Should return a HTML Table with an Icon at left and a Label text at right (Horizontal Alignment) with custom Icon size in Percent" {
            $HTMLTableSubgraphLabelSetImagePercent | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TR><TD ALIGN="center" colspan="1" fixedsize="true" width="210" height="143.5"><img src="Diagrammer.png"/></TD><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Active Directory Forest Diagram</FONT></TD></TR></TABLE>'
        }
    }


    Context "Display Label without Icon" {
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment)" {
            $HTMLTableMainLabelNoIcon | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="20" cellpadding="10"><TR><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Active Directory Forest Diagram</FONT></TD></TR></TABLE>'
        }
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment) in Draftmode" {
            $HTMLTableSubgraphLabelNoIcon | Should -BeExactly '<TABLE border="0" cellborder="0" cellspacing="5" cellpadding="5"><TD ALIGN="center"><FONT FACE="Segoe Ui" POINT-SIZE="14" COLOR="#000000">Active Directory Forest Diagram</FONT></TD></TR></TABLE>'
        }
    }

}
