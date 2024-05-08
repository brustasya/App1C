//
//  RoleSelectionPresenter.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import Foundation

final class RoleSelectionPresenter {
    weak var viewInput: RoleSelectionViewInput?
    weak var moduleOutput: RoleSelectionModuleOutput?
    
    private var roles: [Roles] = []
    private lazy var rolesModel: [BaseModel] = []
    
    private let verificationService: VerificationServiceProtocol
    
    init(
        moduleOutput: RoleSelectionModuleOutput,
        verificationService: VerificationServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.verificationService = verificationService
    }
    
    private func authorize(role: Roles) {
        TokenService.shared.role = role
        verificationService.authorize(with: AuthorizeModel(
            login: TokenService.shared.login,
            password: TokenService.shared.password,
            role: role.rawValue)
        ) { [weak self] result in
            switch result {
            case .success(let token):
                Logger.shared.printLog(log: "\(token)")
                TokenService.shared.token =  token.token?.accessToken ?? ""
                TokenService.shared.refreshToken = token.token?.refreshToken ?? ""
                TokenService.shared.id = token.uid
                
                DispatchQueue.main.async {
                    self?.openMainScreen(for: role)
                }
                
            case .failure(let error):
                Logger.shared.printLog(log: "Failed authorize: \(error)")
            }
        }
    }
    
    private func openMainScreen(for role: Roles) {
        switch role {
        case .student:
            moduleOutput?.userWantsToOpenStudentModule()
        case .teacher:
            moduleOutput?.userWantsToOpenTeacherModule()
        case .admin:
            moduleOutput?.userWantsToOpenAdminModule()
        }
    }
}

extension RoleSelectionPresenter: RoleSelectionViewOutput {
    func selectedRowAt(index: Int) {
        authorize(role: roles[index])
    }
    
    func viewIsReady() {
        roles = TokenService.shared.roles
        for role in roles {
            switch role {
            case .student:
                rolesModel.append(BaseModel(id: 0, title: "Страница студента", image: Images.books.uiImage))
            case .teacher:
                rolesModel.append(BaseModel(id: 1, title: "Страница преподавателя", image: Images.graduationcap.uiImage))
            case .admin:
                rolesModel.append(BaseModel(id: 2, title: "Страница администратора", image: Images.gear.uiImage))
            }
        }
        
        viewInput?.showRoles(roles: rolesModel)
    }
}
