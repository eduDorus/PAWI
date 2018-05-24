//
//  MarbleRunGuide.swift
//  ARMarbleRun
//

import Foundation

class MarbleRunGuide {
    var currentLevel = 0
    var currentElement : ElementEntity?
    let elements : [ElementEntity]
    var stack : [ElementEntity] = []
    var guide : [Triple<Int,Int,Int>] = []
    var guidePointer = 0
    var finished = false
    
    init(_ elements: [ElementEntity]) {
        self.elements = elements
    }
    
    func generate() {
        guard !finished else {
            return
        }
        self.start()
        repeat {
            self.step()
        } while (!finished)
    }
    
    func next() -> Triple<Int,Int,Int>? {
        guard finished else {
            return nil
        }
        guidePointer += 1
        if guide.indices.contains(guidePointer) {
            return guide[guidePointer]
        } else {
            guidePointer -= 1
            return nil
        }
    }
    
    func previous() -> Triple<Int,Int,Int>? {
        guard finished else {
            return nil
        }
        guidePointer -= 1
        if guide.indices.contains(guidePointer) {
            return guide[guidePointer]
        } else {
            guidePointer += 1
            return nil
        }
    }
    
    func current() -> Triple<Int,Int,Int>? {
        guard finished && guide.indices.contains(guidePointer) else {
            return nil
        }
        return guide[guidePointer]
    }
    
    func hasNext() -> Bool {
        return guide.indices.contains(guidePointer+1)
    }
    
    func hasPrevious() -> Bool {
        return guide.indices.contains(guidePointer-1)
    }
    
    private func start() {
        elements.forEach { (e) in
            e.set(state: .hidden)
            if e.location == Triple(0,0,0) {
                appendElement(e)
            }
        }
        if stack.isEmpty {
            if let e = elements(onLevel: 0).first {
                appendElement(e)
            }
        }
    }
    
    private func step() {
        if stack.isEmpty {
            finished = true
            return
        }
        deactivateCurrentElement()
        setNewCurrentElement()
        activateCurrentElement()
        addCurrentToGuide()
        addNeighborsToQueue()
        if stack.isEmpty {
            checkLevel()
        }
        if stack.isEmpty {
            startNextLevel()
        }
    }
    
    private func activateCurrentElement() {
        guard currentElement != nil else { return }
        currentElement!.set(state: .highlighted)
    }
    
    private func deactivateCurrentElement() {
        guard currentElement != nil else { return }
        currentElement!.set(state: .faded)
    }
    
    private func setNewCurrentElement() {
        if let next = stack.popLast() {
            currentElement = next
        }
    }
    
    private func addCurrentToGuide() {
        if let loc = currentElement?.location {
            guide.append(loc)
        }
    }
    
    private func addNeighborsToQueue() {
        guard currentElement != nil else { return }
        if let (x,y,z) = currentElement?.location.values {
            var possibleNeighbors : [Triple<Int,Int,Int>] = []
            possibleNeighbors.append(Triple(x+1, y, z))
            possibleNeighbors.append(Triple(x-1, y, z))
            possibleNeighbors.append(Triple(x, y, z+1))
            possibleNeighbors.append(Triple(x, y, z-1))

            elements.forEach { (e) in
                if possibleNeighbors.contains(e.location) && e.getState() == .hidden {
                    appendElement(e)
                }
            }
        }
    }
    
    private func checkLevel() {
        for e in elements(onLevel: currentLevel) {
            if e.getState() == .hidden {
                appendElement(e)
                return
            }
        }
    }
    
    private func startNextLevel() {
        currentLevel += 1
        if let e = elements(onLevel: currentLevel).first {
            appendElement(e)
        }
    }
    
    private func elements(onLevel level: Int) -> [ElementEntity] {
        var levelElements : [ElementEntity] = []
        elements.forEach { (e) in
            if e.location.values.1 == level {
                levelElements.append(e)
            }
        }
        return levelElements
    }
    
    private func appendElement(_ element: ElementEntity) {
        element.set(state: .normal)
        stack.append(element)
    }
    
}
