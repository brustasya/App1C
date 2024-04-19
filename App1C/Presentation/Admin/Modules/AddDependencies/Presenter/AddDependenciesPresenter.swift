//
//  AddDependenciesPresenter.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

class AddDependenciesPresenter {
    weak var viewInput: AddDependenciesViewInput?
    weak var delegate: CourseDelegate?
    
    private let id: Int
    private let coursesService: CoursesServiceProtocol
    
    private lazy var courses: [Int] = []
    
    init(
        id: Int,
        coursesService: CoursesServiceProtocol
    ) {
        self.id = id
        self.coursesService = coursesService
    }
    
    private func changeCourses() {
        coursesService.changeDeps(courseID: id, deps: courses) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success change deps")
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed change deps: \(error)")
            }
        }
    }
    
    private func getCourses() {
        coursesService.getDeps(courseID: id) { [weak self] result in
            switch result {
            case .success(let model):
                let courses = model.courses.map({
                    AddDependenceModel(id: $0.id, title: $0.title, isCourseDependency: $0.isCourseDependency)
                })
                for course in courses {
                    if course.isCourseDependency {
                        self?.courses.append(course.id)
                    }
                }
                DispatchQueue.main.async {
                    self?.viewInput?.updateCourses(with: courses)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load deps: \(error)")
            }
            
        }
    }
}

extension AddDependenciesPresenter: AddDependenciesViewOutput {
    func viewIsReady() {
        getCourses()
    }
    
    func addCourse(id: Int) {
        courses.append(id)
    }
    
    func removeCourse(id: Int) {
        courses.removeAll { $0 == id }
    }
    
    func addButtonTapped() {
        if id >= 0 {
            changeCourses()
        } else {
            delegate?.addCourses(courses: courses)
            viewInput?.close()
        }
    }
}
