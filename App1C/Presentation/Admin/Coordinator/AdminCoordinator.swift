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
    private var eventsNavigationController = UINavigationController()
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
        
        let settingsVC = adminAssembly.makeSettingsModule(moduleOutput: self)
        self.settingsNavigationController = CustomNavigationController(rootViewController: settingsVC)
        
        let eventsVC = adminAssembly.makeEventsModule(moduleOutput: self)
        eventsNavigationController = CustomNavigationController(rootViewController: eventsVC)
        
        let tabBarController = AdminTabBarController(
            mainScreenNavigationController: mainScreenNavigationController,
            eventsNavigationController: eventsNavigationController,
            settingsNavigationController: settingsNavigationController
        )
        
        window?.rootViewController = tabBarController
        self.window = window
    }
}

extension AdminCoordinator: EventsModuleOutput {
    func moduleWantsToCreateEvent(type: EventType) {
        let createEventVC = adminAssembly.makeCreateEventModule(eventType: type)
        eventsNavigationController.pushViewController(createEventVC, animated: true)
    }
    
    func moduleWantsToOpenEvent(id: Int) {
        let modifyVC = adminAssembly.makeModifyModule(id: id)
        eventsNavigationController.pushViewController(modifyVC, animated: true)
    }

}

extension AdminCoordinator: AdminDepartmentCoursesModuleOutput {
    func moduleWantsToOPenAddCourse(navigationController: UINavigationController?) {
        let addCourseVC = adminAssembly.makeAddCourseModule(moduleOutput: self)
        navigationController?.pushViewController(addCourseVC, animated: true)
    }
    
    func moduleWantsToOpenCourse(for id: Int, navigationController: UINavigationController?) {
        let courseVC = adminAssembly.makeCourseDetailesModule(id: id, moduleOutput: self)
        navigationController?.pushViewController(courseVC, animated: true)
    }
}

extension AdminCoordinator: CourseDetailesModuleOutput {
    func moduleWantsToOpenEditModule(id: Int, navigationController: UINavigationController?) {
        let editCourseVC = adminAssembly.makeCourseEditModule(id: id)
        navigationController?.pushViewController(editCourseVC, animated: true)
    }
    
    func moduleWantsToOpenDeps(navigationController: UINavigationController?) {
        
    }
    
    func moduleWantsToOpenStudents(navigationController: UINavigationController?) {
        
    }
    
    func moduleWantsToOpenTeachers(navigationController: UINavigationController?) {
        
    }
    
}

extension AdminCoordinator: DiplomaThemesModuleOutput {
    
}

extension AdminCoordinator: AdminSettingsModuleOutput {
    func moduleWantsToOpenDiplomaThemes() {
        let diplomaThemesVC = adminAssembly.makeDiplomaThemesModule(moduleOutput: self)
        settingsNavigationController.pushViewController(diplomaThemesVC, animated: true)
    }
    
    func moduleWantsToOpenSRWResults() {
        
    }
    
    func moduleWantsToOpenSRWGrades() {
        
    }
    
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
        let profileVC = adminAssembly.makeProfileModule() //AddTeachersViewController()//AddDependenciesViewController()//FinalCourseSelectionViewController()//
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
    func moduleWantsToOpenCourses() {
        let depCoursesVC = adminAssembly.makeDepartmentCoursesModule(moduleOutput: self)
        mainScreenNavigationController.pushViewController(depCoursesVC, animated: true)
    }
    
    func moduleWantsToOpenCourseAggregation() {
        let courseAggregationVC = adminAssembly.makeCoursesAgregationModule()
        mainScreenNavigationController.pushViewController(courseAggregationVC, animated: true)
    }
    
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

extension AdminCoordinator: AddCourseModuleOutput {
    func moduleWantsToOpenAddDeps(delegate: CourseDelegate) {
        let addDepsVC = adminAssembly.makeAddDependenciesModule(id: -1, delegate: delegate)
        settingsNavigationController.pushViewController(addDepsVC, animated: true)
    }
    
    func moduleWantsToOpenAddTeachers(delegate: CourseDelegate) {
        let addTeachersVC = adminAssembly.makeAddTeachersModule(id: -1, delegate: delegate)
        settingsNavigationController.pushViewController(addTeachersVC, animated: true)
    }
}

