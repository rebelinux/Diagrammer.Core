---
comments: true
---

## Description

`Add-DiaNodeIcon` is a cmdlet in the Diagrammer module that allows users to add custom icons to nodes in a diagram. This cmdlet is particularly useful for enhancing the visual representation of diagrams by associating specific icons with different types of nodes.

`Add-DiaNodeIcon` accepts parameters such as the node identifier, the path to the icon file, and optional parameters for customizing the icon's appearance and placement within the diagram.

## Parameters

### Report

Specifies the type of report that will be generated.

This is a mandatory parameter.

### Target

Specifies the IP/FQDN of the system to connect.

Multiple targets may be specified, separated by a comma.

`New-AsBuiltReport -Target system1,system2`

!!! note
    When specifying multiple targets, all systems must use the same credentials.

This is a mandatory parameter.

### Credential

Specifies the stored credential of the target system.

This is a mandatory parameter.

### Username

Specifies the username of the target system.

This is a mandatory parameter.

### Password

Specifies the password of the target system.

This is a mandatory parameter.

### Token
Specifies an API token to authenticate to the target system.

This is an optional parameter.

### MFA
Use multifactor authentication to authenticate to the target system.

This is an optional parameter.

### Format

Specifies the output format of the report.

The supported output formats are Word, HTML & Text.

Multiple output formats may be specified, separated by a comma.

`New-AsBuiltReport -Format HTML,Word,Text`

This is an optional parameter.

If the parameter is not specified, the document format will default to Word.

### Orientation

Sets the page orientation of the report to Portrait or Landscape.

This is an optional parameter.

If the parameter is not specified, page orientation will be set to Portrait.

### StyleFilePath

Specifies the file path to a custom style .ps1 script for the report to use.

This is an optional parameter and does not have a default value.

### OutputFolderPath

Specifies the folder path to save the report.

This is a mandatory parameter.

### AsBuiltConfigFilePath

Specifies the file path to the AsBuiltReport configuration JSON file.

This is an optional parameter.

If this parameter is not specified, the user will be prompted for this configuration information on first run, with the option to save the configuration to a file.

### ReportConfigFilePath

Specifies the file path to a report JSON configuration file.

This is an optional parameter.

If this parameter is not specified, a default report configuration JSON is copied to the specified user folder.

If this parameter is specified and the path to a JSON file is invalid, the script will terminate.

### Timestamp

Specifies whether to append a timestamp string to the report filename.

This is an optional parameter.

By default, the timestamp string is not added to the report filename.

### EnableHealthcheck

Highlights certain issues within the system report.

Some reports may not provide this functionality.

This is an optional parameter.

If the parameter is not specified, health checks are not enabled.

### SendEmail

Sends report to specified recipients as email attachments.

This is an optional parameter.

## Examples

1. Creates an as-built report for a VMware vSphere environment. The report is generated in Word and Text formats and saved to the `C:\Reports` folder. Health checks will be enabled for the report.

    ```powershell title="Example 1"
    New-AsBuiltReport -Report 'VMware.vSphere' -Target 'vcenter.domain.local' `
    -Username 'administrator@vsphere.local' -Password 'VMware1!' `
    -Format 'Word','Text' -OutputFolderPath 'C:\Reports' -EnableHealthCheck
    ```

2. Creates an as-built report for two Pure Storage FlashArrays. The report is generated in HTML format, saved to the `C:\Reports` folder and sent via email.

    ```powershell title="Example 2"
    New-AsBuiltReport -Report 'PureStorage.FlashArray' -Target '192.168.10.100','192.168.10.110' `
    -Credential (Get-Credential) -Format 'HTML' -OutputFolderPath 'C:\Reports' -SendEmail
    ```

3. Creates an as-built report for two VMware ESXi hosts. Authentication to VMware ESXi hosts uses stored credentials. The report is generated in Word (DOCX) format (by default). A customized stylesheet is specified to style the report in the company’s brand colours and fonts. The report is saved to the user’s documents folder with a timestamp appended to the filename to identify when the report was generated. The `AsBuiltConfigFilePath` parameter is specified to bypass the menu driven questionnaire.

    ```powershell title="Example 3"
    New-AsBuiltReport -Report 'VMware.ESXi' -Target 'corp-esxi01','corp-esxi02' `
    -Credential $creds -OutputFolderPath "$env:USERPROFILE\Documents" `
    -StyleFilePath 'C:\AsBuiltReport\MyCompanyStyle.ps1'`
    -AsBuiltConfigFilePath 'C:\AsBuiltReport\MyCompanyConfig.json' -Timestamp
    ```