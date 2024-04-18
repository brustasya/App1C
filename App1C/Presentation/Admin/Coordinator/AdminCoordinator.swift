//
//  AdminCoordinator.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

final class AdminCoordinator: CoordinatorProtocol {
    private weak var window: UIWindow?
    weak var rootCoordinator: RootCoordinator?

    private let adminAssembly: AdminAssembly
    
    private var mainScreenNavigationController = UINavigationController()
    private var settingsNavigationController: UINavigationController = UINavigationController()
    private var tripViewController: UIViewController = UIViewController()
    private var profileEditingViewController: UIViewController = UIViewController()
    private var passengerTripViewController: UIViewController = UIViewController()
    private var ratingViewController: UIViewController = UIViewController()
    
    init(adminAssembly: AdminAssembly) {
        self.adminAssembly = adminAssembly
    }
    
    func start(in window: UIWindow?) {
        let mainScreenVC = adminAssembly.makeMainScreenModule(moduleOutput: self)
        mainScreenNavigationController = CustomNavigationController(rootViewController: mainScreenVC)
        let settingsVC = adminAssembly.makeSettingsModule(moduleOutput: self)//profileAssembly.makeProfileModule(moduleOutput: self)
        self.settingsNavigationController = CustomNavigationController(rootViewController: settingsVC)
        let eventsNavigationController = CustomNavigationController(rootViewController: EventsViewController())
        
        let tabBarController = AdminTabBarController(
            mainScreenNavigationController: mainScreenNavigationController,
            eventsNavigationController: eventsNavigationController,
            settingsNavigationController: settingsNavigationController
        )
        
        window?.rootViewController = tabBarController
        self.window = window
    }
}

extension AdminCoordinator: AdminSettingsModuleOutput {
    func moduleWantsToOpenStudentsList() {
        let studentsListVC = adminAssembly.makeStudentsListModule(moduleOutput: self)
        settingsNavigationController.pushViewController(studentsListVC, animated: true)
    }
    
    func moduleWantsToOpenDepartmentCourses() {
        
    }
    
    func moduleWantsToOpenProfile() {
        settingsNavigationController.pushViewController(CoursesAgregationViewController(), animated: true)
    }
    
    func moduleWantsToOpenAdminList() {
        let vc = adminAssembly.makeAdminListModule(moduleOutput: self)
        settingsNavigationController.pushViewController(vc, animated: true)
    }
    
    func moduleWantsToOpenRoleSelection() {
        rootCoordinator?.openRoleSelection()
    }
}

extension AdminCoordinator: AdminListModuleOutput {
    func moduleWantsToCloseAdminList() {
        settingsNavigationController.popViewController(animated: true)
    }
}

extension AdminCoordinator: AdminMainScreenModuleOutput {
}

extension AdminCoordinator: StudentsListModuleOutput {
    func moduleWantsToOpenAddStudentModule() {
        let addStudentVC = adminAssembly.makeAddStudentModule(moduleOutput: self)
        settingsNavigationController.pushViewController(addStudentVC, animated: true)
    }
}

extension AdminCoordinator: AddStudentModuleOutput {
    func moduleWantsToCloseAddStudent() {
        settingsNavigationController.popViewController(animated: true)
    }
    
    
}

