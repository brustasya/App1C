//
//  NotificationsModuleOutput.swift
//  App1C
//
//  Created by Станислава on 03.05.2024.
//

import Foundation

protocol NotificationsModuleOutput: AnyObject {
    func moduleWantsToOpenNotification(id: Int)
    func moduleWantsToOpenThemeSelectionEvent(id: Int)
    func moduleWantsToOpenDiplomaSpeechEvent(id: Int)
}
