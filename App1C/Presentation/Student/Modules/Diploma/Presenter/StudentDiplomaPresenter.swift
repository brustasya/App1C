//
//  StudentDiplomaPresenter.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import Foundation

class StudentDiplomaPresenter {
    weak var viewInput: StudentDiplomaViewInput?
    
    private let diplomasInfoService: DiplomasInfoServiceProtocol
    private let diplomasSpeechesService: DiplomaSpeechesServiceProtocol
   
    init (
        diplomasInfoService: DiplomasInfoServiceProtocol,
        diplomasSpeechesService: DiplomaSpeechesServiceProtocol
    ) {
        self.diplomasInfoService = diplomasInfoService
        self.diplomasSpeechesService = diplomasSpeechesService
    }
    
    private func getDiploma(bachelor: Bool) {
        diplomasInfoService.getDiplomaDetails(studentID: TokenService.shared.id) { [weak self] result in
            switch result {
            case .success(let model):
                let model = bachelor ? model.bachelor : model.master
                if let model {
                    let diplomaModel = DiplomaModel(
                        studentName: model.studentFullName,
                        theme: model.theme ?? "",
                        themeType: getType(type: model.type),
                        grade: model.grade ?? 0,
                        name: model.adviserName ?? "",
                        contacts: model.adviserContacts ?? "",
                        post: model.adviserWorkplace ?? "",
                        work: model.adviserJob ?? ""
                    )
                    DispatchQueue.main.async {
                        self?.viewInput?.updateData(model: diplomaModel)
                    }
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load diploma: \(failure)")
            }
        }
    }
    
    private func getSpeeches(bachelor: Bool) {
        diplomasSpeechesService.getSpeeches(studentID: TokenService.shared.id, bachelor: bachelor) { [weak self] result in
            switch result {
            case .success(let model):
                let speeches = model.speeches.map({
                    SpeechModel(title: self?.getSpeechTitle(type: $0.speechType) ?? "", result: $0.result ?? true)
                })
                DispatchQueue.main.async {
                    self?.viewInput?.setupSpeeches(speeches: speeches)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load speeches: \(failure)")
            }
        }
    }
    
    private func getSpeechTitle(type: String?) -> String {
        switch type {
        case SpeechType.rw1.rawValue:
            return SpeechType.rw1.title
        case SpeechType.rw2.rawValue:
            return SpeechType.rw2.title
        case SpeechType.rw3.rawValue:
            return SpeechType.rw3.title
        case SpeechType.predefending.rawValue:
            return SpeechType.predefending.title
        case SpeechType.defending.rawValue:
            return SpeechType.defending.title
        default:
            return SpeechType.rw1.title
        }
    }
}

extension StudentDiplomaPresenter: StudentDiplomaViewOutput {
    func viewIsReady() { }
    
    func viewWillAppear() { }
    
    func selectDegree(bachelor: Bool) {
        getDiploma(bachelor: bachelor)
        getSpeeches(bachelor: bachelor)
    }
}
