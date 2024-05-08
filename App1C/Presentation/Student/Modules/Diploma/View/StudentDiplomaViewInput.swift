//
//  StudentDiplomaViewInput.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import Foundation

protocol StudentDiplomaViewInput: AnyObject {
    func updateData(model: DiplomaModel)
    func setupSpeeches(speeches: [SpeechModel])
}
