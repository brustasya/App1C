//
//  StudentMainScreenModuleOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol StudentMainScreenModuleOutput: AnyObject {
    func moduleWantsToOpenEvent(id: Int)
    func moduleWantsToOpenThemeSelectionEvent(id: Int)
    func moduleWantsToOpenDiplomaSpeechEvent(id: Int)
    func moduleWantsToOpenTimeTable()
    func moduleWantsToOpenNotifications()
}
