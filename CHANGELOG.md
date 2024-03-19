# :arrows_clockwise: Diagrammer.Core Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
