//
// ARModeState.swift
// ARMarbleRun
//

import Foundation

enum ARModeState {
    case planeSelection
    case runPlacement(ARModeState.Locking)
    case buildProcess
    case editorMode

    enum Locking {
        case locked
        case unlocked
    }
}
