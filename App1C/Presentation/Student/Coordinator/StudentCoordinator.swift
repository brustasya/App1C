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
    private var coursesListNavigationController = UINavigationController()
    private var tripViewController: UIViewController = UIViewController()
    private var profileEditingViewController: UIViewController = UIViewController()
    private var passengerTripViewController: UIViewController = UIViewController()
    private var ratingViewController: UIViewController = UIViewController()
    
    init(studentAssembly: StudentAssembly) {
        self.studentAssembly = studentAssembly
    }
    
    func start(in window: UIWindow?) {
        let mainScreenVC = studentAssembly.makeMainScreenModule(moduleOutput: self)
        mainScreenNavigationController = CustomNavigationController(rootViewController: mainScreenVC)
        
        let settingsVC = studentAssembly.makeSettingsModule(moduleOutput: self)
        self.settingsNavigationController = CustomNavigationController(rootViewController: settingsVC)
        
        let coursesVC = studentAssembly.makeCoursesListModule(moduleOutput: self)
        coursesListNavigationController = CustomNavigationController(rootViewController: coursesVC)
        
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
        
    }
    
    func moduleWantsToOpenProfile() {
        let profileVC = studentAssembly.makeStudentProfileModule(for: TokenService.shared.id)
        settingsNavigationController.pushViewController(profileVC, animated: true)
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
    
    func moduleWantsToOpenAdminDetails(id: Int) {
        let adminVC = studentAssembly.makeAdminDetailsModule(for: id)
        settingsNavigationController.pushViewController(adminVC, animated: true)
    }
}

extension StudentCoordinator: TimeTableModuleOutput {
    func moduleWantsToCloseTimeTable() {
        mainScreenNavigationController.popViewController(animated: true)
    }
}

extension StudentCoordinator: StudentMainScreenModuleOutput {
    func moduleWantsToOpenEvent(id: Int) {
        let eventVC = studentAssembly.makeEventModule(id: id, moduleOutput: self)
        mainScreenNavigationController.pushViewController(eventVC, animated: true)
    }
    
    func moduleWantsToOpenTimeTable() {
        let timeTableVC = studentAssembly.makeTimeTableModule()
        mainScreenNavigationController.pushViewController(timeTableVC, animated: true)
    }
}

extension StudentCoordinator: StudentEventModuleOutput {
    func moduleWantsToOpenCourseSelection() {
        let courseSelectionVC = studentAssembly.makeCourseSelectionModule()
        mainScreenNavigationController.pushViewController(courseSelectionVC, animated: true)
    }
    
    func moduleWantsToOpenFinalCourseSelection() {
        let courseSelectionVC = studentAssembly.makeFinalCourseSelectionModule()
        mainScreenNavigationController.pushViewController(courseSelectionVC, animated: true)
    }
}

extension StudentCoordinator: StudentCoursesListModuleOutput {
    func moduleWantsToOpenCourse(id: Int) {
        
    }
}
