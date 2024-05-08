//
//  AdminDepartmentCoursesPresenter.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

final class AdminDepartmentCoursesPresenter {
    weak var viewInput: CoursesListViewInput?
    weak var moduleOutput: AdminDepartmentCoursesModuleOutput?
        
    private let coursesService: CoursesServiceProtocol
    private var courses: [CourseModel] = []
    
    init(
        moduleOutput: AdminDepartmentCoursesModuleOutput,
        coursesService: CoursesServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.coursesService = coursesService
    }
    
    private func getCourses() {
        coursesService.getCourses() { [weak self] result in
            switch result {
            case .success(let model):
                let courses = model.courses.map({
                    CourseModel(id: $0.id, title: $0.title,
                                isTeacherCourse: $0.isTeacherCourse ?? false, isCourseDependency: $0.isCourseDependency)
                })
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

extension AdminDepartmentCoursesPresenter: CoursesListViewOutput {
    func viewWillAppear() {
        getCourses()
    }
    
    func viewIsReady() {
        viewInput?.setupAdminMode()
        getCourses()
    }
    
    func addCourseButtonTapped(navigationController: UINavigationController?) {
        moduleOutput?.moduleWantsToOPenAddCourse(navigationController: navigationController)
    }
    
    func selectCourse(at index: Int, navigationController: UINavigationController?) {
        moduleOutput?.moduleWantsToOpenCourse(for: courses[index].id, navigationController: navigationController)
    }
    
    
}
