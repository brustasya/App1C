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
        let mainScreenVC = teacherAssembly.makeMainScreenModule(moduleOutput: self)
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
        
    }
    
    func moduleWantsToOpenProfile() {
        let profileVC = teacherAssembly.makeTeacherProfileModule(for: TokenService.shared.id)
        settingsNavigationController.pushViewController(profileVC, animated: true)
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
    
    func moduleWantsToOpenAdminDetails(id: Int) {
        let adminVC = teacherAssembly.makeAdminDetailsModule(for: id)
        settingsNavigationController.pushViewController(adminVC, animated: true)
    }
}

extension TeacherCoordinator: TeacherMainScreenModuleOutput {
    func moduleWantsToOpenEvent(id: Int) {
        let teacherEventVC = teacherAssembly.makeEventModule(id: id, moduleOutput: self)
        mainScreenNavigationController.pushViewController(teacherEventVC, animated: true)
    }
}

extension TeacherCoordinator: TeacherEventModuleOutput {
    func moduleWantsToOpenEstimation(courseID: Int, courseTitle: String) {
        let estimationVC = teacherAssembly.makeEstimationnModule(courseID: courseID, courseTitle: courseTitle)
        mainScreenNavigationController.pushViewController(estimationVC, animated: true)
    }
}
