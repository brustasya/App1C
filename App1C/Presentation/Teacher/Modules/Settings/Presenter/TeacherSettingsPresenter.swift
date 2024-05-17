//
//  TeacherSettingsPresenter.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import Foundation

final class TeacherSettingsPresenter {
    weak var viewInput: TeacherSettingsViewInput?
    weak var moduleOutput: TeacherSettingsModuleOutput?
        
//    private let telemetryService: TelemetryServiceProtocol
    
    init(
        moduleOutput: TeacherSettingsModuleOutput
//        telemetryService: TelemetryServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
//        self.telemetryService = telemetryService
    }
}

extension TeacherSettingsPresenter: TeacherSettingsViewOutput {
    func selectRowAt(index: Int) {
        switch index {
        case 0:
            moduleOutput?.moduleWantsToOpenProfile()
        case 1:
            moduleOutput?.moduleWantsToOpenAdminList()
        case 2:
            moduleOutput?.moduleWantsToOpenDepartmentCourses()
        case 3:
            return
        case 4:
            moduleOutput?.moduleWantsToOpenRoleSelection()
        case 5:
            moduleOutput?.moduleWantsToOpenAuthorization()
        default:
            return
        }
    }
}
