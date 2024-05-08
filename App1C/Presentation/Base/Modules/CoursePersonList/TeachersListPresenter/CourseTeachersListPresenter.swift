//
//  CourseTeachersListPresenter.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

class CourseTeachersListPresenter {
    weak var viewInput: CoursePersonListViewInput?
    weak var moduleOutput: CourseTeachersListModuleOutput?
    
    private var teachers: [BaseModel] = []
    
    private let usersListService: UsersListServiceProtocol
    private let courseTitle: String
    private let courseID: Int
    
    init(
        moduleOutput: CourseTeachersListModuleOutput,
        usersListService: UsersListServiceProtocol,
        courseID: Int,
        courseTitle: String
    ) {
        self.moduleOutput = moduleOutput
        self.usersListService = usersListService
        self.courseID = courseID
        self.courseTitle = courseTitle
    }
    
    private func getTeachers() {
        usersListService.getTeachers(courseID: courseID) { [weak self] result in
            switch result {
            case .success(let model):
                let teachers = model.teachers.map({
                    BaseModel(id: $0.id, title: $0.fullName, image: Images.largePerson.uiImage)
                })
                self?.teachers = teachers
                DispatchQueue.main.async {
                    self?.viewInput?.setupPersonTable(with: teachers, title: "Преподаватели")
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load teachers: \(failure)")
            }
        }
    }
}

extension CourseTeachersListPresenter: CoursePersonListViewOutput {
    func viewIsReady() {
        viewInput?.updateTitle(title: courseTitle)
        if TokenService.shared.role == .admin {
            viewInput?.setupAddButton(title: "Добавить преподавателя")
        }
        getTeachers()
    }
    
    func selectedRowAt(index: Int, controller: UINavigationController?) {
        moduleOutput?.moduleWantsToOpenTeacher(teacherID: teachers[index].id, controller: controller)
    }
    
    func addButtonTapped(controller: UINavigationController?) { 
        moduleOutput?.moduleWantsToAddTeachers(courseID: courseID, controller: controller)
    }
    
}

