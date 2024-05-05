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
            
    init(
        moduleOutput: AdminSettingsModuleOutput
    ) {
        self.moduleOutput = moduleOutput
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
            return
        case 3:
            moduleOutput?.moduleWantsToOpenRoleSelection()
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
            return
        case 3:
            moduleOutput?.moduleWantsToOpenDepartmentCourses()
        default:
            return
        }
    }
}
