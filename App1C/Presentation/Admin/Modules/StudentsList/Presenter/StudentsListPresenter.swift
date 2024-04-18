//
//  StudentsListPresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

final class StudentsListPresenter {
    weak var viewInput: StudentsListViewInput?
    weak var moduleOutput: StudentsListModuleOutput?
        
    private let usersListService: UsersListServiceProtocol
    private var students: [BaseModel] = []
    
    init(
        moduleOutput: StudentsListModuleOutput,
        usersListService: UsersListServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.usersListService = usersListService
    }
    
    private func getStudents(for course: Int) {
        usersListService.getStudentsByYear(course: course) { [weak self] result in
            switch result {
            case .success(let model):
                let students = model.students.map({
                    BaseModel(id: $0.id, title: $0.fullName, image: Images.largePerson.uiImage)
                })
                self?.students = students
                DispatchQueue.main.async {
                    self?.viewInput?.setupStudents(students: students)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load students: \(failure)")
            }
        }
    }
}

extension StudentsListPresenter: StudentsListViewOutput {
    func selectStudent(at index: Int) {
        moduleOutput?.moduleWantsToOpenStudentDetails(for: students[index].id)
    }
    
    func selectCourse(at index: Int) {
        getStudents(for: index + 3)
    }
    
    func addStudent() {
        moduleOutput?.moduleWantsToOpenAddStudentModule()
    }
    
    func goBack() {
        moduleOutput?.moduleWantsToCloseStudentsList()
    }
    
    
}
