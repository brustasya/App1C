//
//  AddCoursePresenter.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

class AddCoursePresenter {
    weak var viewInput: CourseViewInput?
    weak var moduleOutput: AddCourseModuleOutput?
    
    private let coursesService: CoursesServiceProtocol
    
    private lazy var teachers: [Int] = []
    private lazy var courses: [Int] = []
    
    init(
        moduleOutput: AddCourseModuleOutput,
        coursesService: CoursesServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.coursesService = coursesService
    }
    
    func addCourse(model: CreateCourseModel) {
        coursesService.createCourse(model: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success create course")
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed create course: \(error)")
            }
        }
    }
}

protocol CourseDelegate: AnyObject {
    func addTeachers(teachers: [Int])
    func addCourses(courses: [Int])
}

extension AddCoursePresenter: CourseDelegate {
    func addTeachers(teachers: [Int]) {
        self.teachers = teachers
    }
    
    func addCourses(courses: [Int]) {
        self.courses = courses
    }
}

extension AddCoursePresenter: CourseViewOutput {
    func viewWillAppear() { }
    
    
    func viewIsReady() {
        viewInput?.setupAddMode()
       // viewInput?.setupReadMode()
        //viewInput?.setupEditMode()
    }
    
    func addDepsButtonTapped() {
        moduleOutput?.moduleWantsToOpenAddDeps(delegate: self)
    }
    
    func addTeachersButtonTapped() {
        moduleOutput?.moduleWantsToOpenAddTeachers(delegate: self)
    }
    
    func addButtonTapped(name: String, chat: String, type: String, descr: String) {
        let model = CreateCourseModel(
            title: name,
            description: descr,
            chat: chat,
            dependencies: courses,
            teachers: teachers,
            type: type
        )
        addCourse(model: model)
    }
    
    func editButtonTapped(navigationController: UINavigationController?) { }
    
    func saveButtonTapped(name: String, chat: String, type: String, dayOfWeek: String,
                          from: Date?, to: Date?, descr: String) { }
    
    func selectItem(id: Int, navigationController: UINavigationController?) { }
}
