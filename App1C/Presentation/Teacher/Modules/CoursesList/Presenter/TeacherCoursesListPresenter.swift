//
//  TeacherCoursesListPresenter.swift
//  App1C
//
//  Created by Станислава on 16.05.2024.
//

import UIKit

class TeacherCoursesListPresenter {
    weak var moduleOutput: TeacherCoursesListModuleOutput?
    weak var viewInput: TeacherCoursesListViewInput?
    
    private let coursesService: CoursesServiceProtocol
    
    private var courses: [CourseModel] = []
    
    init(
        moduleOutput: TeacherCoursesListModuleOutput,
        coursesService: CoursesServiceProtocol
    ) {
        self.coursesService = coursesService
        self.moduleOutput = moduleOutput
    }
    
    private func getCourses() {
        coursesService.getTeacherCourses(teacherID: TokenService.shared.id) { [weak self] result in
            switch result {
            case .success(let model):
                let courses = model.courses.map({ CourseModel(id: $0.id, title: $0.title, isTeacherCourse: $0.isTeacherCourse ?? true, isCourseDependency: $0.isCourseDependency ?? false) })
                self?.courses = courses
                DispatchQueue.main.async {
                    self?.viewInput?.setupCourses(courses: courses)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load courses: \(error)")
            }
        }
    }
}

extension TeacherCoursesListPresenter: TeacherCoursesListViewOutput {
    func viewIsReady() {
        getCourses()
    }
    
    func selectCourse(index: Int, controller: UINavigationController?) {
        moduleOutput?.moduleWantsToOpenCourse(
            id: courses[index].id,
            isEditEnable: true,
            controller: controller
        )
    }
}
