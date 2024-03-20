$Global:ModuleName = 'Diagrammer.Core.psd1'
$Global:TestsFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$Global:ProjectRoot = Split-Path -Parent $TestsFolder
$Global:ModuleRoot = Join-Path $ProjectRoot $ModuleName
$Global:ModuleManifestPath = Join-Path $Global:ModuleRoot ('{0}.psd1' -f $Global:ModuleName)

if(!(Get-Module $ModuleName)){
	Import-Module $ModuleRoot -Force
}