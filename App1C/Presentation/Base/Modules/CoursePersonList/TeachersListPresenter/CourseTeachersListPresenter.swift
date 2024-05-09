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
                let courseTeachers = model.teachers.filter({ $0.teachCourse ?? false })
                let teachers = courseTeachers.map({
                    BaseModel(id: $0.id, title: $0.fullName, image: Images.largePerson.uiImage)
                })
                self?.teachers = teachers
                DispatchQueue.main.async {
                    self?.viewInput?.updatePersons(with: teachers)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load teachers: \(failure)")
            }
        }
    }
}

extension CourseTeachersListPresenter: CoursePersonListViewOutput {
    func viewWillAppear() {
        getTeachers()
    }
    
    func viewIsReady() {
        viewInput?.updateTitle(title: courseTitle)
        viewInput?.setupPersonTable(with: teachers, title: "Преподаватели")
        if TokenService.shared.role == .admin {
            viewInput?.setupAddButton(title: "Добавить преподавателей")
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

