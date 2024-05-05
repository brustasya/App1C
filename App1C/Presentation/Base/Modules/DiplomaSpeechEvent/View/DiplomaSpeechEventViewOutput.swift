//
//  DiplomaSpeechEventViewOutput.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

protocol DiplomaSpeechEventViewOutput: AnyObject {
    func viewIsReady()
    func createButtonTapped(model: DiplomaSpeechEventModel)
    func saveButtonTapped(model: DiplomaSpeechEventModel)
}
