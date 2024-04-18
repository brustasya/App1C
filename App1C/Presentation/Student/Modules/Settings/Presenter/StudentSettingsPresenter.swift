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
        
//    private let telemetryService: TelemetryServiceProtocol
    
    init(
        moduleOutput: StudentSettingsModuleOutput
//        telemetryService: TelemetryServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
//        self.telemetryService = telemetryService
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
            return
        case 4:
            moduleOutput?.moduleWantsToOpenRoleSelection()
        default:
            return
        }
    }
    
    
}
