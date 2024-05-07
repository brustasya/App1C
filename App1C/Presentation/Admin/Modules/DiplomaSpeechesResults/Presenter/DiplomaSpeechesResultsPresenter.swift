//
//  DiplomaSpeechesResultsPresenter.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import Foundation

final class DiplomaSpeechesResultsPresenter {
    weak var viewInput: DiplomaSpeechesResultsViewInput?
        
    private let diplomasSpeechesService: DiplomaSpeechesServiceProtocol
    private var bachelor: Bool = true
    private var type: SpeechType = .rw1
    
    init(
        diplomasSpeechesService: DiplomaSpeechesServiceProtocol
    ) {
        self.diplomasSpeechesService = diplomasSpeechesService
    }
    
    private func getStudents() {
        diplomasSpeechesService.getSpeeches(type: type.rawValue, bachelor: bachelor) { [weak self] result in
            switch result {
            case .success(let model):
                let students = model.students.map({
                    SpeechResultModel(studentID: $0.studentID, speechID: $0.speechID, name: $0.fullName ?? "", theme: $0.theme ?? "", result: $0.result)
                })
                DispatchQueue.main.async {
                    self?.viewInput?.setupStudents(students: students)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load speeches: \(failure)")
            }
        }
    }
    
    private func setResult(studentID: Int, speechID: Int, result: Bool) {
        diplomasSpeechesService.result(studentID: studentID, speechID: speechID, result: result) { result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success add result")
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed add result: \(failure)")
            }
        }
    }
}

extension DiplomaSpeechesResultsPresenter: DiplomaSpeechesResultsViewOutput {
    func selectDegree(bachelor: Bool) {
        self.bachelor = bachelor
        getStudents()
    }
    
    func selectSpeech(type: SpeechType) {
        self.type = type
        getStudents()
    }
    
    func addResult(studentID: Int, speechID: Int, result: Bool) {
        setResult(studentID: studentID, speechID: speechID, result: result)
    }
}
