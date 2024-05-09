//
//  TeacherEventPresenter.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

class TeacherEventPresenter {
    weak var moduleOutput: TeacherEventModuleOutput?
    weak var viewInput: EventViewInput?
    
    private let eventsService: EventsServiceProtocol
    private let coursesService: CoursesServiceProtocol
    private let id: Int
    private var eventType: EventType = .estimating
    
    private var courses: [CourseModel] = []
    
    init(
        id: Int,
        moduleOutput: TeacherEventModuleOutput,
        coursesService: CoursesServiceProtocol,
        eventsService: EventsServiceProtocol
    ) {
        self.id = id
        self.eventsService = eventsService
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
                    self?.viewInput?.updateCourses(courses: courses)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load courses: \(error)")
            }
        }
    }
    
    private func getEvent() {
        eventsService.eventDetails(eventID: id) { [weak self] result in
            switch result {
            case .success(let model):
                self?.eventType = (self?.getEventType(type: model.type)) ?? .estimating
                DispatchQueue.main.async {
                    self?.viewInput?.updateData(deadline: Date.toDate(dateString: model.deadline), descr: model.description)
                    self?.viewInput?.setTitle(title: model.title)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load event: \(error)")
            }
        }
    }
    
    private func getEventType(type: String) -> EventType {
        switch type {
        case EventType.preliminaryCourseChoice.rawValue:
            return .preliminaryCourseChoice
        case EventType.finalCourseChoice.rawValue:
            return .finalCourseChoice
        case EventType.estimating.rawValue:
            return .estimating
        default:
            return .estimating
        }
    }
}

extension TeacherEventPresenter: EventViewOutput {
    func selectCourse(at index: Int) {
        moduleOutput?.moduleWantsToOpenEstimation(courseID: courses[index].id, courseTitle: courses[index].title)
    }
    
    func viewIsReady() {
        getEvent()
        getCourses()
        viewInput?.setupReadMode()
    }
    
    func createButtonTapped(deadline: Date, descr: String) { }
    
    func goOverButtonTapped() { }
    
    func saveButtonTapped(deadline: Date, descr: String) { }
    
    
}
