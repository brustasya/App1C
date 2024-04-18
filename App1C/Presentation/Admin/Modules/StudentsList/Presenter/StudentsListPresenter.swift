//
//  StudentsListPresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

final class StudentsListPresenter {
    weak var viewInput: StudentsListViewInput?
    weak var moduleOutput: StudentsListModuleOutput?
        
//    private let telemetryService: TelemetryServiceProtocol
    
    init(
        moduleOutput: StudentsListModuleOutput
//        telemetryService: TelemetryServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
//        self.telemetryService = telemetryService
    }
}

extension StudentsListPresenter: StudentsListViewOutput {
    func addStudent() {
        moduleOutput?.moduleWantsToOpenAddStudentModule()
    }
    
    
}
