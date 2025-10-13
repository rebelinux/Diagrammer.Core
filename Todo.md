- [ ] Research a way to put the Add-DiaNodeIcon in a horizontal like design
    - [ ] Desired design is horizontal
    ```markdown
    _______________________________
    | Image |                     |
    |       |                     |
    ---------        Info         |
    |       |                     |
    | Name  |                     |
    _______________________________
    ```
- [ ] Add cmdlet to create Text Box (Add-DiaNodeText)
  - [ ] Add option to set Textbox properties (BorderStyle, BorderColor, BorderSize, FillColor, FontSize, FontColor, TextAlign)
  - [ ] Add option to set Textbox size by percent (Hack by using Text size)
- [ ] Add Web Site (Github Pages with Mkdocs)
    - [x] Add Logo and Favicon
    - [x] Add Google Analytics
    - [x] Add Social Links (Github, Twitter, LinkedIn, Bluesky)
- [ ] Add Add-DiaNodeFiller cmdlet to add space between icon and text
    - [ ] Add option to set filler size in percent
- [ ] Add Add-DiaNodeImage cmdlet to add a image with no text
- [ ] Add option to set image opacity in percent
- [ ] Create Pester tests for:
    - [ ] Add-DiaCrossShapeLine
    - [ ] Add-DiaTShapeLine
    - [ ] Add-DiaRightTShapeLine
    - [ ] Add-DiaInvertedLShapeLine
    - [ ] Add-DiaInvertedTShapeLine
    - [ ] Add-DiaLeftTShapeLine
    - [ ] Add-DiaLShapeLine
    - [ ] Add-DiaRightLShapeLine
    - [ ] Add-DiaLeftLShapeLine
- [ ] Add support for Linux (Graphviz)
- [ ] Add support for MACOS (Graphviz)
- [ ] Add Documentation (use pscribo as example)
    - [ ] Add ShapeLine example
    - [x] Add Add-DiaHTMLSubGraph example
    - [ ] Add Add-DiaHTMLText example
- [ ] Add option to set icon size by percent
    - [ ] Add-DiaNodeIcon
    - [ ] Add-DiaHTMLNodeTable
    - [ ] Add-DiaHTMLSubGraph
    - [ ] Add pester to test this funtionality
- [ ] Add NodeObject support see Add-DiaHTMLTable as example (use Join-Hashtable)
    - [ ] Add-DiaNodeFiller
    - [ ] Add-DiaNodeIcon
    - [ ] Add-DiaHTMLNodeTable
    - [ ] Add-DiaHTMLSubGraph
    - [ ] Add-DiaHTMLLabel
    - [ ] Add pester to test this funtionality
- [ ] Add IconType and Image name in DraftMode
    - [ ] Add-DiaNodeFiller
    - [ ] Add-DiaNodeIcon
    - [ ] Add-DiaHTMLNodeTable
    - [ ] Add-DiaHTMLSubGraph
    - [ ] Add-DiaHTMLLabel
    - [ ] Add pester to test this funtionality
- [ ] Research ways to add html label to edges to simulate enhanced connectivity
- [x] Add minlen parameter to shape lines
    - [x] Add-DiaInvertedLShapeLine
- [x] Fix Test with $env:TMP = $TestDrive
    - [x] Resize-Image.Tests.ps1
    - [x] Add-WatermarkToImage.Tests.ps1
    - [x] ConvertTo-Pdf-WaterMark.Tests.ps1
- [ ] Add option generate diagram without logo and maindiagram title