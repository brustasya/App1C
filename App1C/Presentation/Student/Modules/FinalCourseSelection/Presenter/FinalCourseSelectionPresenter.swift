//
//  FinalCourseSelectionPresenter.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import UIKit

class FinalCourseSelectionPresenter {
    weak var viewInput: FinalCourseSelectionViewInput?
    weak var moduleOutput: FinalCourseSelectionModuleOutput?
    
    private let courseSelectionService: CourseSelectionServiceProtocol
    var coursesDict: [Int: CourseSelectionModel] = [:]
        
    init(
        moduleOutput: FinalCourseSelectionModuleOutput,
        courseSelectionService: CourseSelectionServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
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
    
    private func treeBuilder(serviceModels: [ChoosenCourseSelectionServiceModel]) -> [Int: ChoosenCourseSelectionModel] {
        var coursesDict: [Int: ChoosenCourseSelectionModel] = [:]
        for model in serviceModels {
            let course = ChoosenCourseSelectionModel(id: model.id, title: model.title, closed: false, wasInLoad: false, isStarted: model.started, isOffline: model.isOffline)
            coursesDict[model.id] = course
        }
        for model in serviceModels {
            let parent = coursesDict[model.id]
            for dep in model.dependencies {
                if let course = coursesDict[dep.id] {
                    course.parentCourse = parent
                    parent?.courseChildren.append(course)
                    course.closed = dep.closed
                }
            }
        }
        return coursesDict
    }
    
    private func getCourses() {
        courseSelectionService.getFinalChoise() { [weak self] result in
            switch result {
            case .success(let model):
                let choosenDict = self?.treeBuilder(serviceModels: model.chosen) ?? [:]
                let closedCourses = model.closedNotUsed.map( {AddDependenceModel(id: $0.courseID, title: $0.name, isCourseDependency: false)} )
                let startedDict = self?.treeBuilder(serviceModels: model.started) ?? [:]
                DispatchQueue.main.async {
                    self?.viewInput?.setupAmount(amount: model.amount)
                    self?.viewInput?.setupCourses(startedCoursesDict: startedDict, choosenCoursesDict: choosenDict, closedCourses: closedCourses)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load courses: \(error)")
            }
        }
    }
    
    private func selectCourses(model: SelectedCoursesModel) {
        courseSelectionService.finalChoise(model: model) { [weak self] result in
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

extension FinalCourseSelectionPresenter: FinalCourseSelectionViewOutput {
    func openCourse(id: Int, navigationController: UINavigationController?) {
        moduleOutput?.moduleWantsToOpenCourse(for: id, navigationController: navigationController)
    }
    
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
