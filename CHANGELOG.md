# :arrows_clockwise: Diagrammer.Core Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [vNext] - Unreleased

### :fontawesome-solid-add: Added

- Add AdvancedExample01.ps1 to demonstrate the use of Add-DiaHTMLSubGraph cmdlet
- Add TableBackgroundColor parameter to Add-DiaHTMLSubGraph cmdlet
- Add Dependabot support for GitHub Actions and PowerShell modules
- Add tests for Add-DiaHTMLSubGraph with custom TableBackgroundColor and update existing test cases
- Add Graphviz support and update documentation
- Install mkdocs-graphviz as a dependency in the workflow.
- Create Dependencies.md to outline essential dependencies for PSGraph.

### :arrows_clockwise: Changed

- Update index.md with additional content for clarity.
- Modify mkdocs.yml to include Graphviz in markdown extensions and extra JavaScript.
- Update Graphviz binaries to v14.0.1

### :bug: Fixed

- Fix regex pattern in New-Diagrammer function to correctly match graph object labels for export
- Fix issue with Graphviz v14.0.0 not rendering edges correctly by updating to version v14.0.1

## [0.2.30] - 2025-09-18

### :fontawesome-solid-add: Added

- Add examples for creating 3-tier web application diagrams using Diagrammer module
  - Create Example01.ps1 demonstrating a basic 3-tier web application diagram without object icons.
  - Create Example02.ps1 to illustrate connecting nodes and showing relationships in the diagram.
  - Create Example03.ps1 featuring a clustered representation of servers using SubGraph.
  - Create Example04.ps1 to enhance diagrams with icons and additional server information.
  - Create Example05.ps1 to add icons and additional information to Node objects.
  - Create Example06.ps1 to enable DraftMode for easier troubleshooting and layout adjustments
  - Create Example07.ps1 to demonstrate the use of the Rank.
  - Create Example08.ps1 to demonstrate Add-DiaHTMLNodeTable feature
  - Create Example09.ps1 to demonstrate Add-DiaHTMLNodeTable with MultiIcon feature
  - Create Example10.ps1 to demonstrate the use of the Add-DiaNodeImage cmdlet
  - Create Example11.ps1 to demonstrate the use of the Add-DiaHTMLTable cmdlet
  - Create Example12.ps1 to demonstrate the use of the WaterMark feature
  - Create Example13.ps1 to demonstrate the use of the Signature feature (Add-DiaHtmlSignatureTable)
  - Create Example14.ps1 to demonstrate the use of the Custom shapes feature (Add-DiaNodeShape)
  - Create Example15.ps1 to demonstrate the use of Add-DiaNodeSpacer cmdlet
- Add multiple icon files for use in tests.
- Update New-Diagrammer.ps1 to support image resolution size and improved icon handling.
- Enhance Add-DiaNodeIcon and related functions to support additional font styling options.
- Update documentation in Todo.md to include new examples and tasks.
- Introduce a new PowerShell function, Add-DiaNodeImage, to generate an HTML table for displaying
  images with customizable properties such as border, style, and image size.
- Add Join-Hashtable function for merging hashtables
- Introduce the Add-DiaNodeSpacer function for creating spacer nodes.
  - Add comprehensive tests for new and modified functions.

### :arrows_clockwise: Changed

- Enhance function to set cell background color for Icon/SubGraph Icon table rows in Draftmode
  - Add-DiaNodeIcon
  - Add-DiaHTMLNodeTable
- Update all workflow files to use windows-latest
- Update module manifest
- Enhance Add-DiaHTMLTable with NodeObject support;
- Refactor Split-Array function name
- Update main project icon (Thanks to Copilot)
- Enhance Add-DiaHTMLLabel function with new IconPath parameter and improve image handling
  - Update tests to cover new functionality and adjust existing test cases.
- Enhance Export-Diagrammer.ps1 and New-Diagrammer.ps1 to support watermark font opacity.
- Update ImageMagick v7.1.2-3
- Refactor the Add-DiaHtmlSignatureTable function to improve documentation and parameter descriptions.
- Update the Join-Hashtable function to handle null hashtables.

### :bug: Fixed

- Fix expected output for tests related to HTML tables with logos and labels.
- Fix consistency in the HTML structure for both top and bottom logo placements.
- Fix test cases to reflect the correct HTML output for better validation.
- Fix HTML table output by bolding cell content in Add-DiaHTMLNodeTable function

### :fontawesome-solid-trash: Removed

- Removed the deprecated Add-DiaNodeFiller function.

## [0.2.29] - 2025-08-18

### :fontawesome-solid-add: Added

- Add Get-RandomColorHex cmdlet and pester tests
- Add Get-RandomPastelColorHex cmdlet and pester tests
- Enhanced functions to support optional table and cell background colors.
  - Add-DiaHTMLNodeTable
  - Add-DiaNodeIcon

