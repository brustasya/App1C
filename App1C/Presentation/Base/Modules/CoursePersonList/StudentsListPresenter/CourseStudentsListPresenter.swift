//
//  CourseStudentsListPresenter.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

class CourseStudentsListPresenter {
    weak var viewInput: CoursePersonListViewInput?
    weak var moduleOutput: CourseStudentsListModuleOutput?
    
    private var students: [BaseModel] = []
    
    private let usersListService: UsersListServiceProtocol
    private let courseTitle: String
    private let courseID: Int
    
    init(
        moduleOutput: CourseStudentsListModuleOutput,
        usersListService: UsersListServiceProtocol,
        courseID: Int,
        courseTitle: String
    ) {
        self.moduleOutput = moduleOutput
        self.usersListService = usersListService
        self.courseID = courseID
        self.courseTitle = courseTitle
    }
    
    private func getStudents() {
        usersListService.getStudentsByCourse(courseID: courseID) { [weak self] result in
            switch result {
            case .success(let model):
                let students = model.students.map({
                    BaseModel(id: $0.id, title: $0.fullName, image: Images.largePerson.uiImage)
                })
                self?.students = students
                DispatchQueue.main.async {
                    self?.viewInput?.setupPersonTable(with: students, title: "Студенты")
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load students: \(failure)")
            }
        }
    }
}

extension CourseStudentsListPresenter: CoursePersonListViewOutput {
    func viewWillAppear() { }
    
    func viewIsReady() {
        viewInput?.updateTitle(title: courseTitle)
        getStudents()
    }
    
    func selectedRowAt(index: Int, controller: UINavigationController?) {
        moduleOutput?.moduleWantsToOpenStudent(studentID: students[index].id, controller: controller)
    }
    
    func addButtonTapped(controller: UINavigationController?) { }
    
}
