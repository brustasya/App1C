//
//  AddTeachersPresenter.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

class AddTeachersPresenter {
    weak var viewInput: AddTeachersViewInput?
    weak var delegate: CourseDelegate?
    
    private let id: Int
    private let usersListService: UsersListServiceProtocol
    
    private lazy var teachers: [Int] = []
    
    init(
        id: Int,
        usersListService: UsersListServiceProtocol
    ) {
        self.id = id
        self.usersListService = usersListService
    }
    
    private func changeTeachers() {
        usersListService.changeTeachers(id: id, teachers: teachers) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success change teachers")
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed change teachers: \(error)")
            }
        }
    }
    
    private func getTeachers() {
        usersListService.getTeachers(courseID: id) { [weak self] result in
            switch result {
            case .success(let model):
                let teachers = model.teachers.map({ AddTeacherModel(id: $0.id, title: $0.fullName, isTeacherCourse: $0.teachCourse ?? false) })
                for teacher in teachers {
                    if teacher.isTeacherCourse {
                        self?.teachers.append(teacher.id)
                    }
                }
                DispatchQueue.main.async {
                    self?.viewInput?.updateTeachers(with: teachers)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load teachers: \(error)")
            }
        }
    }
}

extension AddTeachersPresenter: AddTeachersViewOutput {
    func viewIsReady() {
        getTeachers()
    }
    
    func addTeacher(id: Int) {
        teachers.append(id)
    }
    
    func removeTeacher(id: Int) {
        teachers.removeAll { $0 == id }
    }
    
    func addButtonTapped() {
        if id >= 0 {
            changeTeachers()
        } else {
            delegate?.addTeachers(teachers: teachers)
            viewInput?.close()
        }
    }
}
