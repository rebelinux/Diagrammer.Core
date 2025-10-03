---
comments: false
hide:
  - toc
---

### :material-account-question: What Operating Systems are supported?

Diagrammer.Core supports Windows based Operating Systems including:

- Windows 10
- Windows 11
- Windows Server 2016
- Windows Server 2019
- Windows Server 2022
- Windows Server 2025

### :material-account-question: What versions of PowerShell are supported?

Diagrammer.Core will generally support both Windows PowerShell 5.1 and PowerShell 7, however each individual diagram will have its own system requirements.

### :material-account-question: What is PSGraph?

[PSGraph](https://github.com/KevinMarquette/PSGraph){:target="_blank"} is an open-source project created by [Kevin Marquette](https://powershellexplained.com/aboutme/?utm_source=blog&utm_medium=blog&utm_content=navbar){:target="_blank"}.

PSGraph is a helper module implemented as a DSL (Domain Specific Language) for generating GraphViz graphs. The goal is to make it easier to generate graphs using Powershell. The DSL adds these commands that are explained below.

### :material-account-question: What is Graphviz?

[Graphviz](https://graphviz.org/){:target="_blank"} is an open-source graph visualization software. It has several main components:

- A text-based graph description language (DOT)
- A set of tools to process and render graphs described in DOT
- Libraries for integrating graph visualization into other applications

Graphviz is widely used for visualizing structural information, such as network diagrams, flowcharts, and organizational charts.

### :material-account-question: What export formats are supported?

The following export formats are supported:

- Base64 (Base64 Encoded String)
- DOT (Graphviz DOT format)
- JPEG (Joint Photographic Experts Group)
- PDF (Adobe Portable Document Format)
- PNG (Portable Network Graphics)
- SVG (Scalable Vector Graphics)

### :material-account-question: Do I need Graphviz installed to generate a diagram?

No. Graphviz is included as part of the Diagrammer.Core module and is automatically extracted to a temporary location when required.