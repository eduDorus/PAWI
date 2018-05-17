//
//  ElementProtokcol.swift
//  ARMarbleRun
//

import Foundation

protocol ElementProtocol : Hashable {
    func set(state: ElementState)
    func getState() -> ElementState
}
