//
//  AdminAssembly.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

final class AdminAssembly: BaseAssembly {
    
    override init(serviceAssembly: ServiceAssembly) {
        super.init(serviceAssembly: serviceAssembly)
    }
    
    func makeSettingsModule(moduleOutput: AdminSettingsModuleOutput) -> UIViewController {
        let presenter = AdminSettingsPresenter(moduleOutput: moduleOutput)
        let vc = AdminSettingsViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeMainScreenModule(moduleOutput: AdminMainScreenModuleOutput) -> UIViewController {
        let presenter = AdminMainScreenPresenter(
            moduleOutput: moduleOutput,
            mainScreenService: serviceAssembly.makeMainPageService()
        )
        let vc = AdminMainScreenController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeStudentsListModule(moduleOutput: StudentsListModuleOutput) -> UIViewController {
        let presenter = StudentsListPresenter(moduleOutput: moduleOutput)
        let vc = StudentsListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeAddStudentModule(moduleOutput: AddStudentModuleOutput) -> UIViewController {
        let presenter = AddStudentPresenter(
            moduleOutput: moduleOutput,
            userCreationService: serviceAssembly.makeUserCreationService()
        )
        let vc = AddStudentViewController(output: presenter)
        return vc
    }
}
