BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath '_InitializeTests.ps1')
    . (Join-Path -Path $PrivateFolder -ChildPath 'Split-Array.ps1')
}

Describe Split-Array {
    BeforeAll {
        $ArrayObj = @(1, 2, 3, 4, 5, 6, 7, 8, 9)
        $SplitArray = Split-Array -inArray $ArrayObj -size 3
    }

    It 'Should return a object split by size' {
        $SplitArray.Count | Should -BeExactly 3
    }
    It 'Should return 3 Object' {
        $SplitArray[0] | Should -HaveCount 3
    }
    It 'Should contain 4 as array member' {
        $SplitArray[1] | Should -Contain 4
    }
}