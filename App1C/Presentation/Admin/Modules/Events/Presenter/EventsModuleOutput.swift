//
//  EventsModuleOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol EventsModuleOutput: AnyObject {
    func moduleWantsToCreateEvent(type: EventType)
    func moduleWantsToOpenEvent(id: Int)
}
