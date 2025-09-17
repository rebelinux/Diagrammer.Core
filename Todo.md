[] Add Web Site (Github Pages with Mkdocs)
[] Add Add-DiaNodeImage cmdlet to add a image with no text
    [Done] Add option to set image in percent
    [] Add option to set image opacity in percent
    [Done] Add option to set image borderline color, borderline style, etc..
    [Done] Add pester test
[] Add cmdlet to add shapes (Rectangle, Circle, Triangle)
    [Done] Add option to set shape size (WxH)
    [Done] Add option to set shape color, borderline color, borderline style, etc..
    [Done] Add Pester tests
[] Create Pester tests for:
    [Done] Add-WatermarkToImage
    [Done] ConvertTo-Pdf-WaterMark
    [Done] ConvertTo-RotateImage
    [Done] Export-Diagrammer
    [Done] Resize-Image
    [] Add-DiaCrossShapeLine
    [] Add-DiaTShapeLine
    [] Add-DiaRightTShapeLine
    [Done] Add-DiaHorizontalLine
    [] Add-DiaInvertedLShapeLine
    [] Add-DiaInvertedTShapeLine
    [] Add-DiaLeftTShapeLine
    [] Add-DiaLShapeLine
    [Done] Add-DiaVerticalLine
    [] Add-DiaRightLShapeLine
    [] Add-DiaLeftLShapeLine
[] Add support for Linux (Graphviz)
[] Add support for MACOS (Graphviz)
[] Add Documentation (use pscribo as example)
    [] [Example](https://github.com/iainbrighton/PScribo/blob/dev/Examples/Example01.ps1)
        [] Add pester to test Example files
    [Done] Add Add-DiaHTMLTable example
    [Done] Add Watermark example
    [Done] Add Signature example
    [Done] Add Shapes example
    [] Add Add-DiaHTMLSubGraph example
[] Add option to set icon size by percent
    [] Add-DiaNodeIcon
    [] Add-DiaHTMLNodeTable
    [] Add-DiaHTMLSubGraph
    [] Add-DiaNodeFiller
    [] Add pester to test this funtionality
[] Add NodeObject support see Add-DiaHTMLTable as example (use Join-Hashtable)
    [] Add-DiaNodeFiller
    [] Add-DiaNodeIcon
    [] Add-DiaHTMLNodeTable
    [] Add-DiaHTMLSubGraph
    [] Add-DiaHTMLLabel
    [] Add pester to test this funtionality
[Done] Add-DiaHTMLLabel
    [Done] Add Image WxH size by percent (use Add-DiaNodeImage as example)
    [Done] Add Pester Tests
        [Done] DraftMode
        [Done] Set Image WxH (-IconWidth & -IconHeight)
        [Done] Set Image size by percent (-ImageSizePercent)
        [Done] Add NoIcon Test (To add a label without attached icon)