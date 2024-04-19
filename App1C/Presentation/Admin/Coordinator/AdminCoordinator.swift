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

extension AdminCoordinator: AdminDepartmentCoursesModuleOutput {
    func moduleWantsToOPenAddCourse() {
        settingsNavigationController.pushViewController(CourseViewController(), animated: true)
    }
    
    func moduleWantsToOpenCourse(for id: Int) {
        
    }
    
    
}

extension AdminCoordinator: AdminSettingsModuleOutput {
    func moduleWantsToOpenTeachersList() {
        let teachersList = adminAssembly.makeTeachersListModule(moduleOutput: self)
        settingsNavigationController.pushViewController(teachersList, animated: true)
    }
    
    func moduleWantsToOpenStudentsList() {
        let studentsListVC = adminAssembly.makeStudentsListModule(moduleOutput: self)
        settingsNavigationController.pushViewController(studentsListVC, animated: true)
    }
    
    func moduleWantsToOpenDepartmentCourses() {
        let coursesVC = adminAssembly.makeDepartmentCoursesModule(moduleOutput: self)
        settingsNavigationController.pushViewController(coursesVC, animated: true)
    }
    
    func moduleWantsToOpenProfile() {
        let profileVC = FinalCourseSelectionViewController()//adminAssembly.makeProfileModule()
        settingsNavigationController.pushViewController(profileVC, animated: true)
    }
    
    func moduleWantsToOpenAdminList() {
        let vc = adminAssembly.makeAdminListModule(moduleOutput: self)
        settingsNavigationController.pushViewController(vc, animated: true)
    }
    
    func moduleWantsToOpenRoleSelection() {
        rootCoordinator?.openRoleSelection()
    }
}

extension AdminCoordinator: TeachersListModuleOutput {
    func moduleWantsToOpenTeacherDetails(for id: Int) {
        let teacherVC = adminAssembly.makeTeacherProfileModule(for: id)
        settingsNavigationController.pushViewController(teacherVC, animated: true)
    }
    
    func moduleWantsToOpenAddTeacher() {
        let addTeacher = adminAssembly.makeAddTeacherModule(moduleOutput: self)
        settingsNavigationController.pushViewController(addTeacher, animated: true)
    }
    
    func moduleWantsToCloseTeachersList() {
        settingsNavigationController.popViewController(animated: true)
    }
}

extension AdminCoordinator: AddAdminModuleOutput {
    func moduleWantsToCloseAddAdmin() {
        settingsNavigationController.popViewController(animated: true)
    }
}

extension AdminCoordinator: AddTeacherModuleOutput {
    func moduleWantsToCloseAddTeacher() {
        settingsNavigationController.popViewController(animated: true)
    }
}

extension AdminCoordinator: AdminsListForAdminModuleOutput {
    func moduleWantsToOpenAdminDetails(id: Int) {
        let adminVC = adminAssembly.makeAdminDetailsModule(for: id)
        settingsNavigationController.pushViewController(adminVC, animated: true)
    }
    
    func moduleWantsToOpenAddAdmin() {
        let addAdminVC = adminAssembly.makeAddAdminModule(moduleOutput: self)
        settingsNavigationController.pushViewController(addAdminVC, animated: true)
    }
    
    func moduleWantsToCloseAdminList() {
        settingsNavigationController.popViewController(animated: true)
    }
}

extension AdminCoordinator: AdminMainScreenModuleOutput {
}

extension AdminCoordinator: StudentsListModuleOutput {
    func moduleWantsToOpenStudentDetails(for id: Int) {
        let studentVC = adminAssembly.makeStudentProfileModule(for: id)
        settingsNavigationController.pushViewController(studentVC, animated: true)
    }
    
    func moduleWantsToOpenAddStudentModule() {
        let addStudentVC = adminAssembly.makeAddStudentModule(moduleOutput: self)
        settingsNavigationController.pushViewController(addStudentVC, animated: true)
    }
    
    func moduleWantsToCloseStudentsList() {
        settingsNavigationController.popViewController(animated: true)
    }
}

extension AdminCoordinator: AddStudentModuleOutput {
    func moduleWantsToCloseAddStudent() {
        settingsNavigationController.popViewController(animated: true)
    }
}

