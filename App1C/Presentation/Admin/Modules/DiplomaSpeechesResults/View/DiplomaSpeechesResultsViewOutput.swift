//
//  DiplomaSpeechesResultsViewOutput.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import Foundation

protocol DiplomaSpeechesResultsViewOutput: AnyObject {
    func selectDegree(bachelor: Bool)
    func selectSpeech(type: SpeechType)
    func addResult(studentID: Int, speechID: Int, result: Bool)
}
