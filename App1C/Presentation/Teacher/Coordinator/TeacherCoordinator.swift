//
//  TeacherCoordinator.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

final class TeacherCoordinator: CoordinatorProtocol {
    private weak var window: UIWindow?
    weak var rootCoordinator: RootCoordinator?
    
    private let teacherAssembly: TeacherAssembly
    
    private var mainScreenNavigationController = UINavigationController()
    private var settingsNavigationController: UINavigationController = UINavigationController()
    private var tripViewController: UIViewController = UIViewController()
    private var profileEditingViewController: UIViewController = UIViewController()
    private var passengerTripViewController: UIViewController = UIViewController()
    private var ratingViewController: UIViewController = UIViewController()
    
    init(teacherAssembly: TeacherAssembly) {
        self.teacherAssembly = teacherAssembly
    }
    
    func start(in window: UIWindow?) {
        let mainScreenVC = TeacherMainScreenController()//mainScreenAssembly.makeMainScreenModule(moduleOutput: self)
        mainScreenNavigationController = CustomNavigationController(rootViewController: mainScreenVC)
        let settingsVC = teacherAssembly.makeSettingsModule(moduleOutput: self)//profileAssembly.makeProfileModule(moduleOutput: self)
        self.settingsNavigationController = CustomNavigationController(rootViewController: settingsVC)
        let coursesListNavigationController = CustomNavigationController(rootViewController: TeacherCoursesListViewController())
        
        let tabBarController = TeacherTabBarController(
            mainScreenNavigationController: mainScreenNavigationController,
            coursesListNavigationController: coursesListNavigationController,
            settingsNavigationController: settingsNavigationController
        )
        
        window?.rootViewController = tabBarController
        self.window = window
    }
}

extension TeacherCoordinator: TeacherSettingsModuleOutput {
    func moduleWantsToOpenDepartmentCourses() {
        settingsNavigationController.pushViewController(EstimationViewController(), animated: true)
    }
    
    func moduleWantsToOpenProfile() {
        
    }
    
    func moduleWantsToOpenAdminList() {
        let vc = teacherAssembly.makeAdminListModule(moduleOutput: self)
        settingsNavigationController.pushViewController(vc, animated: true)
    }
    
    func moduleWantsToOpenRoleSelection() {
        rootCoordinator?.openRoleSelection()
    }
}

extension TeacherCoordinator: AdminListModuleOutput {
    func moduleWantsToCloseAdminList() {
        settingsNavigationController.popViewController(animated: true)
    }
    
    
}


