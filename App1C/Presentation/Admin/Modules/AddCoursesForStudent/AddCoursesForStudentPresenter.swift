//
//  AddCoursesForStudentPresenter.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import Foundation

class AddCoursesForStudentPresenter {
    weak var viewInput: AddDependenciesViewInput?
    
    private let studentID: Int
    private let coursesService: CoursesServiceProtocol
    
    private lazy var courses: [AddStudentCourseModel] = []
    
    init(
        studentID: Int,
        coursesService: CoursesServiceProtocol
    ) {
        self.studentID = studentID
        self.coursesService = coursesService
    }
    
    private func changeCourses() {
        let model = AddStudentCoursesModel(courses: courses)
        coursesService.addCourses(studentID: studentID, courses: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success change courses")
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed change courses: \(error)")
            }
        }
    }
    
    private func getCourses() {
        coursesService.getCourses(studentID: studentID) { [weak self] result in
            switch result {
            case .success(let model):
                let courses = model.closedNotCounted.map({
                    AddDependenceModel(id: $0.id, title: $0.title, isCourseDependency: false)
                }) +
                model.startedNotClosed.map({
                    AddDependenceModel(id: $0.id, title: $0.title, isCourseDependency: false)
                })
                
                DispatchQueue.main.async {
                    self?.viewInput?.updateCourses(with: courses)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load courses: \(error)")
            }
            
        }
    }
}

extension AddCoursesForStudentPresenter: AddDependenciesViewOutput {
    func viewIsReady() {
        viewInput?.setTitle(title: "Добавить курсы")
        getCourses()
    }
    
    func addCourse(id: Int) {
        courses.append(AddStudentCourseModel(id: id, shouldCloseDependencies: false))
    }
    
    func removeCourse(id: Int) {
        courses.removeAll { $0.id == id }
    }
    
    func addButtonTapped() {
        changeCourses()
    }
}
