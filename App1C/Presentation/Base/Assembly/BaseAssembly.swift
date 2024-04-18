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
        let presenter = AdminListPresenter(moduleOutput: moduleOutput)
        let vc = PersonListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
//    func makeTripModule(moduleOutput: TripModuleOutput, model: TripModel) -> UIViewController {
//        let presenter = TripPresenter(
//            moduleOutput: moduleOutput,
//            telemetryService: serviceAssembly.makeTelemetryService(),
//            tripModel: model
//        )
//        let tripVC = TripViewController(output: presenter)
//        presenter.viewInput = tripVC
//
//        return tripVC
//    }
}
