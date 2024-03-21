. $PSScriptRoot\_InitializeTests.ps1

BeforeAll {
    $ArrayObj = @(1,2,3,4,5,6,7,8,9)
    $SplitArray = Split-Array -inArray $ArrayObj -Size 3
}

Describe "Split-Array" {
    It "Should returns a object split by size" {
        $SplitArray.Count | Should -BeExactly 3
    }
    It "Should returns 3 Object" {
        $SplitArray[0] | Should -HaveCount 3
    }
    It "Should contain 4 as array member" {
        $SplitArray[1] | Should -Contain 4
    }
}