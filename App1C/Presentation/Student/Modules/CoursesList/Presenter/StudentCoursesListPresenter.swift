//
//  StudentCoursesListPresenter.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import Foundation

class StudentCoursesListPresenter {
    weak var moduleOutput: StudentCoursesListModuleOutput?
    weak var viewInput: StudentCoursesListViewInput?
    
    private let gradesService: GradesServiceProtocol
    
    private var lastCourses: [StudentCourseModel] = []
    private var currentCourses: [StudentCourseModel] = []
    
    init(
        moduleOutput: StudentCoursesListModuleOutput,
        gradesService: GradesServiceProtocol
    ) {
        self.gradesService = gradesService
        self.moduleOutput = moduleOutput
    }
    
    private func getCourses() {
        gradesService.getGrades(studentID: TokenService.shared.id) { [weak self] result in
            switch result {
            case .success(let model):
                let lastCourses = model.lastSemesters.map({ StudentCourseModel(id: $0.courseID, title: $0.courseTitle, isOffline: $0.isOffline, isRetake: $0.isRetake, grade: GradeModel(grade: $0.grade ?? 0)) })
                let currentSemester = model.currentSemester.map({ StudentCourseModel(id: $0.courseID, title: $0.courseTitle, isOffline: $0.isOffline, isRetake: $0.isRetake, grade: GradeModel(grade: $0.grade ?? 0)) })
                self?.lastCourses = lastCourses
                self?.currentCourses = currentSemester
                DispatchQueue.main.async {
                    //self?.viewInput?.setupCourses(closedCourses: lastCourses, currentCourses: currentSemester)
                    self?.viewInput?.updateCourses(closedCourses: lastCourses, currentCourses: currentSemester)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load courses: \(error)")
            }
            
        }
    }
}

extension StudentCoursesListPresenter: StudentCoursesListViewOutput {
    func viewIsReady() {
        getCourses()
    }
    
    func selectClosedCourse(at index: Int) {
        moduleOutput?.moduleWantsToOpenCourse(id: lastCourses[index].id)
    }
    
    func selectCurrentCourse(at index: Int) {
        moduleOutput?.moduleWantsToOpenCourse(id: currentCourses[index].id)
    }
}
