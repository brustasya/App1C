//
//  VerificationPresenter.swift
//  App1C
//
//  Created by Станислава on 17.04.2024.
//

import Foundation

class VerificationPresenter {
    weak var moduleOutput: VerificationModuleOutput?
    
    private let verificationService: VerificationServiceProtocol
    
    init(
        moduleOutput: VerificationModuleOutput,
        verificationService: VerificationServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.verificationService = verificationService
    }
    
    private func verification(login: String, password: String) {
        verificationService.verification(with: VerificationModel(login: login, password: password)) { [weak self] result in
            switch result {
            case .success(let serverRoles):
                Logger.shared.printLog(log: "Roles: \(serverRoles.roles)")
                var roles: [Roles] = []
                for role in serverRoles.roles {
                    switch role {
                    case "STUDENT":
                        roles.append(.student)
                    case "TEACHER":
                        roles.append(.teacher)
                    case "ADMIN":
                        roles.append(.admin)
                    default:
                        break
                    }
                }
                DispatchQueue.main.async {
                    TokenService.shared.setupLoginData(login: login, password: password, roles: roles)
                    self?.moduleOutput?.userWantsToOpenRoleSelection()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension VerificationPresenter: VerificationViewOutput {
    func loginButtonTapped(login: String, password: String) {
        verification(login: login, password: password)
    }
}
