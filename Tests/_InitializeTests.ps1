$Script:ModuleName = 'Diagrammer.Core.psd1'
$Script:TestsFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$Script:ProjectRoot = Split-Path -Parent $TestsFolder
$Script:ModuleRoot = Join-Path $ProjectRoot $ModuleName
$Script:ModuleManifestPath = Join-Path $Script:ModuleRoot ('{0}.psd1' -f $Script:ModuleName)

$Script:PrivateFolder = Join-Path -Path $ProjectRoot -ChildPath ('Src{0}Private' -f [System.IO.Path]::DirectorySeparatorChar)

$Script:GraphvizPath = Join-Path $ProjectRoot 'Graphviz\bin\dot.exe'

if (-not (Get-Module $ModuleName)) {
    Import-Module $ModuleRoot -Force
}