<p align="center">
    <a href="https://github.com/rebelinux/Diagrammer.Core" alt="Diagrammer"></a>
            <img src='https://raw.githubusercontent.com/rebelinux/Diagrammer.Core/dev/Icons/Diagrammer.png' width="8%" height="8%" /></a>
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
    <a href='https://ko-fi.com/B0B7DDGZ7' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
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

The following PowerShell module will be automatically installed by following the [module installation](https://github.com/rebelinux/Diagrammer.Core#package-module-installation) procedure.

This PowerShell module may also be manually installed via the PowerShell Gallery or GitHub.

| Module Name | Minimum Required Version |                         PS Gallery                         |                           GitHub                            |
| ----------- | :----------------------: | :--------------------------------------------------------: | :---------------------------------------------------------: |
| PScribo     |          0.10.0          | [Link](https://www.powershellgallery.com/packages/PScribo) | [Link](https://github.com/iainbrighton/PScribo/tree/master) |

To find a list of available report modules, run the following PowerShell command;

```powershell
Find-Module -Name rebelinux.* -Repository PSGallery
```

The pre-requisites for each report type will be documented within its own `README.md` located in the relevant report repository.

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

## :pencil2: Commands

### **New-rebelinux**

The `New-rebelinux` cmdlet is used to generate as built reports. The type of as built report to generate is specified by using the `Report` parameter. The report parameter relies on additional report modules being installed alongside the `Diagrammer.Core` module. The `Target` parameter specifies one or more systems on which to connect and run the report. User credentials to the system are specified using the `Credential`, or the `Username` and `Password` parameters. One or more document formats, such as `HTML`, `Word` or `Text` can be specified using the `Format` parameter. Additional parameters are outlined below.

```powershell
.PARAMETER Report
    Specifies the type of report that will be generated.
.PARAMETER Target
    Specifies the IP/FQDN of the system to connect.
    Multiple targets may be specified, separated by a comma.
.PARAMETER Credential
    Specifies the stored credential of the target system.
.PARAMETER Username
    Specifies the username for the target system.
.PARAMETER Password
    Specifies the password for the target system.
.PARAMETER Token
    Specifies an API token to authenticate to the target system.
.PARAMETER MFA
    Use multifactor authentication to authenticate to the target system.
.PARAMETER Format
    Specifies the output format of the report.
    The supported output formats are WORD, HTML & TEXT.
    Multiple output formats may be specified, separated by a comma.
.PARAMETER Orientation
    Sets the page orientation of the report to Portrait or Landscape.
    By default, page orientation will be set to Portrait.
.PARAMETER StyleFilePath
    Specifies the file path to a custom style .ps1 script for the report to use.
.PARAMETER OutputFolderPath
    Specifies the folder path to save the report.
.PARAMETER Filename
    Specifies a filename for the report.
.PARAMETER Timestamp
    Specifies whether to append a timestamp string to the report filename.
    By default, the timestamp string is not added to the report filename.
.PARAMETER EnableHealthCheck
    Performs a health check of the target environment and highlights known issues within the report.
    Not all reports may provide this functionality.
.PARAMETER SendEmail
    Sends report to specified recipients as email attachments.
.PARAMETER AsBuiltConfigFilePath
    Enter the full path to the As Built Report configuration JSON file.
    If this parameter is not specified, the user will be prompted for this configuration information on first
    run, with the option to save the configuration to a file.
.PARAMETER ReportConfigFilePath
    Enter the full path to a report JSON configuration file.
    If this parameter is not specified, a default report configuration JSON is copied to the specified user folder.
    If this parameter is specified and the path to a JSON file is invalid, the script will terminate
```

For a full list of common parameters and examples you can view the `New-rebelinux` cmdlet help with the following command;

```powershell
Get-Help New-rebelinux -Full
```

## :x: Known Issues
