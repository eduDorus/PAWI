//
//  ElementProtokcol.swift
//  ARMarbleRun
//

import Foundation

protocol ElementProtocol {
    func set(state: ElementState)
    func getState() -> ElementState
}
