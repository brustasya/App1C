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
        let diplomaVC = studentAssembly.makeDiplomaModule()
        let diplomaNavigationController = CustomNavigationController(rootViewController: diplomaVC)
        
        let tabBarController = StudentTabBarController(
            mainScreenNavigationController: mainScreenNavigationController,
            coursesListNavigationController: coursesListNavigationController, 
            diplomaNavigationController: diplomaNavigationController,
            settingsNavigationController: settingsNavigationController
        )
        
        window?.rootViewController = tabBarController
        self.window = window
    }
}

extension StudentCoordinator: StudentDetailsModuleOutput {
    func moduleWantsToOpenGrades(studentID: Int, controller: UINavigationController?) { }
}

extension StudentCoordinator: AdminDepartmentCoursesModuleOutput {
    func moduleWantsToOPenAddCourse(navigationController: UINavigationController?) {}
}

extension StudentCoordinator: StudentSettingsModuleOutput {
    func moduleWantsToOpeAuthorization() {
        rootCoordinator?.openAuthorization()
    }
    
    func moduleWantsToOpenDepartmentCourses() {
        let coursesVC = studentAssembly.makeDepartmentCoursesModule(moduleOutput: self)
        settingsNavigationController.pushViewController(coursesVC, animated: true)
    }
    
    func moduleWantsToOpenProfile() {
        let profileVC = studentAssembly.makeStudentProfileModule(for: TokenService.shared.id, moduleOutput: self)
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
    func moduleWantsToOpenThemeSelectionEvent(id: Int) {
        let eventVC = studentAssembly.makeThemeSelectionEventModule(id: id)
        mainScreenNavigationController.pushViewController(eventVC, animated: true)
    }
    
    func moduleWantsToOpenDiplomaSpeechEvent(id: Int) {
        let eventVC = studentAssembly.makeDiplomaSpeechEventModule(id: id)
        mainScreenNavigationController.pushViewController(eventVC, animated: true)
    }
    
    func moduleWantsToOpenNotifications() {
        let notificationsVC = studentAssembly.makeNotificationsModule(moduleOutput: self)
        mainScreenNavigationController.pushViewController(notificationsVC, animated: true)
    }
    
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
        let courseSelectionVC = studentAssembly.makeCourseSelectionModule(moduleOutput: self)
        mainScreenNavigationController.pushViewController(courseSelectionVC, animated: true)
    }
    
    func moduleWantsToOpenFinalCourseSelection() {
        let courseSelectionVC = studentAssembly.makeFinalCourseSelectionModule(moduleOutput: self)
        mainScreenNavigationController.pushViewController(courseSelectionVC, animated: true)
    }
}

extension StudentCoordinator: StudentCoursesListModuleOutput, FinalCourseSelectionModuleOutput, CourseSelectionModuleOutput {
    func moduleWantsToOpenCourse(for id: Int, navigationController: UINavigationController?) {
        let courseVC = studentAssembly.makeCourseDetailesModule(id: id, moduleOutput: self)
        navigationController?.pushViewController(courseVC, animated: true)
    }
}

extension StudentCoordinator: CourseDetailesModuleOutput {
    func moduleWantsToOpenStudents(courseID: Int, courseTitle: String, navigationController: UINavigationController?) {
        let studentsVC = studentAssembly.makeCourseStudentsListModule(moduleOutput: self, courseID: courseID, courseTitle: courseTitle)
        navigationController?.pushViewController(studentsVC, animated: true)
    }
    
    func moduleWantsToOpenTeachers(courseID: Int, courseTitle: String, navigationController: UINavigationController?) {
        let teachersVC = studentAssembly.makeCourseTeachersListModule(moduleOutput: self, courseID: courseID, courseTitle: courseTitle)
        navigationController?.pushViewController(teachersVC, animated: true)
    }
    
    func moduleWantsToOpenEditModule(id: Int, navigationController: UINavigationController?) {
        let editCourseVC = studentAssembly.makeCourseEditModule(id: id)
        navigationController?.pushViewController(editCourseVC, animated: true)
    }
    
    func moduleWantsToOpenDeps(courseID: Int, courseTitle: String, navigationController: UINavigationController?) {
        let depsVC = studentAssembly.makeCourseDependensiesModule(moduleOutput: self, courseID: courseID, courseTitle: courseTitle)
        navigationController?.pushViewController(depsVC, animated: true)
    }
}

extension StudentCoordinator: CourseStudentsListModuleOutput {
    func moduleWantsToOpenStudent(studentID: Int, controller: UINavigationController?) {
        let studentVC = studentAssembly.makeStudentProfileModule(for: studentID, moduleOutput: self)
        controller?.pushViewController(studentVC, animated: true)
    }
}


extension StudentCoordinator: CourseTeachersListModuleOutput {
    func moduleWantsToOpenTeacher(teacherID: Int, controller: UINavigationController?) {
        let teacherVC = studentAssembly.makeTeacherProfileModule(for: teacherID)
        controller?.pushViewController(teacherVC, animated: true)
    }
    
    func moduleWantsToAddTeachers(courseID: Int, controller: UINavigationController?) { }
    
}

extension StudentCoordinator: CourseDependensiesModuleOutput {
    func moduleWantsToAddDependensies(courseID: Int, controller: UINavigationController?) {}
}

extension StudentCoordinator: NotificationsModuleOutput {
    func moduleWantsToOpenNotification(id: Int) {
        let notificationController = studentAssembly.makeNotificationModule(id: id, moduleOutput: self)
        mainScreenNavigationController.pushViewController(notificationController, animated: true)
    }
}

extension StudentCoordinator: NotificationModuleOutput {
    func moduleWantsToOpenEstimation(courseID: Int, courseTitle: String) {}    
}
