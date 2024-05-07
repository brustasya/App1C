//
//  DiplomaThemesPresenter.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

final class DiplomaThemesPresenter {
    weak var viewInput: DiplomaThemesViewInput?
    weak var moduleOutput: DiplomaThemesModuleOutput?
        
    private let diplomasInfoService: DiplomasInfoServiceProtocol
    private var students: [DiplomaThemeModel] = []
    private var bachelor: Bool = true
    
    init(
        moduleOutput: DiplomaThemesModuleOutput,
        diplomasInfoService: DiplomasInfoServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.diplomasInfoService = diplomasInfoService
    }
    
    private func getStudents(for bachelor: Bool) {
        diplomasInfoService.getDiplomas(bachelor: bachelor) { [weak self] result in
            switch result {
            case .success(let model):
                let students = model.diplomas.map({
                    DiplomaThemeModel(id: $0.studentID, name: $0.studentFullName, theme: $0.theme ?? "")
                })
                self?.students = students
                DispatchQueue.main.async {
                    self?.viewInput?.setupStudents(students: students)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load students: \(failure)")
            }
        }
    }
}

extension DiplomaThemesPresenter: DiplomaThemesViewOutput {
    func selectType(bachelor: Bool) {
        getStudents(for: bachelor)
        self.bachelor = bachelor
    }
    
    func selectStudent(index: Int) {
        moduleOutput?.moduleWantsToOpenDiploma(studentID: students[index].id, bachelor: bachelor)
    }
}
