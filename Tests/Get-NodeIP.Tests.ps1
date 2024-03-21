. $PSScriptRoot\_InitializeTests.ps1

Describe "Get-NodeIP" {
    It "Should returns Host IP Address" {
        Get-NodeIP -Hostname localhost | Should -Be '127.0.0.1'
    }
}