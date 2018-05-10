//
//  MarbleRunElement.swift
//  ARMarbleRun
//

class MarbleRunElement {
    var x = 1
    var y = 2
    var z = 0
    var status = ElementStatus.normal
    var name = "Typ_01"
    var orientation = 5
}

enum ElementStatus {
    case highlighted
    case normal
    case faded
    case hidden
}
