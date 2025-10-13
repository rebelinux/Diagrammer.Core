<p align="center">
    <a href="https://github.com/rebelinux/Diagrammer.Core" alt="Diagrammer"></a>
            <img src='https://raw.githubusercontent.com/rebelinux/Diagrammer.Core/dev/Icons/Diagrammer.png' width="15%" height="15%" /></a>
</p>
<p align="center">
    <a href="https://www.powershellgallery.com/packages/Diagrammer.Core/" alt="PowerShell Gallery Version">
        <img src="https://img.shields.io/powershellgallery/v/Diagrammer.Core.svg" /></a>
    <a href="https://www.powershellgallery.com/packages/Diagrammer.Core/" alt="PS Gallery Downloads">
        <img src="https://img.shields.io/powershellgallery/dt/Diagrammer.Core.svg" /></a>
    <a href="https://www.powershellgallery.com/packages/Diagrammer.Core/" alt="PS Platform">
        <img src="https://img.shields.io/powershellgallery/p/Diagrammer.Core.svg" /></a>
</p>
<p align="center">
    <a href="https://github.com/rebelinux/Diagrammer.Core/graphs/commit-activity" alt="GitHub Last Commit">
        <img src="https://img.shields.io/github/last-commit/rebelinux/Diagrammer.Core/master.svg" /></a>
    <a href="https://raw.githubusercontent.com/rebelinux/Diagrammer.Core/master/LICENSE" alt="GitHub License">
        <img src="https://img.shields.io/github/license/rebelinux/Diagrammer.Core.svg" /></a>
    <a href="https://github.com/rebelinux/Diagrammer.Core/graphs/contributors" alt="GitHub Contributors">
        <img src="https://img.shields.io/github/contributors/rebelinux/Diagrammer.Core.svg"/></a>
</p>
<p align="center">
    <a href="https://twitter.com/rebelinux" alt="Twitter">
            <img src="https://img.shields.io/twitter/follow/rebelinux.svg?style=social"/></a>
</p>

<p align="center">
    <a href='https://ko-fi.com/F1F8DEV80' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://ko-fi.com/img/githubbutton_sm.svg' border='0' alt='Want to keep alive this project? Support me on Ko-fi' /></a>
</p>

# Diagrammer.Core

Diagrammer.Core is a PowerShell module that provides a foundational framework for creating as-built diagrams of various datacenter systems. It serves as a required dependency for individual diagrammer modules, which generate diagrams tailored to specific products or technologies.

# :beginner: Getting Started

The following simple list of instructions will get you started with the Diagrammer.Core module.

## :floppy_disk: Supported Versions
### **PowerShell**
This module is compatible with the following PowerShell versions;

| Windows PowerShell 5.1 | Windows PowerShell 7 |
| :--------------------: | :------------------: |
|   :white_check_mark:   |  :white_check_mark:  |

## :wrench: System Requirements

PowerShell 5.1, and the following PowerShell modules are required for generating a Diagrammer.Core diagram.

