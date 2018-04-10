# PAWI
IT Project by bachelor's students Dorus Janssens and Lucas Schnüriger at the [Lucerne School of Information Technology](https://www.hslu.ch/en/lucerne-school-of-information-technology/). The goal is an iOS App to augment marble tracks by [cuboro](https://cuboro.ch) with ARKit, CoreML and Vision. Find out more about the project in the [wiki](https://github.com/eduDorus/PAWI/wiki). All documentation is in German.

## Prototypes
The different prototypes developed during this project are available in the "prototypes" directory. Each Xcode project corresponds with the defined prototypes as follows:
- [SceneKit Kugelbahn Prototyp](https://github.com/eduDorus/PAWI/tree/master/prototypes/SceneKit%20Kugelbahn%20Prototype): Overlay über einen Würfel mit SceneKit ([#5](https://github.com/eduDorus/PAWI/issues/5)) und virtuellen Würfel auf Fläche stellen & interagieren ([#4](https://github.com/eduDorus/PAWI/issues/4))
- [RecognizingImagesInAnARExperience](https://github.com/eduDorus/PAWI/tree/master/prototypes/RecognizingImagesInAnARExperience): Overlay über einen Würfel mit SpriteKit ([#3](https://github.com/eduDorus/PAWI/issues/3))
- [UsingVisionInRealTimeWithARKit](https://github.com/eduDorus/PAWI/tree/master/prototypes/UsingVisionInRealTimeWithARKit): physischen Würfel als virtuelles Objekt erfassen ([#2](https://github.com/eduDorus/PAWI/issues/2))
- [virtuelle-kugelbahn](https://github.com/eduDorus/PAWI/tree/master/prototypes/virtuelle-kugelbahn): virtuelle Kugelbahn modellieren, projizieren ([#16](https://github.com/eduDorus/PAWI/issues/16)) und ebenenweise Aufbauanleitung ([#19](https://github.com/eduDorus/PAWI/issues/19))
- [GesturePrototype](https://github.com/eduDorus/PAWI/tree/master/prototypes/GesturePrototype): Mittels Touchgesten mit virtuellen Objekten interagieren ([#17](https://github.com/eduDorus/PAWI/issues/17))

## Documentation
The documentation is written with LaTeX. For code examples the `minted` package is used, which requires the Python packaged `Pygments`. Go through the following steps to be able to compile the documentation (uses VS Code and the LaTeX Workshop Extension):
1. Install Pygments with `pip install Pygments`, it might already be installed
2. Add `-shell-escape` to `latexmk` arguments in the setting `latex-workshop.latex.tools`. Be aware that this allow LaTeX to run potentially arbitrary commands on your system. Deactivate it for other documents.
3. Add `*.lol` to the filetypes to clean in the setting `latex-workshop.latex.clean.fileTypes`

### Usage
- Insert images with the command: `\bild[SOURCEURL]{WIDTH}{FILENAME}{CAPTION}`.
  - The argument SOURCEURL is optional and can be used to add a URL source for the image. It will be shown in the list of figures.
  - The width is relative to textwidth (1=fullsize, 0.5=half).
  - Ignore the filetype (e.g. ".png") for the filename.
  - To reference an image use `\ref{fig:FILENAME}`.
- Insert Swift code blocks with the `code` environment, to reference it use `\ref{code:LABEL}`.
  ```
  \begin{code}{LABEL}{CAPTION}
    Swift code ...
  \end{code}
  ```
- For single lines (not inline!) of code without the need of a caption use the following sequence: `\mint[style=xcode,breaklines]{swift}{CODE}`
- Reference sources added to Quellen.bib with `\cite{LABEL}`.

