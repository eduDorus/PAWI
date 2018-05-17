//
//  ElementEntity.swift
//  ARMarbleRun
//

class ElementEntity : ElementProtocol {
    public var location : Triple<Int, Int, Int>
    var state = ElementState.normal
    public var id = 12
    var orientation = 5
    
    init(id: Int, location: Triple<Int, Int, Int>) {
        self.id = id
        self.location = location
    }

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
