//
//  CoursesEstimatingPresenter.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import UIKit

class CoursesEstimatingPresenter {
    weak var moduleOutput: CoursesEstimatingModuleOutput?
    weak var viewInput: CoursesEstimatingViewInput?
    
    private let gradesService: GradesServiceProtocol
    private let studentID: Int
    
    init(
        studentID: Int,
        moduleOutput: CoursesEstimatingModuleOutput,
        gradesService: GradesServiceProtocol
    ) {
        self.studentID = studentID
        self.gradesService = gradesService
        self.moduleOutput = moduleOutput
    }
    
    private func estimate(courseID: Int, model: EstimateServerModel) {
        gradesService.estimate(courseID: courseID, studentID: studentID, model: model) { [weak self] result in
            switch result {
            case .success(_):
                self?.getCourses()
                Logger.shared.printLog(log: "Success estimate")
            case .failure(let error):
                Logger.shared.printLog(log: "Failed estimate: \(error)")
            }
        }
    }
    
    private func getCourses() {
        gradesService.getGrades(studentID: studentID) { [weak self] result in
            switch result {
            case .success(let model):
                var lastCourses = model.lastSemesters.map({ StudentCourseModel(id: $0.courseID, title: $0.courseTitle, isOffline: $0.isOffline, isRetake: $0.isRetake, wasInLoad: $0.inLoad, grade: GradeModel(grade: $0.grade ?? 0)) })
                var currentSemester = model.currentSemester.map({ StudentCourseModel(id: $0.courseID, title: $0.courseTitle, isOffline: $0.isOffline, isRetake: $0.isRetake, wasInLoad: $0.inLoad, grade: GradeModel(grade: $0.grade ?? 0)) })
                var unusedCourses = model.unusedCourses.map({ StudentCourseModel(id: $0.courseID, title: $0.courseTitle, isOffline: $0.isOffline, isRetake: $0.isRetake, wasInLoad: $0.inLoad, grade: GradeModel(grade: $0.grade ?? 0)) })
                
                lastCourses = lastCourses.sorted(by: {$0.id > $1.id})
                currentSemester = currentSemester.sorted(by: {$0.id > $1.id})
                unusedCourses = unusedCourses.sorted(by: {$0.id > $1.id})
               
                DispatchQueue.main.async {
                    self?.viewInput?.setupCourses(lastCourses: lastCourses, currentCourses: currentSemester, unusedCourses: unusedCourses)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load courses: \(error)")
            }
        }
    }
}

extension CoursesEstimatingPresenter: CoursesEstimatingViewOutput {
    func addButtonTapped(controller: UINavigationController?) {
        moduleOutput?.moduleWantsToAddCourses(studentID: studentID, controller: controller)
    }
    
    func setGrade(courseId: Int, grade: Int, isRetake: Bool) {
        let model = EstimateServerModel(grade: grade, isRetake: isRetake)
        estimate(courseID: courseId, model: model)
    }
    
    func viewIsReady() {
        getCourses()
    }
}
