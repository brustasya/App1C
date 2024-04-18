//
//  AddTeacherPresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

final class AddTeacherPresenter {
    weak var viewInput: AddPersonViewInput?
    weak var moduleOutput: AddTeacherModuleOutput?
        
    private let userCreationService: UserCreationServiceProtocol
    
    init(
        moduleOutput: AddTeacherModuleOutput,
        userCreationService: UserCreationServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.userCreationService = userCreationService
        
    }
    
    private func createTeacher(model: CreateUserModel) {
        userCreationService.createTeacher(model: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success added teacher")
                DispatchQueue.main.async {
                    self?.moduleOutput?.moduleWantsToCloseAddTeacher()
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed added teacher: \(failure)")
            }
        }
    }
}

extension AddTeacherPresenter: AddPersonViewOutput {
    func viewIsReady() {
        viewInput?.setupTitle(title: "Добавить преподавателя")
        viewInput?.setupEmailField()
    }
    
    func addButtonTapped(secondName: String, firstName: String, surname: String,
                                email: String, semester: Int) {
        let model = CreateUserModel(
            secondName: secondName,
            firstName: firstName,
            surname: surname,
            email: email
        )
        createTeacher(model: model)
    }
    
    func goBack() {
        moduleOutput?.moduleWantsToCloseAddTeacher()
    }
}
