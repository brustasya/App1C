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
        let settingsVC = teacherAssembly.makeSettingsModule(moduleOutput: self)
        self.settingsNavigationController = CustomNavigationController(rootViewController: settingsVC)
        let coursesVC = teacherAssembly.makeTeacherCoursesModule(moduleOutput: self)
        let coursesListNavigationController = CustomNavigationController(rootViewController: coursesVC)
        
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
    func moduleWantsToOpenAuthorization() {
        rootCoordinator?.openAuthorization()
    }
    
    func moduleWantsToOpenDepartmentCourses() {
        let coursesVC = teacherAssembly.makeDepartmentCoursesModule(moduleOutput: self)
        settingsNavigationController.pushViewController(coursesVC, animated: true)
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

extension TeacherCoordinator: AdminDepartmentCoursesModuleOutput {
    func moduleWantsToOPenAddCourse(navigationController: UINavigationController?) {}
    
    func moduleWantsToOpenCourse(for id: Int, navigationController: UINavigationController?) {
        let courseVC = teacherAssembly.makeCourseDetailesModule(id: id, isEditEnable: false, moduleOutput: self)
        settingsNavigationController.pushViewController(courseVC, animated: true)
    }
}

extension TeacherCoordinator: TeacherCoursesListModuleOutput {
    func moduleWantsToOpenCourse(id: Int, isEditEnable: Bool, controller: UINavigationController?) {
        let courseVC = teacherAssembly.makeCourseDetailesModule(id: id, isEditEnable: isEditEnable, moduleOutput: self)
        controller?.pushViewController(courseVC, animated: true)
    }
}

extension TeacherCoordinator: CourseDetailesModuleOutput {
    func moduleWantsToOpenStudents(courseID: Int, courseTitle: String, navigationController: UINavigationController?) {
        let studentsVC = teacherAssembly.makeCourseStudentsListModule(moduleOutput: self, courseID: courseID, courseTitle: courseTitle)
        navigationController?.pushViewController(studentsVC, animated: true)
    }
    
    func moduleWantsToOpenTeachers(courseID: Int, courseTitle: String, navigationController: UINavigationController?) {
        let teachersVC = teacherAssembly.makeCourseTeachersListModule(moduleOutput: self, courseID: courseID, courseTitle: courseTitle)
        navigationController?.pushViewController(teachersVC, animated: true)
    }
    
    func moduleWantsToOpenEditModule(id: Int, navigationController: UINavigationController?) {
        let editCourseVC = teacherAssembly.makeCourseEditModule(id: id)
        navigationController?.pushViewController(editCourseVC, animated: true)
    }
    
    func moduleWantsToOpenDeps(courseID: Int, courseTitle: String, navigationController: UINavigationController?) {
        let depsVC = teacherAssembly.makeCourseDependensiesModule(moduleOutput: self, courseID: courseID, courseTitle: courseTitle)
        navigationController?.pushViewController(depsVC, animated: true)
    }
}

extension TeacherCoordinator: CourseStudentsListModuleOutput {
    func moduleWantsToOpenStudent(studentID: Int, controller: UINavigationController?) {
        let studentVC = teacherAssembly.makeStudentProfileModule(for: studentID, moduleOutput: self)
        controller?.pushViewController(studentVC, animated: true)
    }
}

extension TeacherCoordinator: StudentDetailsModuleOutput {
    func moduleWantsToOpenGrades(studentID: Int, controller: UINavigationController?) { }
}

extension TeacherCoordinator: CourseTeachersListModuleOutput {
    func moduleWantsToOpenTeacher(teacherID: Int, controller: UINavigationController?) {
        let teacherVC = teacherAssembly.makeTeacherProfileModule(for: teacherID)
        controller?.pushViewController(teacherVC, animated: true)
    }
    
    func moduleWantsToAddTeachers(courseID: Int, controller: UINavigationController?) { }
    
}

extension TeacherCoordinator: CourseDependensiesModuleOutput {
    func moduleWantsToAddDependensies(courseID: Int, controller: UINavigationController?) {}
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
    func moduleWantsToOpenNotifications() {
        let notificationsVC = teacherAssembly.makeNotificationsModule(moduleOutput: self)
        mainScreenNavigationController.pushViewController(notificationsVC, animated: true)
    }
    
    func moduleWantsToOpenEvent(id: Int) {
        let teacherEventVC = teacherAssembly.makeEventModule(id: id, moduleOutput: self)
        mainScreenNavigationController.pushViewController(teacherEventVC, animated: true)
    }
}

extension TeacherCoordinator: NotificationsModuleOutput {
    func moduleWantsToOpenNotification(id: Int) {
        let notificationController = teacherAssembly.makeNotificationModule(id: id, moduleOutput: self)
        mainScreenNavigationController.pushViewController(notificationController, animated: true)
    }
    
    func moduleWantsToOpenThemeSelectionEvent(id: Int) {
    }
    
    func moduleWantsToOpenDiplomaSpeechEvent(id: Int) {
    }
}

extension TeacherCoordinator: NotificationModuleOutput {
    func moduleWantsToOpenCourseSelection() {}
    
    func moduleWantsToOpenFinalCourseSelection() {}
}

extension TeacherCoordinator: TeacherEventModuleOutput {
    func moduleWantsToOpenEstimation(courseID: Int, courseTitle: String) {
        let estimationVC = teacherAssembly.makeEstimationnModule(courseID: courseID, courseTitle: courseTitle)
        mainScreenNavigationController.pushViewController(estimationVC, animated: true)
    }
}
