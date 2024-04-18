//
//  StudentCoordinator.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

final class StudentCoordinator: CoordinatorProtocol {
    private weak var window: UIWindow?
    weak var rootCoordinator: RootCoordinator?
    
    private let studentAssembly: StudentAssembly
    
    private var mainScreenNavigationController = UINavigationController()
    private var settingsNavigationController: UINavigationController = UINavigationController()
    private var tripViewController: UIViewController = UIViewController()
    private var profileEditingViewController: UIViewController = UIViewController()
    private var passengerTripViewController: UIViewController = UIViewController()
    private var ratingViewController: UIViewController = UIViewController()
    
    init(studentAssembly: StudentAssembly) {
        self.studentAssembly = studentAssembly
    }
    
    func start(in window: UIWindow?) {
        let mainScreenVC = StudentMainScreenController()//mainScreenAssembly.makeMainScreenModule(moduleOutput: self)
        mainScreenNavigationController = CustomNavigationController(rootViewController: mainScreenVC)
        let settingsVC = studentAssembly.makeSettingsModule(moduleOutput: self)
        self.settingsNavigationController = CustomNavigationController(rootViewController: settingsVC)
        let coursesListNavigationController = CustomNavigationController(rootViewController: StudentCoursesListViewController())
        
        let tabBarController = StudentTabBarController(
            mainScreenNavigationController: mainScreenNavigationController,
            coursesListNavigationController: coursesListNavigationController,
            settingsNavigationController: settingsNavigationController
        )
        
        window?.rootViewController = tabBarController
        self.window = window
    }
}

extension StudentCoordinator: StudentSettingsModuleOutput {
    func moduleWantsToOpenDepartmentCourses() {
        settingsNavigationController.pushViewController(CourseSelectionViewController(), animated: true)
    }
    
    func moduleWantsToOpenProfile() {
        settingsNavigationController.pushViewController(ProfileViewController(), animated: true)
    }
    
    func moduleWantsToOpenAdminList() {
        let vc = studentAssembly.makeAdminListModule(moduleOutput: self)
        settingsNavigationController.pushViewController(vc, animated: true)
    }
    
    func moduleWantsToOpenRoleSelection() {
        rootCoordinator?.openRoleSelection()
    }
}

extension StudentCoordinator: AdminListModuleOutput {
    func moduleWantsToCloseAdminList() {
        settingsNavigationController.popViewController(animated: true)
    }
}

extension StudentCoordinator: TimeTableModuleOutput {
    func moduleWantsToCloseTimeTable() {
        mainScreenNavigationController.popViewController(animated: true)
    }
}
