//
//  DiplomaSpeechesResultsViewInput.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import Foundation

protocol DiplomaSpeechesResultsViewInput: AnyObject {
    func setupStudents(students: [SpeechResultModel])
}
