//
//  AdminAssembly.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

final class AdminAssembly: BaseAssembly {
    
    override init(serviceAssembly: ServiceAssembly) {
        super.init(serviceAssembly: serviceAssembly)
    }
    
    func makeSettingsModule(moduleOutput: AdminSettingsModuleOutput) -> UIViewController {
        let presenter = AdminSettingsPresenter(moduleOutput: moduleOutput)
        let vc = AdminSettingsViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeMainScreenModule(moduleOutput: AdminMainScreenModuleOutput) -> UIViewController {
        let presenter = AdminMainScreenPresenter(
            moduleOutput: moduleOutput,
            mainScreenService: serviceAssembly.makeMainPageService()
        )
        let vc = AdminMainScreenController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeStudentsListModule(moduleOutput: StudentsListModuleOutput) -> UIViewController {
        let presenter = StudentsListPresenter(
            moduleOutput: moduleOutput,
            usersListService: serviceAssembly.makeUsersListService()
        )
        let vc = StudentsListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeAddStudentModule(moduleOutput: AddStudentModuleOutput) -> UIViewController {
        let presenter = AddStudentPresenter(
            moduleOutput: moduleOutput,
            userCreationService: serviceAssembly.makeUserCreationService()
        )
        let vc = AddPersonViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeAddTeacherModule(moduleOutput: AddTeacherModuleOutput) -> UIViewController {
        let presenter = AddTeacherPresenter(
            moduleOutput: moduleOutput,
            userCreationService: serviceAssembly.makeUserCreationService()
        )
        let vc = AddPersonViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeAddAdminModule(moduleOutput: AddAdminModuleOutput) -> UIViewController {
        let presenter = AddAdminPresenter(
            moduleOutput: moduleOutput,
            userCreationService: serviceAssembly.makeUserCreationService()
        )
        let vc = AddPersonViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeAdminListModule(moduleOutput: AdminsListForAdminModuleOutput) -> UIViewController {
        let presenter = AdminsListForAdminPresenter(
            moduleOutput: moduleOutput,
            usersListService: serviceAssembly.makeUsersListService()
        )
        let vc = PersonListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeTeachersListModule(moduleOutput: TeachersListModuleOutput) -> UIViewController {
        let presenter = TeachersListPresenter(
            moduleOutput: moduleOutput,
            usersListService: serviceAssembly.makeUsersListService()
        )
        let vc = PersonListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeProfileModule() -> UIViewController {
        let presenter = AdminPersonalDataPresenter(
            id: TokenService.shared.id,
            profileService: serviceAssembly.makeProfileService()
        )
        let vc = ProfileViewController(output: presenter)
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
    
    func makeAddDependenciesModule(id: Int, delegate: CourseDelegate? = nil) -> UIViewController  {
        let presenter = AddDependenciesPresenter(
            id: id,
            coursesService: serviceAssembly.makeCoursesService()
        )
        let vc = AddDependenciesViewController(output: presenter)
        presenter.viewInput = vc
        presenter.delegate = delegate
        return vc
    }
    
    func makeAddTeachersModule(id: Int, delegate: CourseDelegate? = nil) -> UIViewController  {
        let presenter = AddTeachersPresenter(
            id: id,
            usersListService: serviceAssembly.makeUsersListService()
        )
        let vc = AddTeachersViewController(output: presenter)
        presenter.viewInput = vc
        presenter.delegate = delegate
        return vc
    }
    
    func makeAddCourseModule(moduleOutput: AddCourseModuleOutput) -> UIViewController {
        let presenter = AddCoursePresenter(
            moduleOutput: moduleOutput,
            coursesService: serviceAssembly.makeCoursesService()
        )
        let vc = CourseViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeEventsModule(moduleOutput: EventsModuleOutput) -> UIViewController {
        let presenter = EventsPresenter(
            moduleOutput: moduleOutput,
            eventsService: serviceAssembly.makeEventsService()
        )
        let vc = EventsViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
}
