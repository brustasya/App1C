//
//  EventsViewOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol EventsViewOutput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func selectRow(at index: Int)
    func createEvent(type: EventType)
    func createThemeSelectionEvent()
    func createDiplomaSpeechEvent()
}
