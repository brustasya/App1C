//
//  EditDiplomaPresenter.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import Foundation

class EditDiplomaPresenter {
    weak var viewInput: EditDiplomaViewInput?
    
    private let diplomasInfoService: DiplomasInfoServiceProtocol
    private let studentID: Int
    private let bachelor: Bool
    private let model: DiplomaModel
    
    init(
        studentID: Int,
        bachelor: Bool,
        model: DiplomaModel,
        diplomasInfoService: DiplomasInfoServiceProtocol
    ) {
        self.studentID = studentID
        self.diplomasInfoService = diplomasInfoService
        self.bachelor = bachelor
        self.model = model
    }
    
    private func save(model: DiplomaDetailsServiceModel) {
        diplomasInfoService.modifyDiplomaDetails(studentID: studentID, bachelor: bachelor, model: model) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed save diploma: \(failure)")
            }
            
        }
    }
    
    private func getDiploma() {
        let bachelor = bachelor
        diplomasInfoService.getDiplomaDetails(studentID: studentID) { [weak self] result in
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
                        self?.viewInput?.setupTitle(title: model.studentFullName)
                        self?.viewInput?.updateData(model: diplomaModel)
                    }
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load diploma: \(failure)")
            }
        }
    }
    
    private func getThemeType(type: String) -> ThemeType {
        switch type {
        case ThemeType.department.title:
            return ThemeType.department
        case ThemeType.own.title:
            return ThemeType.own
        case ThemeType.work.title:
            return ThemeType.work
        default:
            return ThemeType.department
        }
    }
}

extension EditDiplomaPresenter: EditDiplomaViewOutput {
    func saveButtonTapped(model: DiplomaModel) {
        let diplomaModel = DiplomaDetailsServiceModel(
            studentID: studentID,
            studentFullName: self.model.studentName ?? "",
            theme: model.theme,
            type: getThemeType(type: model.themeType).rawValue,
            degree: bachelor ? "Бакалавр" : "Магистратура",
            isCurrentDiploma: true,
            adviserName: model.name,
            adviserContacts: model.contacts,
            adviserWorkplace: model.post,
            adviserJob: model.work,
            materialsLink: nil,
            grade: model.grade
        )
        
        save(model: diplomaModel)
    }
    
    func viewIsReady() {
        viewInput?.setupTitle(title: model.studentName ?? "")
        viewInput?.updateData(model: model)
        getDiploma()
    }
}
