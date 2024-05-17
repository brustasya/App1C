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
        let presenter = AdminListPresenter(
            moduleOutput: moduleOutput,
            usersListService: serviceAssembly.makeUsersListService())
        let vc = PersonListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeCourseStudentsListModule(moduleOutput: CourseStudentsListModuleOutput, courseID: Int, courseTitle: String) -> UIViewController {
        let presenter = CourseStudentsListPresenter(
            moduleOutput: moduleOutput,
            usersListService: serviceAssembly.makeUsersListService(),
            courseID: courseID,
            courseTitle: courseTitle
        )
        let vc = CoursePersonListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeCourseTeachersListModule(moduleOutput: CourseTeachersListModuleOutput, courseID: Int, courseTitle: String) -> UIViewController {
        let presenter = CourseTeachersListPresenter(
            moduleOutput: moduleOutput,
            usersListService: serviceAssembly.makeUsersListService(),
            courseID: courseID,
            courseTitle: courseTitle
        )
        let vc = CoursePersonListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeCourseDependensiesModule(moduleOutput: CourseDependensiesModuleOutput, courseID: Int, courseTitle: String) -> UIViewController {
        let presenter = CourseDependensiesPresenter(
            moduleOutput: moduleOutput,
            coursesService: serviceAssembly.makeCoursesService(),
            courseID: courseID,
            courseTitle: courseTitle
        )
        let vc = CourseDependensiesViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeNotificationsModule(moduleOutput: NotificationsModuleOutput) -> UIViewController {
        let presenter = NotificationsPresenter(
            moduleOutput: moduleOutput,
            eventsService: serviceAssembly.makeEventsService())
        let vc = NotificationsViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeNotificationModule(id: Int, moduleOutput: NotificationModuleOutput) -> UIViewController {
        let presenter = NotificationPresenter(
            id: id,
            moduleOutput: moduleOutput,
            eventsService: serviceAssembly.makeEventsService(), 
            coursesService: serviceAssembly.makeCoursesService()
        )
        let vc = EventViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeAdminDetailsModule(for id: Int) -> UIViewController {
        let presenter = AdminDetailsPresenter(
            id: id,
            profileService: serviceAssembly.makeProfileService()
        )
        let vc = ProfileViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeStudentProfileModule(for id: Int, moduleOutput: StudentDetailsModuleOutput) -> UIViewController {
        let presenter = StudentPersonalDataPresenter(
            id: id, 
            profileService: serviceAssembly.makeProfileService(),
            moduleOutput: moduleOutput
        )
        let vc = ProfileViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeCourseEditModule(id: Int) -> UIViewController {
        let presenter = EditCoursePresenter(
            id: id,
            coursesService: serviceAssembly.makeCoursesService()
        )
        let vc = CourseViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeDepartmentCoursesModule(moduleOutput: AdminDepartmentCoursesModuleOutput) -> UIViewController {
        let presenter = AdminDepartmentCoursesPresenter(
            moduleOutput: moduleOutput,
            coursesService: serviceAssembly.makeCoursesService()
        )
        let vc = CoursesListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeTeacherProfileModule(for id: Int) -> UIViewController {
        let presenter = TeacherPersonalDataPresenter(
            id: id,
            profileService: serviceAssembly.makeProfileService()
        )
        let vc = ProfileViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeCourseDetailesModule(id: Int, isEditEnable: Bool = false, moduleOutput: CourseDetailesModuleOutput) -> UIViewController {
        let presenter = CourseDetailesPresenter(
            id: id,
            isEditEnable: isEditEnable,
            moduleOutput: moduleOutput,
            coursesService: serviceAssembly.makeCoursesService()
        )
        let vc = CourseViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
}
