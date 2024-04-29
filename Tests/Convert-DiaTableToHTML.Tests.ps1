BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Convert-DiaTableToHTML.ps1
}

Describe Convert-DiaTableToHTML {
    BeforeAll {
        $Rows = @(
            "<B>Type</B>:Custom <B>Status</B>: Enabled <B>Schedule</B>: Daily"
            "<B>Domain</B> : domain.local <B>Distribution Server</B> : Veeam-VBR"
            "OUs: OU=VeeamWorkStation,DC=domain,DC=local"
        )

        $PassParams = @{
            Label = 'ServerBackup'
            Name = 'ServerBackup'
            Row = $Rows
            HeaderColor = "#005f4b"
            HeaderFontColor = "white"
            BorderColor = "black"
            FontSize = 14
            IconDebug = $false
        }
    }

    It "Should return string type" {
        Convert-DiaTableToHTML @PassParams | Should -BeExactly `""ServerBackup" [shape="none";color="black";fillcolor="white";fontname="Segoe UI";penwidth="1";style="filled";label=<<TABLE CELLBORDER='1' BORDER='0' CELLSPACING='0'><TR><TD bgcolor='#005f4b' align='center'><font color='white'><B>ServerBackup</B></font></TD></TR></TABLE>>;fontsize="14";]`"
    }
    It -Skip "Should return throw" {
        { ConvertTo-Base64 @FailParams } | Should -Throw -ExpectedMessage "Cannot validate argument on parameter 'ImageInput'. File C:\logo.png not found!"
    }
}