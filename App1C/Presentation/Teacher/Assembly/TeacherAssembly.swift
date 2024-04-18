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
}
