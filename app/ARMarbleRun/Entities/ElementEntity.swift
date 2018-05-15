//
//  ElementEntity.swift
//  ARMarbleRun
//

class ElementEntity : ElementProtocol {
    
    var x = 1
    var y = 2
    var z = 0
    var state = ElementState.normal
    var name = "Typ_01"
    var orientation = 5

    func set(state: ElementState) {
        self.state = state
    }
    
    func getState() -> ElementState {
        return self.state
    }
}

enum ElementState {
    case highlighted
    case normal
    case faded
    case hidden
}
