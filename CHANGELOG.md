# :arrows_clockwise: Diagrammer.Core Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.23] - 2025-04-15

### Changed

- Improve temporary output filename generation in Export-Diagrammer function
- Bump version to 0.2.23

## [0.2.22] - 2025-04-11

### Changed

- Refactor code structure for improved readability and maintainability

## [0.2.21] - 2025-04-09

### Added

- Add Get-DiaNodeFiller cmdlet

## [0.2.20] - 2025-04-08

### Added

- Add jpg to supported export format

### Fixed

- Fix Get-DiaNodeIcon cmdlet to honor align parameter

## [0.2.19] - 2025-03-04

### Added

- Add parameter to set Subgraph Label font size
  - Get-DiaHTMLNodeTable
  - Get-DiaHTMLTable

### Fixed

- Fix Get-DiaHTMLNodeTable cmdlet to honor fontsize parameter
- Fix Get-DiaHTMLTable cmdlet to honor fontsize parameter
- Fix Get-DiaHTMLLabel cmdlet to honor fontsize parameter

## [0.2.18] - 2025-03-04

### Fixed

- Fix Get-DiaHTMLNodeTable fontsize error when calling debug mode

## [0.2.16] - 2025-03-03

### Fixed

- Fix Get-DiaHTMLSubGraph cmdlet to honor fontsize parameter

## [0.2.15] - 2025-02-21

### Changed

- Improved cmdlet documentation
- Added Ordered list to the Get-DiaNodeIcon cmdlet

## [0.2.14] - 2025-02-11

### Changed

- Update Graphviz binaries to v12.2.1
- Improved cmdlet documentation

## [0.2.13] - 2024-11-19

### Added

- Add HTMLOutput option to the Convert-DiaTableToHTML cmdlet to allow export of the HTML table

## [0.2.12] - 2024-11-12

### Changed

- Update Graphviz binaries to v12.2.0
- Improve logging

## [0.2.11] - 2024-10-19

### Fixed

- Fix error in cmdlet Get-DiaHtmlSignatureTable

## [0.2.10] - 2024-10-12

### Fixed

- Fix an issue with error handling

## [0.2.9] - 2024-10-05

### Added

- Add option to mimic Graphviz Subgraph
  - Get-DiaHTMLNodeTable
  - Get-DiaHTMLTable
  - Get-DiaHtmlSubGraph
- Add cmdlet to create the Signature table
  - Get-DiaHtmlSignatureTable

### Changed

- Update Graphviz binaries to v12.1.2
- Update modules tests

## [0.2.8] - 2024-09-17

### Added

- Add option to set fontcolor, bgcolor edge color & node fillcolor

### Changed

- Update Graphviz binaries to v12.1.1

## [0.2.7] - 2024-09-12

### Fixed

- Fix Get-NodeIP returning multiple object when there a more than one IP in the DNS record

## [0.2.6] - 2024-09-11

### Fixed

- Fix Get-NodeIP returning an Array Object and not a string

## [0.2.5] - 2024-09-11

### Changed

- Enhance the way EnableErrorDebug option works.

### Fixed

- Removed error with Write-PSCriboMessage module

## [0.2.4] - 2024-09-07

### Added

- Add feature to set per object type icon in Get-DiaHtmlNodeTable module

### Changed

- Improved New-Diagrammer module

## [0.2.3] - 2024-08-31

### Changed

- Update Graphviz binaries to v12.1.0

## [0.2.2] - 2024-07-06

### Changed

- Update Graphviz binaries to v12.0.0


## [0.2.1] - 2024-05-16

### Added

- Improved Get-DiaHTMLTable and Get-DiaNodeIcon cmdlet

## [0.2.0] - 2024-04-29

### Changed

- Updated Graphviz to v11.0

## [0.1.9] - 2024-03-19

### Changed

- Improved Get-DiaHTMLNodeTable function. Close [#14](https://github.com/rebelinux/Diagrammer.Core/issues/14)
  - Allow to add more Information to the Node Object

## [0.1.8] - 2024-03-16

### Added

- Added Add-WatermarkToImage cmdlet to add WaterMark text to resulting diagrams.
- Added per format export function:
  - ConverTo-Base64
  - ConverTo-Png
  - ConverTo-Pdf
  - ConverTo-Dot
- Added function to allow image rotation to 90 degree (ConvertTo-RotateImage)
- Added Initial support for centralized function to create diagram

### Changed

- Renamed Out-Diagram to Export-Diagrammer
- Improved Get-DiaHTMLNodeTable

### Fixed

- [#12](https://github.com/rebelinux/Diagrammer.Core/issues/12)
- [#13](https://github.com/rebelinux/Diagrammer.Core/issues/13)

## [0.1.7] - 2024-02-26

### Added

- Added Resize-image cmdlet

### Changed

- Improved Get-DiaImagePercent module
- Improved Get-DiaHTMLNodeTable to better align MultiColumn Icon
- Improved Get-DiaNodeIcon debug mode

## [0.1.6] - 2024-02-23

### Changed

- Improved Get-DiaImagePercent module

## [0.1.5] - 2024-02-23

### Added

- Added Get-DiaImagePercent module

## [0.1.4] - 2024-02-22

### Changed

- Added PSGraph to the required module

## [0.1.3] - 2024-02-20

### Fixed

- Fix missing Graphviz dll files

## [0.1.2] - 2024-02-20

### Fixed

- Fix PowerShellGallery IconURI
- Module rename due to conflict with ImportExcel

## [0.1.1] - 2024-02-20

### Added

- Migrated common Diagrammer.Microsoft.AD and Veeam.Diagrammer modules:
  - Convert-TableToHTML
  - Get-HtmlLabel
  - Get-HtmlNodeTable
  - Get-HtmlTable
  - Get-NodeIP
  - Get-NodeIcon
  - Out-Diagram
  - Remove-SpecialChar
  - Split-array
  - Test-Image
  - Test-Logo
  - Write-ColorOutput
