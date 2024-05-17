//
//  CoursesAgregationPresenter.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import UIKit

class CoursesAgregationPresenter {
    
    weak var moduleOutput: CoursesAgregationModuleOutput?
    weak var viewInput: CoursesAgregationViewInput?
    
    private let coursesAggregationService: CoursesAggregationServiceProtocol
    
    init(
        moduleOutput: CoursesAgregationModuleOutput,
        coursesAggregationService: CoursesAggregationServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.coursesAggregationService = coursesAggregationService
    }
    
    private func getCourses() {
        coursesAggregationService.aggregation() { [weak self] result in
            switch result {
            case .success(let model):
                let courses = model.courses.map({
                    CourseAgregationModel(id: $0.id, title: $0.title, offline: $0.offline ?? 0,
                                          online: $0.online ?? 0, isStarted: $0.isStarted ?? false)
                })
                DispatchQueue.main.async {
                    self?.viewInput?.updateCourses(courses: courses)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load courses: \(error)")
            }
        }
    }
    
    private func verdict(id: Int, model: VerdictModel) {
        coursesAggregationService.verdict(id: id, model: model) { result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success verdict")
            case .failure(let error):
                Logger.shared.printLog(log: "Failed verdict: \(error)")
            }
        }
    }
    
    private func startChoosen() {
        coursesAggregationService.startChosen() { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success start choosen")
                DispatchQueue.main.async {
                    self?.viewIsReady()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed start choosen: \(error)")
            }
        }
    }
}

extension CoursesAgregationPresenter: CoursesAgregationViewOutput {
    func openCourse(id: Int, navigationController: UINavigationController?) {
        moduleOutput?.moduleWantsToOpenCourse(for: id, navigationController: navigationController)
    }
    
    func selectCourse(id: Int, isSelect: Bool) {
        let model = VerdictModel(verdict: isSelect)
        verdict(id: id, model: model)
    }
    
    func startChoosenButtonTapped() {
        startChoosen()
    }
    
    func viewIsReady() {
        getCourses()
    }
}
