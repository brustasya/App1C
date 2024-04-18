//
//  BaseAssembly.swift
//  App1C
//
//  Created by Станислава on 10.04.2024.
//

import UIKit

class BaseAssembly {
    let serviceAssembly: ServiceAssembly

    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func makeAdminListModule(moduleOutput: AdminListModuleOutput) -> UIViewController {
        let presenter = AdminListPresenter(
            moduleOutput: moduleOutput,
            usersListService: serviceAssembly.makeUsersListService())
        let vc = PersonListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeAdminDetailsModule(for id: Int) -> UIViewController {
        let presenter = AdminDetailsPresenter(
            id: id,
            profileService: serviceAssembly.makeProfileService()
        )
        let vc = ProfileViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeStudentProfileModule(for id: Int) -> UIViewController {
        let presenter = StudentPersonalDataPresenter(
            id: id,
            profileService: serviceAssembly.makeProfileService()
        )
        let vc = ProfileViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeTeacherProfileModule(for id: Int) -> UIViewController {
        let presenter = TeacherPersonalDataPresenter(
            id: id,
            profileService: serviceAssembly.makeProfileService()
        )
        let vc = ProfileViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
}
