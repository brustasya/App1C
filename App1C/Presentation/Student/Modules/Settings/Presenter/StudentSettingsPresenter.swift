//
//  StudentSettingsPresenter.swift
//  App1C
//
//  Created by Станислава on 08.04.2024.
//

import Foundation

final class StudentSettingsPresenter {
    weak var viewInput: StudentSettingsViewInput?
    weak var moduleOutput: StudentSettingsModuleOutput?
     
    private let openURLService: OpenURLServiceProtocol
    
    init(
        moduleOutput: StudentSettingsModuleOutput,
        openURLService: OpenURLServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.openURLService = openURLService
    }
}

extension StudentSettingsPresenter: StudentSettingsViewOutput {
    func selectRowAt(index: Int) {
        switch index {
        case 0:
            moduleOutput?.moduleWantsToOpenProfile()
        case 1:
            moduleOutput?.moduleWantsToOpenAdminList()
        case 2:
            moduleOutput?.moduleWantsToOpenDepartmentCourses()
        case 3:
            openURLService.openURL(url: TokenService.shared.chatURL)
        case 4:
            moduleOutput?.moduleWantsToOpenRoleSelection()
        case 5:
            moduleOutput?.moduleWantsToOpeAuthorization()
        default:
            return
        }
    }
    
    
}
