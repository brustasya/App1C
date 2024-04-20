//
//  CourseSelectionPresenter.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

class CourseSelectionPresenter {
    weak var viewInput: CourseSelectionViewInput?
    
    private let courseSelectionService: CourseSelectionServiceProtocol
    var coursesDict: [Int: CourseSelectionModel] = [:]
        
    init(
        courseSelectionService: CourseSelectionServiceProtocol
    ) {
        self.courseSelectionService = courseSelectionService
    }
    
    private func treeBuilder(serviceModels: [CourseSelectionServiceModel]) -> [Int: CourseSelectionModel] {
        var coursesDict: [Int: CourseSelectionModel] = [:]
        for model in serviceModels {
            let course = CourseSelectionModel(id: model.id, title: model.title, closed: model.closed ?? false, wasInLoad: model.wasInLoad ?? false)
            coursesDict[model.id] = course
        }
        for model in serviceModels {
            let parent = coursesDict[model.id]
            for dep in model.dependencies {
                if let course = coursesDict[dep.id] {
                    course.parentCourse = parent
                    parent?.courseChildren.append(course)
                } else {
                    let course = CourseSelectionModel(id: dep.id, title: dep.title, closed: dep.closed)
                    coursesDict[dep.id] = course
                }
            }
        }
        return coursesDict
    }
    
    private func getCourses() {
        courseSelectionService.getPreliminaryChoise() { [weak self] result in
            switch result {
            case .success(let model):
                let dict = self?.treeBuilder(serviceModels: model.courses) ?? [:]
                DispatchQueue.main.async {
                    self?.viewInput?.setupAmount(amount: model.amount)
                    self?.viewInput?.updateCourses(coursesDict: dict)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load courses: \(error)")
            }
        }
    }
    
    private func selectCourses(model: SelectedCoursesModel) {
        courseSelectionService.preliminaryChoise(model: model) { [weak self] result in
            switch result {
            case .success(let model):
                Logger.shared.printLog(log: "Unselected courses: \(model)")
                DispatchQueue.main.async {
                    self?.viewInput?.close()
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed select courses: \(error)")
            }
            
        }
    }
}

extension CourseSelectionPresenter: CourseSelectionViewOutput {
    func viewIsReady() {
        getCourses()
    }
    
    func chooseButtonTapped(selectedCorses: [CourseSelectedModel]) {
        let selectedCorses = selectedCorses.map({
            SelectedCourseServiceModel(courseID: $0.id, takenAsLoad: $0.takenAsLoad, isOffline: $0.isOffline)
        })
        let model = SelectedCoursesModel(courses: selectedCorses)
        selectCourses(model: model)
    }
    
    
}
