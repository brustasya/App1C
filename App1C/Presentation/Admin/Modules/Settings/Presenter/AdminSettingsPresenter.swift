//
//  AdminSettingsPresenter.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import Foundation

final class AdminSettingsPresenter {
    weak var viewInput: AdminSettingsViewInput?
    weak var moduleOutput: AdminSettingsModuleOutput?
            
    private let openURLService: OpenURLServiceProtocol
    
    init(
        moduleOutput: AdminSettingsModuleOutput,
        openURLService: OpenURLServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.openURLService = openURLService
    }
}

extension AdminSettingsPresenter: AdminSettingsViewOutput {
    func selectDiplomaRowAt(index: Int) {
        switch index {
        case 0:
            moduleOutput?.moduleWantsToOpenDiplomaThemes()
        case 1:
            moduleOutput?.moduleWantsToOpenSRWResults()
        case 2:
            moduleOutput?.moduleWantsToOpenSRWGrades()
        default:
            return
        }
    }
    
    func selectRowAt(index: Int) {
        switch index {
        case 0:
            moduleOutput?.moduleWantsToOpenProfile()
        case 1:
            moduleOutput?.moduleWantsToOpenAdminList()
        case 2:
            openURLService.openURL(url: TokenService.shared.chatURL)
        case 3:
            moduleOutput?.moduleWantsToOpenRoleSelection()
        case 4:
            moduleOutput?.moduleWantsToOpenAuthorization()
        default:
            return
        }
    }
    
    func selectEducationRowAt(index: Int) {
        switch index {
        case 0:
            moduleOutput?.moduleWantsToOpenTeachersList()
        case 1:
            moduleOutput?.moduleWantsToOpenStudentsList()
        case 2:
            moduleOutput?.moduleWantsToOpenDepartmentCourses()
        default:
            return
        }
    }
}
