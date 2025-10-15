```powershell
$PesterConfig = New-PesterConfiguration
$PesterConfig.TestResult.OutputFormat = "NUnitXml"
$PesterConfig.TestResult.OutputPath = "Test.xml"
$PesterConfig.TestResult.Enabled = $True
Invoke-Pester -Configuration $PesterConfig

[xml]$xmlContent = Get-Content -Path .\Test.xml

$xmlContent.'test-results'.'test-suite'.results.'test-suite'.results.'test-suite' | Where-Object {$_.Name -eq 'Remove-SpecialChar'}

$A = $xmlContent.'test-results'.'test-suite'.results.'test-suite'.results.'test-suite' | Where-Object {$_.Name -eq 'Remove-SpecialChar'}

$A.results.'test-case'

description : Should return string without SpecialChar
name        : Remove-SpecialChar.Should return string without SpecialChar
time        : 0.0149
asserts     : 0
success     : True
result      : Success
executed    : True
```