### :arrows_clockwise: Changed

- Update Graphviz binaries to v13.1.2
- Updated all workflow files to use actions/checkout@v5.

## [0.2.28] - 2025-07-28

### :arrows_clockwise: Changed

- Update Graphviz binaries to v13.1.1
- Update ImageMagick binaries to v7.1.2

## [0.2.27] - 2025-07-23

### :fontawesome-solid-add: Added

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
  - ConvertTo-RotateImage


### :arrows_clockwise: Changed

- Increment module version to `0.2.27`
- Update function names from Add-DiaHtmlSubGraph to Add-DiaHTMLSubGraph for consistency in Add-DiaHtmlSubGraph.Tests.ps1
- Update test descriptions in Add-DiaNodeIcon.Tests.ps1 to correct spelling and improve clarity
- Update cmdlet verb to better reflect its intended action
- Enhance module with aliases and output types for various functions
- Add diagram line functions, watermarking, and PDF conversion
- Enhance Add-WatermarkToImage function to add watermarks to pdf files, with support for optional parameters.
- Update existing conversion functions (ConvertTo-Dot, ConvertTo-Jpg, ConvertTo-Pdf, ConvertTo-Png) to improve error handling and streamline output.
- Update Graphviz binaries to v13.0.1
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
- Enhance ConvertTo-RotateImage function with detailed documentation.

### :bug: Fixed

- Fix spelling errors in test descriptions and update function names for consistency
- Fix isssue in cmdlet Add-DiaHtmlSubGraph pester test
- Fix isssue in cmdlet Get-Add-DiaHTMLNodeTable pester test
- Fix "HMLT" to "HTML" in multiple test descriptions across Add-DiaHtmlSignatureTable.Tests.ps1 and Add-DiaHtmlSubGraph.Tests.ps1
- Fix rotation angle handling in ConvertTo-Svg function


## [0.2.26] - 2025-05-09

### :arrows_clockwise: Changed

- Increment module version to `0.2.26`.
- Add new parameters to the `Add-DiaHTMLLabel` and `Add-DiaNodeIcon` functions.
- Update changelog to reflect the latest changes.
- Implement code changes to enhance functionality and improve performance

### :bug: Fixed

