//
//  DiplomaSpeechEventViewInput.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

protocol DiplomaSpeechEventViewInput: AnyObject {
    func setupCreateMode() 
    func setupSaveMode()
    func setupReadMode()
    func updateData(model: DiplomaSpeechEventModel, isEdit: Bool) 
    func setTitle(title: String)
    func close()
}
