# :arrows_clockwise: Diagrammer.Core Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.27] - 2025-05-XX

### Added

- Added new test file Add-DiaNodeFiller.Tests.ps1 to validate Add-DiaNodeFiller functionality
- Introduce a Todo file for future enhancements, including research on creating directional lines in dot graphs
- Add additional tests for Get-NodeIP functionality
- Add Add-DiaHorizontalLine and Add-DiaVerticalLine functions for creating horizontal and vertical lines in diagrams.
- Add ConvertTo-Pdf-WaterMark function to convert images to PDF format using ImageMagick, allowing for watermark insertion.
- Add tests for Add-WatermarkToImage, ConvertTo-Pdf-WaterMark, and other conversion functions to ensure functionality and reliability
- Add new line functions: Cross, Inverted T, T, Horizontal and Vertical line shapes
- Added cleanup logic in Resize-Image tests to remove temporary files after tests.
- Add-DiaRightTShapeLine for various L and  T shaped connectors in diagrams.
- Implemented Add-DiaInvertedLShapeLine, Add-DiaLShapeLine, Add-DiaLeftLShapeLine, Add-DiaLeftTShapeLine, Add-DiaRightLShapeLine
- Add Pester files for some cmdlet to test functionality:
  - Add-DiaVerticalLine


### Changed

- Increment module version to `0.2.27`
- Update function names from Add-DiaHtmlSubGraph to Add-DiaHTMLSubGraph for consistency in Add-DiaHtmlSubGraph.Tests.ps1
- Update test descriptions in Add-DiaNodeIcon.Tests.ps1 to correct spelling and improve clarity
- Update cmdlet verb to better reflect its intended action
- Enhance module with aliases and output types for various functions
- Add diagram line functions, watermarking, and PDF conversion
- Enhance Add-WatermarkToImage function to add watermarks to pdf files, with support for optional parameters.
- Update existing conversion functions (ConvertTo-Dot, ConvertTo-Jpg, ConvertTo-Pdf, ConvertTo-Png) to improve error handling and streamline output.
- Update Graphviz binaries to v13.0.0
- Expanded the Todo list to include new directional line shapes and testing tasks.
- Enhance diagram functions with improved parameterization and debugging options
- Updated Add-DiaLeftTShapeLine, Add-DiaRightLShapeLine, Add-DiaRightTShapeLine, Add-DiaTShapeLine, Add-DiaVerticalLine to include detailed parameter descriptions for
  better usability.
- Refactored DraftMode parameter to enable visual debugging in diagram functions, highlighting nodes and lines in red.
- Refactored node and edge creation logic to accommodate new parameters and improve clarity.
- Improved example usage in documentation for each function to demonstrate customization capabilities.
- Consolidated versioning and author information across all modified scripts for consistency.
- Updated New-Diagrammer to integrate DraftMode for enhanced visualization debugging.
- Completed various TODO items related to directional lines and line length customization.

### Fixed

- Fix spelling errors in test descriptions and update function names for consistency
- Fix isssue in cmdlet Add-DiaHtmlSubGraph pester test
- Fix isssue in cmdlet Get-Add-DiaHTMLNodeTable pester test
- Fix "HMLT" to "HTML" in multiple test descriptions across Add-DiaHtmlSignatureTable.Tests.ps1 and Add-DiaHtmlSubGraph.Tests.ps1


## [0.2.26] - 2025-05-09

### Changed

- Increment module version to `0.2.26`.
- Add new parameters to the `Add-DiaHTMLLabel` and `Add-DiaNodeIcon` functions.
- Update changelog to reflect the latest changes.
- Implement code changes to enhance functionality and improve performance

### Fixed

- Fix issue [#45](https://github.com/rebelinux/Diagrammer.Core/issues/45)

## [0.2.25] - 2025-05-04

### Changed

- Enable `ValueFromPipeline` support in the `Write-ColorOutput` cmdlet.
- Update version to `0.2.25`.
- Refine verbose messages in the `Add-WatermarkToImage` and `Export-Diagrammer` functions for improved clarity.
- Enhance font size calculation in the `Add-WatermarkToImage` cmdlet for scenarios where no size is specified.
- Refactor verbose output messages to use -Message parameter for consistency across functions

### Fixed

- Resolve an issue where watermarks were not being generated in base64 format.

## [0.2.24] - 2025-04-18

### Added

- Add parameters to Add-DiaNodeFiller for icon direction and image handling

### Changed

- Improve temporary output filename generation in Export-Diagrammer function
- Bump version to 0.2.24
- Enhance SuppressMessage attributes in New-Diagrammer function

## [0.2.23] - 2025-04-15

### Changed

- Improve temporary output filename generation in Export-Diagrammer function
- Bump version to 0.2.23

## [0.2.22] - 2025-04-11

### Changed

- Refactor code structure for improved readability and maintainability

## [0.2.21] - 2025-04-09

### Added

- Add Add-DiaNodeFiller cmdlet

## [0.2.20] - 2025-04-08

### Added

- Add jpg to supported export format

### Fixed

- Fix Add-DiaNodeIcon cmdlet to honor align parameter

## [0.2.19] - 2025-03-04

### Added

- Add parameter to set Subgraph Label font size
  - Add-DiaHTMLNodeTable
  - Add-DiaHTMLTable

### Fixed

- Fix Add-DiaHTMLNodeTable cmdlet to honor fontsize parameter
- Fix Add-DiaHTMLTable cmdlet to honor fontsize parameter
- Fix Add-DiaHTMLLabel cmdlet to honor fontsize parameter

## [0.2.18] - 2025-03-04

### Fixed

- Fix Add-DiaHTMLNodeTable fontsize error when calling debug mode

## [0.2.16] - 2025-03-03

### Fixed

- Fix Add-DiaHTMLSubGraph cmdlet to honor fontsize parameter

## [0.2.15] - 2025-02-21

### Changed

- Improved cmdlet documentation
- Added Ordered list to the Add-DiaNodeIcon cmdlet

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

- Fix error in cmdlet Add-DiaHtmlSignatureTable

## [0.2.10] - 2024-10-12

### Fixed

- Fix an issue with error handling

## [0.2.9] - 2024-10-05

### Added

- Add option to mimic Graphviz Subgraph
  - Add-DiaHTMLNodeTable
  - Add-DiaHTMLTable
  - Add-DiaHtmlSubGraph
- Add cmdlet to create the Signature table
  - Add-DiaHtmlSignatureTable

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

- Add feature to set per object type icon in Add-DiaHtmlNodeTable module

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

- Improved Add-DiaHTMLTable and Add-DiaNodeIcon cmdlet

## [0.2.0] - 2024-04-29

### Changed

- Updated Graphviz to v11.0

## [0.1.9] - 2024-03-19

### Changed

- Improved Add-DiaHTMLNodeTable function. Close [#14](https://github.com/rebelinux/Diagrammer.Core/issues/14)
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
- Improved Add-DiaHTMLNodeTable

### Fixed

- [#12](https://github.com/rebelinux/Diagrammer.Core/issues/12)
- [#13](https://github.com/rebelinux/Diagrammer.Core/issues/13)

## [0.1.7] - 2024-02-26

### Added

- Added Resize-image cmdlet

### Changed

- Improved Get-DiaImagePercent module
- Improved Add-DiaHTMLNodeTable to better align MultiColumn Icon
- Improved Add-DiaNodeIcon debug mode

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
