BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Get-DiaHTMLLabel.ps1
}

Describe Get-DiaHTMLLabel {
    BeforeAll {
        $MainGraphLabel = @{
            'Forest' = 'Active Directory Forest Diagram'
            'Domain' = 'Active Directory Domain Diagram'
            'Sites' = 'Active Directory Site Invetory Diagram'
            'SitesTopology' = 'Active Directory Site Topology Diagram'
        }
        $Images = @{
            "Main_Logo" = "Diagrammer.png"
            "DomainController" = "AD_DC.png"
        }
        $HTMLTableMainLabel = Get-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'DomainController' -IconDebug $false -ImagesObj $Images
        $HTMLTableSubgraphLabel = Get-DiaHTMLLabel -Label $MainGraphLabel['Forest'] -IconType 'DomainController' -IconDebug $false -ImagesObj $Images -SubgraphLabel

    }

    It "Should return a HTML Table with an Icon at Top and a Label text at bottom (Vertical Alignment)" {
        $HTMLTableMainLabel | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='20' cellpadding='10'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='40' height='40'><img src='AD_DC.png'/></TD></TR><TR><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
    }
    It "Should return a HTML Table with an Icon at left and a Label text at right (Horizontal Alignment)" {
        $HTMLTableSubgraphLabel | Should -BeExactly "<TABLE border='0' cellborder='0' cellspacing='5' cellpadding='5'><TR><TD ALIGN='center' colspan='1' fixedsize='true' width='40' height='40'><img src='AD_DC.png'/></TD><TD ALIGN='center'><FONT FACE='Segoe Ui Black' Color='#565656' POINT-SIZE='14'>Active Directory Forest Diagram</FONT></TD></TR></TABLE>"
    }
}