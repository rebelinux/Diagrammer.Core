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
    <a href='https://ko-fi.com/F1F8DEV80' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
</p>

# Diagrammer.Core

Diagrammer.Core is a PowerShell module which provides the core framework for generating as built diagrams for many common datacenter systems. The Diagrammer.Core module is required by each individual diagrammer module used to generate as built diagrams for a specific product and/or technology.

# :beginner: Getting Started

The following simple list of instructions will get you started with the Diagrammer.Core module.

## :floppy_disk: Supported Versions
### **PowerShell**
This module is compatible with the following PowerShell versions;

| Windows PowerShell 5.1 |    PowerShell 7    |
| :--------------------: | :----------------: |
|   :white_check_mark:   | :white_check_mark: |

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

**macOS & Linux**

```powershell title=""
$env:PSModulePath -Split ':'
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

## :x: Known Issues
