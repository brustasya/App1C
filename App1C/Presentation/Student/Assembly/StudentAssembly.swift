//
//  StudentAssembly.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

final class StudentAssembly: BaseAssembly {

    override init(serviceAssembly: ServiceAssembly) {
        super.init(serviceAssembly: serviceAssembly)
    }
    
    func makeSettingsModule(moduleOutput: StudentSettingsModuleOutput) -> UIViewController {
        let presenter = StudentSettingsPresenter(moduleOutput: moduleOutput)
        let vc = StudentSettingsViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
}
