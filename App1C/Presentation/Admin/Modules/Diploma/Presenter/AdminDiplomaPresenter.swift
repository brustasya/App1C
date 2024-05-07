//
//  AdminDiplomaPresenter.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import Foundation

class AdminDiplomaPresenter {
    weak var viewInput: DiplomaViewInput?
    weak var moduleOutput: AdminDiplomaModuleOutput?
    
    private let diplomasInfoService: DiplomasInfoServiceProtocol
    private let studentID: Int
    private let bachelor: Bool
    private var model: DiplomaModel = DiplomaModel(
        studentName: nil, theme: "", themeType: "", grade: 0,
        name: "", contacts: "", post: "", work: ""
    )
    
    init(
        studentID: Int,
        bachelor: Bool,
        moduleOutput: AdminDiplomaModuleOutput,
        diplomasInfoService: DiplomasInfoServiceProtocol
    ) {
        self.studentID = studentID
        self.diplomasInfoService = diplomasInfoService
        self.bachelor = bachelor
        self.moduleOutput = moduleOutput
    }
    
    private func getDiploma() {
        let bachelor = bachelor
        diplomasInfoService.getDiplomaDetails(studentID: studentID) { [weak self] result in
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
                self?.model = diplomaModel
                DispatchQueue.main.async {
                    self?.viewInput?.setupTitle(title: model.studentFullName)
                    self?.viewInput?.updateData(model: diplomaModel)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load diploma: \(failure)")
            }
        }
    }
}

extension AdminDiplomaPresenter: DiplomaViewOutput {
    func viewWillAppear() {
        getDiploma()
    }
    
    func viewIsReady() {
        viewInput?.setupEditButton()
        getDiploma()
    }
    
    func editButtonTapped() {
        moduleOutput?.moduleWantToEditDiploma(studentID: studentID, bachelor: bachelor, model: model)
    }
}

public func getType(type: String?) -> String {
    switch type {
    case ThemeType.department.rawValue:
        return ThemeType.department.title
    case ThemeType.own.rawValue:
        return ThemeType.own.title
    case ThemeType.work.rawValue:
        return ThemeType.work.title
    default:
        return ThemeType.department.title
    }
}
