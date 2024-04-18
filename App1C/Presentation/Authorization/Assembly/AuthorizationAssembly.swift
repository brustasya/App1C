//
//  AuthorizationAssembly.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import Foundation
import UIKit

final class AuthorizationAssembly {
    private let serviceAssembly: ServiceAssembly

    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func makeRoleSelectionModule(moduleOutput: RoleSelectionModuleOutput) -> UIViewController {
        let presenter = RoleSelectionPresenter(
            moduleOutput: moduleOutput,
            verificationService: serviceAssembly.makeVerificationService()
        )
        let vc = RoleSelectionViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeVerificationModule(moduleOutput: VerificationModuleOutput) -> UIViewController {
        let presenter = VerificationPresenter(
            moduleOutput: moduleOutput,
            verificationService: serviceAssembly.makeVerificationService()
        )
        let vc = VerificationViewController(output: presenter)
        return vc
    }

}