- Fix issue [#45](https://github.com/rebelinux/Diagrammer.Core/issues/45)

## [0.2.25] - 2025-05-04

### :arrows_clockwise: Changed

- Enable `ValueFromPipeline` support in the `Write-ColorOutput` cmdlet.
- Update version to `0.2.25`.
- Refine verbose messages in the `Add-WatermarkToImage` and `Export-Diagrammer` functions for improved clarity.
- Enhance font size calculation in the `Add-WatermarkToImage` cmdlet for scenarios where no size is specified.
- Refactor verbose output messages to use -Message parameter for consistency across functions

### :bug: Fixed

- Resolve an issue where watermarks were not being generated in base64 format.

## [0.2.24] - 2025-04-18

### :fontawesome-solid-add: Added

- Add parameters to Add-DiaNodeFiller for icon direction and image handling

### :arrows_clockwise: Changed

- Improve temporary output filename generation in Export-Diagrammer function
- Bump version to 0.2.24
- Enhance SuppressMessage attributes in New-Diagrammer function

## [0.2.23] - 2025-04-15

### :arrows_clockwise: Changed

- Improve temporary output filename generation in Export-Diagrammer function
- Bump version to 0.2.23

## [0.2.22] - 2025-04-11

### :arrows_clockwise: Changed

- Refactor code structure for improved readability and maintainability

## [0.2.21] - 2025-04-09

### :fontawesome-solid-add: Added

- Add Add-DiaNodeFiller cmdlet

## [0.2.20] - 2025-04-08

### :fontawesome-solid-add: Added

- Add jpg to supported export format

### :bug: Fixed

- Fix Add-DiaNodeIcon cmdlet to honor align parameter

## [0.2.19] - 2025-03-04

### :fontawesome-solid-add: Added

- Add parameter to set Subgraph Label font size
  - Add-DiaHTMLNodeTable
  - Add-DiaHTMLTable

### :bug: Fixed

- Fix Add-DiaHTMLNodeTable cmdlet to honor fontsize parameter
- Fix Add-DiaHTMLTable cmdlet to honor fontsize parameter
- Fix Add-DiaHTMLLabel cmdlet to honor fontsize parameter

## [0.2.18] - 2025-03-04

### :bug: Fixed

- Fix Add-DiaHTMLNodeTable fontsize error when calling debug mode

## [0.2.16] - 2025-03-03

### :bug: Fixed

- Fix Add-DiaHTMLSubGraph cmdlet to honor fontsize parameter

## [0.2.15] - 2025-02-21

### :arrows_clockwise: Changed

- Improved cmdlet documentation
- Added Ordered list to the Add-DiaNodeIcon cmdlet

## [0.2.14] - 2025-02-11

### :arrows_clockwise: Changed

- Update Graphviz binaries to v12.2.1
- Improved cmdlet documentation

## [0.2.13] - 2024-11-19

### :fontawesome-solid-add: Added

- Add HTMLOutput option to the Convert-DiaTableToHTML cmdlet to allow export of the HTML table

## [0.2.12] - 2024-11-12

### :arrows_clockwise: Changed

- Update Graphviz binaries to v12.2.0
- Improve logging

## [0.2.11] - 2024-10-19

### :bug: Fixed

- Fix error in cmdlet Add-DiaHtmlSignatureTable

## [0.2.10] - 2024-10-12

### :bug: Fixed

- Fix an issue with error handling

## [0.2.9] - 2024-10-05

### :fontawesome-solid-add: Added

- Add option to mimic Graphviz Subgraph
  - Add-DiaHTMLNodeTable
  - Add-DiaHTMLTable
  - Add-DiaHtmlSubGraph
- Add cmdlet to create the Signature table
  - Add-DiaHtmlSignatureTable

### :arrows_clockwise: Changed

- Update Graphviz binaries to v12.1.2
- Update modules tests

## [0.2.8] - 2024-09-17

### :fontawesome-solid-add: Added

- Add option to set fontcolor, bgcolor edge color & node fillcolor

### :arrows_clockwise: Changed

- Update Graphviz binaries to v12.1.1

## [0.2.7] - 2024-09-12

### :bug: Fixed

- Fix Get-NodeIP returning multiple object when there a more than one IP in the DNS record

## [0.2.6] - 2024-09-11

### :bug: Fixed

- Fix Get-NodeIP returning an Array Object and not a string

## [0.2.5] - 2024-09-11

### :arrows_clockwise: Changed

- Enhance the way EnableErrorDebug option works.

### :bug: Fixed

- Removed error with Write-PSCriboMessage module

## [0.2.4] - 2024-09-07

### :fontawesome-solid-add: Added

- Add feature to set per object type icon in Add-DiaHtmlNodeTable module

### :arrows_clockwise: Changed

- Improved New-Diagrammer module

## [0.2.3] - 2024-08-31

### :arrows_clockwise: Changed

- Update Graphviz binaries to v12.1.0

## [0.2.2] - 2024-07-06

### :arrows_clockwise: Changed

- Update Graphviz binaries to v12.0.0


## [0.2.1] - 2024-05-16

### :fontawesome-solid-add: Added

- Improved Add-DiaHTMLTable and Add-DiaNodeIcon cmdlet

## [0.2.0] - 2024-04-29

### :arrows_clockwise: Changed

- Updated Graphviz to v11.0

## [0.1.9] - 2024-03-19

### :arrows_clockwise: Changed

- Improved Add-DiaHTMLNodeTable function. Close [#14](https://github.com/rebelinux/Diagrammer.Core/issues/14)
  - Allow to add more Information to the Node Object

## [0.1.8] - 2024-03-16

### :fontawesome-solid-add: Added

- Added Add-WatermarkToImage cmdlet to add WaterMark text to resulting diagrams.
- Added per format export function:
  - ConverTo-Base64
  - ConverTo-Png
  - ConverTo-Pdf
  - ConverTo-Dot
- Added function to allow image rotation to 90 degree (ConvertTo-RotateImage)
- Added Initial support for centralized function to create diagram

### :arrows_clockwise: Changed

- Renamed Out-Diagram to Export-Diagrammer
- Improved Add-DiaHTMLNodeTable

### :bug: Fixed

- [#12](https://github.com/rebelinux/Diagrammer.Core/issues/12)
- [#13](https://github.com/rebelinux/Diagrammer.Core/issues/13)

## [0.1.7] - 2024-02-26

### :fontawesome-solid-add: Added

- Added Resize-image cmdlet

### :arrows_clockwise: Changed

- Improved Get-DiaImagePercent module
- Improved Add-DiaHTMLNodeTable to better align MultiColumn Icon
- Improved Add-DiaNodeIcon debug mode

## [0.1.6] - 2024-02-23

### :arrows_clockwise: Changed

- Improved Get-DiaImagePercent module

## [0.1.5] - 2024-02-23

### :fontawesome-solid-add: Added

- Added Get-DiaImagePercent module

## [0.1.4] - 2024-02-22

### :arrows_clockwise: Changed

- Added PSGraph to the required module

## [0.1.3] - 2024-02-20

### :bug: Fixed

- Fix missing Graphviz dll files

## [0.1.2] - 2024-02-20

### :bug: Fixed

- Fix PowerShellGallery IconURI
- Module rename due to conflict with ImportExcel

## [0.1.1] - 2024-02-20

### :fontawesome-solid-add: Added

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
