//
//  AddAdminPresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

final class AddAdminPresenter {
    weak var viewInput: AddPersonViewInput?
    weak var moduleOutput: AddAdminModuleOutput?
        
    private let userCreationService: UserCreationServiceProtocol
    
    init(
        moduleOutput: AddAdminModuleOutput,
        userCreationService: UserCreationServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.userCreationService = userCreationService
        
    }
    
    private func createAdmin(model: CreateUserModel) {
        userCreationService.createAdmin(model: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success added admin")
                DispatchQueue.main.async {
                    self?.moduleOutput?.moduleWantsToCloseAddAdmin()
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed added admin: \(failure)")
            }
        }
    }
}

extension AddAdminPresenter: AddPersonViewOutput {
    func viewIsReady() {
        viewInput?.setupTitle(title: "Добавить администратора")
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
        createAdmin(model: model)
    }
    
    func goBack() {
        moduleOutput?.moduleWantsToCloseAddAdmin()
    }
}

