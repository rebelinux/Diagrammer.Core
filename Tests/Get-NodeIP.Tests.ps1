Describe "Get-NodeIP" {
    It "Returns 127.0.0.1" {
        Get-NodeIP -Hostname localhost | Should -Be '127.0.0.1'
    }
}