- [PSGraph Module](https://github.com/KevinMarquette/PSGraph)

## :package: Module Installation

### PowerShell
#### Online Installation

For an online installation, install the `Diagrammer.Core` module using the [PowerShell Gallery](https://www.powershellgallery.com/packages?q=Diagrammer.Core);

```powershell
# Install Diagrammer.Core module
Install-Module -Name 'Diagrammer.Core' -Repository 'PSGallery' -Scope 'CurrentUser'
```

#### Offline Installation

For an offline installation, perform the following steps from a machine with internet connectivity;

Save the required `Diagrammer.Core` module to a specified folder.

```powershell
# Save Diagrammer.Core module
Save-Module -Name 'Diagrammer.Core' -Repository 'PSGallery' -Path '<Folder Path>'
```

Copy the downloaded `Diagrammer.Core` module folder to a location that can be made accessible to the offline system.
e.g. USB Flash Drive, Internal File Share etc.

On the offline system, open a PowerShell console window and run the following command to determine the PowerShell module path.

**Windows**

```powershell title=""
$env:PSModulePath -Split ';'
```

Copy the downloaded `Diagrammer.Core` module folder to a folder specified in the `$env:PSModulePath` output.

### **GitHub**
If you are unable to use the PowerShell Gallery, you can still install the `Diagrammer.Core` module manually. Ensure you repeat the following steps for the [system requirements](https://github.com/rebelinux/Diagrammer.Core#wrench-system-requirements) also.

1. Download the [latest release](https://github.com/rebelinux/Diagrammer.Core/releases/latest) zip from GitHub
2. Extract the zip file
3. Copy the folder `Diagrammer.Core` to a path that is set in `$env:PSModulePath`.
4. For Windows users only, open a PowerShell terminal window and unblock the downloaded files with
    ```powershell
    $path = (Get-Module -Name Diagrammer.Core -ListAvailable).ModuleBase; Unblock-File -Path $path\*.psd1; Unblock-File -Path $path\Src\Public\*.ps1
    ```
5. Close and reopen the PowerShell terminal window.

_Note: You are not limited to installing the module to those example paths, you can add a new entry to the environment variable PSModulePath if you want to use another path._


## :books: Documentation

The documentation for the `Diagrammer.Core` module can be found in the [Docs](https://diagrammer.techmyth.blog/).

### :blue_book: Cmdlets Index

All commands in the latest release of Diagrammer.Core can be found in the table below, each with a link to their documentation page.

| Name                                                                                                        | Description                                 | Version |
| ----------------------------------------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| [Add-DiaCrossShapeLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaCrossShapeLine/)         | Adds a line between two cross shapes        | 0.2.31  |
| [Add-DiaNodeIcon](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaNodeIcon/)                     | Adds an icon to a node                      | 0.2.31  |
| [Add-DiaHTMLLabel](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaHTMLLabel/)                   | Adds an HTML label to the diagram           | 0.2.31  |
| [Add-DiaHTMLNodeTable](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaHTMLNodeTable/)           | Adds an HTML node table to the diagram      | 0.2.31  |
| [Add-DiaHtmlSignatureTable](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaHtmlSignatureTable/) | Adds an HTML signature table to the diagram | 0.2.31  |
| [Add-DiaHTMLSubGraph](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaHTMLSubGraph/)             | Adds an HTML subgraph to the diagram        | 0.2.31  |
| [Add-DiaHTMLTable](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaHTMLTable/)                   | Adds an HTML table to the diagram           | 0.2.31  |
| [Add-DiaInvertedLShapeLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaInvertedLShapeLine/) | Adds a line between two inverted L shapes   | 0.2.31  |
| [Add-DiaInvertedTShapeLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaInvertedTShapeLine/) | Adds a line between two inverted T shapes   | 0.2.31  |
| [Add-DiaLeftLShapeLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaLeftLShapeLine/)         | Adds a line between two left L shapes       | 0.2.31  |
| [Add-DiaLeftTShapeLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaLeftTShapeLine/)         | Adds a line between two left T shapes       | 0.2.31  |
| [Add-DiaLShapeLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaLShapeLine/)                 | Adds a line between two L shapes            | 0.2.31  |
| [Add-DiaNodeImage](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaNodeImage/)                   | Adds an image to a node                     | 0.2.31  |
| [Add-DiaNodeShape](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaNodeShape/)                   | Adds a shape to a node                      | 0.2.31  |
| [Add-DiaNodeSpacer](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaNodeSpacer/)                 | Adds a spacer to a node                     | 0.2.31  |
| [Add-DiaRightLShapeLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaRightLShapeLine/)       | Adds a line between two right L shapes      | 0.2.31  |
| [Add-DiaRightTShapeLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaRightTShapeLine/)       | Adds a line between two right T shapes      | 0.2.31  |
| [Add-DiaTShapeLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaTShapeLine/)                 | Adds a line between two T shapes            | 0.2.31  |
| [Add-DiaVerticalLine](https://diagrammer.techmyth.blog/dev-guide/commands/Add-DiaVerticalLine/)             | Adds a vertical line between two nodes      | 0.2.31  |
| [Export-Diagrammer](https://diagrammer.techmyth.blog/dev-guide/commands/Export-Diagrammer/)                 | Exports the diagram to a file               | 0.2.31  |
| [Get-RandomColorHex](https://diagrammer.techmyth.blog/dev-guide/commands/Get-RandomColorHex/)               | Gets a random color in hex format           | 0.2.31  |
| [Get-RandomPastelColorHex](https://diagrammer.techmyth.blog/dev-guide/commands/Get-RandomPastelColorHex/)   | Gets a random pastel color in hex format    | 0.2.31  |
| [New-Diagrammer](https://diagrammer.techmyth.blog/dev-guide/commands/New-Diagrammer/)                       | Creates a new diagram from an input object  | 0.2.31  |

### :blue_book: Example Index

All examples in the latest release of Diagrammer.Core can be found in the table below, each with a link to their documentation page.

| Name                                                                                      | Description                            | Module          |
| ----------------------------------------------------------------------------------------- | -------------------------------------- | --------------- |
| [Example1](https://diagrammer.techmyth.blog/dev-guide/examples/example1/)                 | Node cmdlet                            | PSGraph         |
| [Example2](https://diagrammer.techmyth.blog/dev-guide/examples/example2/)                 | Edge cmdlet                            | PSGraph         |
| [Example3](https://diagrammer.techmyth.blog/dev-guide/examples/example3/)                 | Edge minlen attribute                  | PSGraph         |
| [Example4](https://diagrammer.techmyth.blog/dev-guide/examples/example4/)                 | SubGraph cmdlet                        | PSGraph         |
| [Example5](https://diagrammer.techmyth.blog/dev-guide/examples/example5/)                 | Add-DiaNodeIcon cmdlet                 | Diagrammer.Core |
| [Example6](https://diagrammer.techmyth.blog/dev-guide/examples/example6/)                 | DraftMode feature                      | Diagrammer.Core |
| [Example7](https://diagrammer.techmyth.blog/dev-guide/examples/example7/)                 | Rank cmdlet                            | PSGraph         |
| [Example8](https://diagrammer.techmyth.blog/dev-guide/examples/example8/)                 | Add-DiaHTMLNodeTable cmdlet            | Diagrammer.Core |
| [Example9](https://diagrammer.techmyth.blog/dev-guide/examples/example9/)                 | Add-DiaHTMLNodeTable MultiIcon feature | Diagrammer.Core |
| [Example10](https://diagrammer.techmyth.blog/dev-guide/examples/example10/)               | Add-DiaNodeImage cmdlet                | Diagrammer.Core |
| [Example11](https://diagrammer.techmyth.blog/dev-guide/examples/example11/)               | Add-DiaHTMLTable cmdlet                | Diagrammer.Core |
| [Example12](https://diagrammer.techmyth.blog/dev-guide/examples/example12/)               | WaterMark feature                      | Diagrammer.Core |
| [Example13](https://diagrammer.techmyth.blog/dev-guide/examples/example13/)               | Signature feature                      | Diagrammer.Core |
| [Example14](https://diagrammer.techmyth.blog/dev-guide/examples/example14/)               | Add-DiaNodeShape cmdlet                | Diagrammer.Core |
| [Example15](https://diagrammer.techmyth.blog/dev-guide/examples/example15/)               | Add-DiaNodeSpacer cmdlet               | Diagrammer.Core |
| [AdvancedExample1](https://diagrammer.techmyth.blog/dev-guide/examples/advancedexample1/) | Add-DiaHTMLSubGraph cmdlet             | Diagrammer.Core |

## :x: Known Issues
