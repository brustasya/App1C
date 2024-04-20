//
//  TeacherAssembly.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

final class TeacherAssembly: BaseAssembly {
    
    override init(serviceAssembly: ServiceAssembly) {
        super.init(serviceAssembly: serviceAssembly)
    }
    
    func makeSettingsModule(moduleOutput: TeacherSettingsModuleOutput) -> UIViewController {
        let presenter = TeacherSettingsPresenter(moduleOutput: moduleOutput)
        let vc = TeacherSettingsViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeMainScreenModule(moduleOutput: TeacherMainScreenModuleOutput) -> UIViewController {
        let presenter = TeacherMainScreenPresenter(
            moduleOutput: moduleOutput,
            mainScreenService: serviceAssembly.makeMainPageService()
        )
        let vc = TeacherMainScreenController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeEventModule(id: Int, moduleOutput: TeacherEventModuleOutput) -> UIViewController {
        let presenter = TeacherEventPresenter(
            id: id,
            moduleOutput: moduleOutput,
            coursesService: serviceAssembly.makeCoursesService(),
            eventsService: serviceAssembly.makeEventsService()
        )
        let vc = EventViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
}
