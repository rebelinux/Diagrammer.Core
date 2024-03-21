. $PSScriptRoot\_InitializeTests.ps1

BeforeAll {
    $ArrayObj = @(1,2,3,4,5,6,7,8,9)
    $SplitArray = Split-Array -inArray $ArrayObj -Size 3
}

Describe "Split-Array" {
    It "Returns a object split by size" {
        $SplitArray.Count | Should -BeExactly 3
    }
    It "Object SplitArray[0] must returns 3 elements" {
        $SplitArray[0] | Should -HaveCount 3
    }
    It "Object SplitArray[1] must returns 3 elements" {
        $SplitArray[1] | Should -Contain 4
    }
}