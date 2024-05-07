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
   
    init (
        diplomasInfoService: DiplomasInfoServiceProtocol
    ) {
        self.diplomasInfoService = diplomasInfoService
    }
    
    private func getDiploma(bachelor: Bool) {
        diplomasInfoService.getDiplomaDetails(studentID: TokenService.shared.id) { [weak self] result in
            switch result {
            case .success(let model):
                let model = bachelor ? model.bachelor : model.master
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
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load diploma: \(failure)")
            }
        }
    }
}

extension StudentDiplomaPresenter: StudentDiplomaViewOutput {
    func viewIsReady() { }
    
    func viewWillAppear() { }
    
    func selectDegree(bachelor: Bool) {
        getDiploma(bachelor: bachelor)
    }
}
