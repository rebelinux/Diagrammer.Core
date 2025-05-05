#!/usr/bin/env pwsh
function Write-ColorOutput {
    <#
    .SYNOPSIS
        Colored Write-Output
    .DESCRIPTION
        Produce colored output on the console without compromising the expected Output object type.
        Useful when showing info in the console host while avoiding producing strings in the output Objects.
    .EXAMPLE
        C:\> ls -Force | Write-ColorOutput -f 'Green'
    .EXAMPLE
        Help about_foreach | Write-ColorOutput -f Green -b Black
    .INPUTS
        Parsable Object
    .OUTPUTS
        Default output object type.
    .LINK
        Online version: https://github.com/chadnpc/CliStyler/blob/main/src/scripts/Console/Writers/Write-ColorOutput.ps1
    .NOTES
        #BUG: Some commands don't work! Example:
        $list = foreach ($file in Get-ChildItem) { if ($file.length -gt 100) { $($file | Select-Object Name, @{l = 'Size'; e = { $_.Length } }) } }
        $list | Write-ColorOutput -F Green -B Black
        #BUG This command works:
        Help about_foreach | Write-ColorOutput -f Green -b Black # but,
        Get-Help about_foreach | Write-ColorOutput -f Green -b Black # Doesn't work!
    #>
    [alias('Cecho', 'Out-Pipeline')]
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Name')]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = 'Name')]
        [Alias('f')]
        [ArgumentCompleter({
                [OutputType([System.Management.Automation.CompletionResult])]
                param(
                    [string]$CommandName,
                    [string]$ParameterName,
                    [string]$WordToComplete,
                    [System.Management.Automation.Language.CommandAst]$CommandAst,
                    [System.Collections.IDictionary]$FakeBoundParameters
                )
                $CompletionResults = [System.Collections.Generic.List[System.Management.Automation.CompletionResult]]::new()
                $([ConsoleColor].GetMembers() | Where-Object { $_.MemberType -eq 'Field' -and $null -eq $_.FieldHandle }).Name | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
                    $CompletionResults.Add([System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_))
                }
                return $CompletionResults
            })]
        [string]$ForegroundColor,
        [Parameter(Mandatory = $false, ParameterSetName = 'Name')]
        [Alias('b')]
        [ArgumentCompleter({
                [OutputType([System.Management.Automation.CompletionResult])]
                param(
                    [string]$CommandName,
                    [string]$ParameterName,
                    [string]$WordToComplete,
                    [System.Management.Automation.Language.CommandAst]$CommandAst,
                    [System.Collections.IDictionary]$FakeBoundParameters
                )
                $CompletionResults = [System.Collections.Generic.List[System.Management.Automation.CompletionResult]]::new()
                $([ConsoleColor].GetMembers() | Where-Object { $_.MemberType -eq 'Field' -and $null -eq $_.FieldHandle }).Name | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
                    $CompletionResults.Add([System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_))
                }
                return $CompletionResults
            })]
        [string]$BackgroundColor,
        # Object to write
        [parameter(Mandatory = $false, ParameterSetName = 'Name', valueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ValueFromRemainingArguments = $true)]
        [Alias('i')]
        [Object[]]$InputObject
    )

    begin {
        $fc = $ExecutionContext.Host.UI.RawUI.ForegroundColor
        $bc = $ExecutionContext.Host.UI.RawUI.BackgroundColor
    }
    process {
        $ConsoleColors = $([ConsoleColor].GetMembers() | Where-Object { $_.MemberType -eq 'Field' -and $null -eq $_.FieldHandle }).Name
        try {
            if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey('ForegroundColor')) {
                if ($ForegroundColor -in $ConsoleColors) {
                    if ($PSCmdlet.ShouldProcess("Host.UI", "Set ForegroundColor")) { $ExecutionContext.Host.UI.RawUI.ForegroundColor = $ForegroundColor }
                } else {
                    $PSCmdlet.WriteWarning("$fxn Used Invalid ForegroundColor Parameter.")
                }
            }
            if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey('BackgroundColor')) {
                if ($BackgroundColor -in $ConsoleColors) {
                    if ($PSCmdlet.ShouldProcess("Host.UI", "Set BackgroundColor")) { $ExecutionContext.Host.UI.RawUI.BackgroundColor = $BackgroundColor }
                } else {
                    $PSCmdlet.WriteWarning("$fxn Used Invalid BackgroundColor Parameter.")
                }
            }
            $(if ($PSBoundParameters.Keys.Contains("InputObject")) { $InputObject } else { $input }) | ForEach-Object { Write-Output $_ }
        } catch [System.Management.Automation.SetValueInvocationException] {
            $ErrRecord = New-ErrorRecord -Exception [System.Management.Automation.SetValueInvocationException]::New('Invalid Color Name used. Take a walk, come back, then try using Tab Completion.')
            $PSCmdlet.WriteError($ErrRecord)
        } catch {
            $PSCmdlet.WriteError([System.Management.Automation.ErrorRecord]$_)
        } finally {
            $ExecutionContext.Host.UI.RawUI.ForegroundColor = $fc
            $ExecutionContext.Host.UI.RawUI.BackgroundColor = $bc
        }
    }

    end {}
}