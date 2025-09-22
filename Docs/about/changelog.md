# Changelog

## [0.2.31] - 2025-09-??

### Added

- Add AdvancedExample01.ps1 to demonstrate the use of Add-DiaHTMLSubGraph cmdlet
- Add TableBackgroundColor parameter to Add-DiaHTMLSubGraph cmdlet
- Add Dependabot support for GitHub Actions and PowerShell modules
- Add tests for Add-DiaHTMLSubGraph with custom TableBackgroundColor and update existing test cases
- Add Graphviz support and update documentation
- Install mkdocs-graphviz as a dependency in the workflow.
- Create Dependencies.md to outline essential dependencies for PSGraph.

### Changed

- Update index.md with additional content for clarity.
- Modify mkdocs.yml to include Graphviz in markdown extensions and extra JavaScript.

### Fixed

Fix regex pattern in New-Diagrammer function to correctly match graph object labels for export

## [0.2.30] - 2025-09-18

### Added

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

### Changed

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

### Fixed

- Fix expected output for tests related to HTML tables with logos and labels.
- Fix consistency in the HTML structure for both top and bottom logo placements.
- Fix test cases to reflect the correct HTML output for better validation.
- Fix HTML table output by bolding cell content in Add-DiaHTMLNodeTable function

### Removed

- Removed the deprecated Add-DiaNodeFiller function.