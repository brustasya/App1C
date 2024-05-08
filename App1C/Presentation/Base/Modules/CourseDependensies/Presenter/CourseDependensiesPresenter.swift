//
//  CourseDependensiesPresenter.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

class CourseDependensiesPresenter {
    weak var viewInput: CourseDependensiesViewInput?
    weak var moduleOutput: CourseDependensiesModuleOutput?
    
    private var courses: [CourseModel] = []
    
    private let coursesService: CoursesServiceProtocol
    private let courseTitle: String
    private let courseID: Int
    
    init(
        moduleOutput: CourseDependensiesModuleOutput,
        coursesService: CoursesServiceProtocol,
        courseID: Int,
        courseTitle: String
    ) {
        self.moduleOutput = moduleOutput
        self.coursesService = coursesService
        self.courseID = courseID
        self.courseTitle = courseTitle
    }
    
    private func getCourses() {
        coursesService.getDeps(courseID: courseID) { [weak self] result in
            switch result {
            case .success(let model):
                var courses = model.courses.map({
                    CourseModel(id: $0.id, title: $0.title, isTeacherCourse: false, isCourseDependency: $0.isCourseDependency)
                })
                courses = courses.filter({ $0.isCourseDependency })
                self?.courses = courses
                DispatchQueue.main.async {
                    self?.viewInput?.updateCoursesTable(with: courses)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load courses: \(failure)")
            }
        }
    }
}

extension CourseDependensiesPresenter: CourseDependensiesViewOutput {
    func viewWillAppear() {
        getCourses()
    }
    
    func viewIsReady() {
        viewInput?.updateTitle(title: courseTitle)
        if TokenService.shared.role == .admin {
            viewInput?.setupEditMode()
        } else {
            viewInput?.setupBaseMode()
        }
        getCourses()
    }
    
    func addButtonTapped(controller: UINavigationController?) {
        moduleOutput?.addButtonTapped(courseID: courseID, controller: controller)
    }
    
}

