//
//  EstimationPresenter.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import Foundation

class EstimationPresenter {
    weak var viewInput: EstimationViewInput?
    
    private let gradesService: GradesServiceProtocol
    private let usersListService: UsersListServiceProtocol
    private let courseID: Int
    private let courseTitle: String
    private var eventType: EventType = .estimating
    private var finishEstimatiom = false
    
    init(
        courseID: Int,
        courseTitle: String,
        usersListService: UsersListServiceProtocol,
        gradesService: GradesServiceProtocol
    ) {
        self.courseID = courseID
        self.courseTitle = courseTitle
        self.gradesService = gradesService
        self.usersListService = usersListService
    }
    
    private func estimate(studentID: Int, model: EstimateServerModel) {
        gradesService.estimate(courseID: courseID, studentID: studentID, model: model) { result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success estimate")
            case .failure(let error):
                Logger.shared.printLog(log: "Failed estimate: \(error)")
            }
        }
    }
    
    private func finishEstimation() {
        gradesService.finishEstimation(courseID: courseID) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success finish Estimation")
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed finish Estimation: \(error)")
            }
        }
    }
    
    private func getGrades() {
        usersListService.getStudentsByCourse(courseID: courseID) {
            [weak self] result in
            switch result {
            case .success(let model):
                let students = model.students.map({ EstimationModel(studentID: $0.id, gradeID: 0, name: $0.fullName, grade: GradeModel(grade: $0.grade ?? 0)) })
                self?.finishEstimatiom = model.estimationFinished ?? false
                DispatchQueue.main.async {
                    self?.viewInput?.setupGrades(grades: students)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load students: \(error)")
            }
        }
    }
}

extension EstimationPresenter: EstimationViewOutput {
    func viewIsReady() {
        viewInput?.setTitle(title: courseTitle)
        getGrades()
    }
    
    func finishEstimating() {
        finishEstimation()
    }
    
    func estimate(id: Int, grade: Int) {
        let model = EstimateServerModel(grade: grade, isRetake: false)
        estimate(studentID: id, model: model)
    }
}
