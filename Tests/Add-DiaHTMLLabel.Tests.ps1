BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Add-DiaHTMLLabel.ps1')
}

Describe Add-DiaHTMLLabel {
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

        $HTMLTableMainLabel = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -ImagesObj $Images
        $HTMLTableMainLabelDraftmode = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -IconDebug $true -ImagesObj $Images

        $HTMLTableSubgraphLabel = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -ImagesObj $Images -SubgraphLabel
        $HTMLTableSubgraphLabelDraftmode = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -IconDebug $true -ImagesObj $Images -SubgraphLabel

        $HTMLTableMainLabelSetImageWxH = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -ImagesObj $Images -IconWidth 300 -IconHeight 300

        $HTMLTableSubgraphLabelSetImageWxH = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -ImagesObj $Images -IconWidth 300 -IconHeight 300 -SubgraphLabel

        $HTMLTableMainLabelSetImagePercent = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -IconPath $IconPath -ImagesObj $Images -ImageSizePercent 30

        $HTMLTableSubgraphLabelSetImagePercent = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'Main_Logo' -IconPath $IconPath -ImagesObj $Images -ImageSizePercent 30 -SubgraphLabel

        $HTMLTableMainLabelNoIcon = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'NoIcon' -ImagesObj $Images
        $HTMLTableSubgraphLabelNoIcon = Add-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'NoIcon' -ImagesObj $Images -SubgraphLabel



    }

    Context "Display Label with Icon" {
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment)" {
            $HTMLTableMainLabel | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
        }
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment) in Draftmode" {
            $HTMLTableMainLabelDraftmode | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='20'><TR><TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'>Main Logo</TD></TR><TR><TD bgcolor='#FFCCCC' ALIGN='center' ><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR><TR><TD ALIGN='center'><font color='red'>Debug ON</font></TD></TR></TABLE>"
        }
    }
    Context "Display Label with Icon in Subgraph form (fits better in Subgraph)" {
        It "Should return a HTML Table with an Icon at left and a Label text at right (Horizontal Alignment)" {
            $HTMLTableSubgraphLabel | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='center' colspan='1'><img src='Diagrammer.png'/></TD><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
        }
        It "Should return a HTML Table with an Icon at left and a Label text at right (Horizontal Alignment) in Draftmode" {
            $HTMLTableSubgraphLabelDraftmode | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='20'><TR><TD bgcolor='#FFCCCC' ALIGN='center' colspan='1'>Subgraph Logo</TD><TD bgcolor='#FFCCCC' ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
        }
    }

    Context "Display Label with Icon with custom Width and Height" {
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment) with custom Icon Width and Height" {
            $HTMLTableMainLabelSetImageWxH | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='300' height='300'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
        }

        It "Should return a HTML Table with an Icon at left and a Label text at right (Horizontal Alignment) with custom Icon Width and Height" {
            $HTMLTableSubgraphLabelSetImageWxH | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='300' height='300'><img src='Diagrammer.png'/></TD><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
        }
    }

    Context "Display Label with Icon with custom Width and Height calculated in Percent of original image size" {
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment) with custom Icon size in Percent" {
            $HTMLTableMainLabelSetImagePercent | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='30' height='24.6'><img src='Diagrammer.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
        }

        It "Should return a HTML Table with an Icon at left and a Label text at right (Horizontal Alignment) with custom Icon size in Percent" {
            $HTMLTableSubgraphLabelSetImagePercent | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='30' height='24.6'><img src='Diagrammer.png'/></TD><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
        }
    }


    Context "Display Label without Icon" {
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment)" {
            $HTMLTableMainLabelNoIcon | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='20'><TR><TD ALIGN='center' ><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
        }
        It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment) in Draftmode" {
            $HTMLTableSubgraphLabelNoIcon | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='20'><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
        }
    }

}
