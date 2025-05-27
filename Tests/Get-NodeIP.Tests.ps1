BeforeAll {
    . $PSScriptRoot\_InitializeTests.ps1
    . $ProjectRoot\SRC\private\Get-NodeIP.ps1
}

Describe Get-NodeIP {
    It "Should return Host IP Address" {
        Get-NodeIP -Hostname localhost | Should -Be '127.0.0.1'
    }
    It "Should return Unknown" {
        Get-NodeIP -Hostname 'invalid-hostname'  | Should -Be 'Unknown'
    }
}