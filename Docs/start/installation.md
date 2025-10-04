---
comments: true
hide:
  - toc
---

# :beginner: Getting Started

## :wrench: System Requirements

PowerShell 5.1/7, and the following PowerShell module is required for generating a Diagrammer.Core diagram.

- [PSGraph Module](https://github.com/KevinMarquette/PSGraph){:target="_blank"}

## :package: Installation

### :fontawesome-solid-users: All users

```powershell
Install-Module -Name 'Diagrammer.Core' -Repository 'PSGallery'
```

1. Requires Administrator privileges and installs the module to the C:\Program Files\WindowsPowerShell\Modules directory.


### :fontawesome-solid-user: Current user

```powershell
Install-Module -Name 'Diagrammer.Core' -Repository 'PSGallery' -Scope 'CurrentUser'
```

1. Installs the module to Documents\WindowsPowerShell\Modules for the current user.

#### :material-wrench: Manual Installation

For an offline installation, perform the following steps from a machine with internet connectivity;

Save the required `Diagrammer.Core` module to a specified folder.

```powershell title="Save Diagrammer.Core module"
Save-Module -Name 'Diagrammer.Core' -Repository 'PSGallery' -Path '<Folder Path>'
```

Copy the downloaded `Diagrammer.Core` module folder to a location that can be made accessible to the offline system.
e.g. USB Flash Drive, Internal File Share etc.

On the offline system, open a PowerShell console window and run the following command to determine the PowerShell module path.

```powershell title=":material-powershell: Windows"
$env:PSModulePath -Split ';'
```

Copy the downloaded `Diagrammer.Core` module folder to a folder specified in the `$env:PSModulePath` output.

#### :material-github: GitHub
If you are unable to use the PowerShell Gallery, you can still install the `Diagrammer.Core` module manually. Ensure you repeat the following steps for the **system requirements** also.

1. Download the [latest release](https://github.com/rebelinux/Diagrammer.Core/releases/latest){:target="_blank"} zip from GitHub
2. Extract the zip file
3. Copy the folder `Diagrammer.Core` to a path that is set in `$env:PSModulePath`.
4. For Windows users only, open a PowerShell terminal window and unblock the downloaded files with
    ```powershell titlePS /home/rebelinux/>
="Unblock Diagrammer.Core module files"
    $path = (Get-Module -Name Diagrammer.Core -ListAvailable).ModuleBase; Unblock-File -Path $path\*.psd1; Unblock-File -Path $path\Src\Public\*.ps1
    ```
1. Close and reopen the PowerShell terminal window.

!!! note
    You are not limited to installing the module to those example paths, you can add a new entry to the environment variable PSModulePath if you want to use another path._

## :rocket: Usage

There are over 30 commands in this module and a wide variety of tasks you may like to automate. Here are a few commands to help get you [started](../start/introduction.md). See the [command index](../dev-guide/commands/commands.md) for a list of available commands, or run **`Get-Command -Module Diagrammer.Core`** to show a list of commands in your PowerShell terminal.

```powershell title="Get-Command -Module Diagrammer.Core"
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Add-DiaCrossShapeLine                              0.2.31     Diagrammer.Core
Function        Add-DiaHorizontalLine                              0.2.31     Diagrammer.Core
Function        Add-DiaHTMLLabel                                   0.2.31     Diagrammer.Core
Function        Add-DiaHTMLNodeTable                               0.2.31     Diagrammer.Core
Function        Add-DiaHtmlSignatureTable                          0.2.31     Diagrammer.Core
Function        Add-DiaHTMLSubGraph                                0.2.31     Diagrammer.Core
Function        Add-DiaHTMLTable                                   0.2.31     Diagrammer.Core
Function        Add-DiaInvertedLShapeLine                          0.2.31     Diagrammer.Core
Function        Add-DiaInvertedTShapeLine                          0.2.31     Diagrammer.Core
Function        Add-DiaLeftLShapeLine                              0.2.31     Diagrammer.Core
Function        Add-DiaLeftTShapeLine                              0.2.31     Diagrammer.Core
Function        Add-DiaLShapeLine                                  0.2.31     Diagrammer.Core
Function        Add-DiaNodeIcon                                    0.2.31     Diagrammer.Core
Function        Add-DiaNodeImage                                   0.2.31     Diagrammer.Core
Function        Add-DiaNodeShape                                   0.2.31     Diagrammer.Core
Function        Add-DiaNodeSpacer                                  0.2.31     Diagrammer.Core
Function        Add-DiaRightLShapeLine                             0.2.31     Diagrammer.Core
Function        Add-DiaRightTShapeLine                             0.2.31     Diagrammer.Core
Function        Add-DiaTShapeLine                                  0.2.31     Diagrammer.Core
Function        Add-DiaVerticalLine                                0.2.31     Diagrammer.Core
Function        Convert-DiaTableToHTML                             0.2.31     Diagrammer.Core
Function        Export-Diagrammer                                  0.2.31     Diagrammer.Core
Function        Get-DiaImagePercent                                0.2.31     Diagrammer.Core
Function        Get-NodeIP                                         0.2.31     Diagrammer.Core
Function        Get-RandomColorHex                                 0.2.31     Diagrammer.Core
Function        Get-RandomPastelColorHex                           0.2.31     Diagrammer.Core
Function        Group-Node                                         0.2.31     Diagrammer.Core
Function        New-Diagrammer                                     0.2.31     Diagrammer.Core
Function        Remove-SpecialChar                                 0.2.31     Diagrammer.Core
Function        Split-Array                                        0.2.31     Diagrammer.Core
Function        Test-Image                                         0.2.31     Diagrammer.Core
Function        Test-Logo                                          0.2.31     Diagrammer.Core
Function        Write-ColorOutput                                  0.2.31     Diagrammer.Core
Function        Write-PSObject                                     0.2.31     Diagrammer.Core
```

## :x: Known Issues

- Unknown at this time but please report any issues you may find in the [GitHub Issues](https://github.com/rebelinux/Diagrammer.Core/issues){:target="_blank"} page.
