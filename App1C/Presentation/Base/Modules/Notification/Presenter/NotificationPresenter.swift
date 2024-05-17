//
//  NotificationPresenter.swift
//  App1C
//
//  Created by Станислава on 03.05.2024.
//

import Foundation

class NotificationPresenter {
    weak var moduleOutput: NotificationModuleOutput?
    weak var viewInput: EventViewInput?
    
    private let eventsService: EventsServiceProtocol
    private let coursesService: CoursesServiceProtocol
    private let id: Int
    
    private var eventType: EventType = .message
    private var courses: [CourseModel] = []
    
    init(
        id: Int,
        moduleOutput: NotificationModuleOutput,
        eventsService: EventsServiceProtocol,
        coursesService: CoursesServiceProtocol
    ) {
        self.id = id
        self.eventsService = eventsService
        self.moduleOutput = moduleOutput
        self.coursesService = coursesService
    }
    
    private func watchedEvent() {
        eventsService.watchEvent(eventID: id) { result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success watch event")
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed watch event: \(failure)")
            }
        }
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
                let type = (self?.getEventType(type: model.type)) ?? .message
                self?.eventType = type
                DispatchQueue.main.async {
                    self?.viewInput?.setTitle(title: model.title)
                    switch type {
                    case .preliminaryCourseChoice, .finalCourseChoice:
                        let deadline = Date.toDate(dateString: model.deadline)
                        self?.viewInput?.setupReadMode()
                        if deadline >= Date.now {
                            self?.viewInput?.addGoOverButton()
                        }
                        self?.viewInput?.updateData(deadline: deadline, descr: model.description)
                    case .estimating:
                        let deadline = Date.toDate(dateString: model.deadline)
                        self?.viewInput?.setupReadMode()
                        self?.viewInput?.updateData(deadline: deadline, descr: model.description)
                       
                        if deadline >= Date.now {
                            self?.getCourses()
                        }
                    case .diplomaThemeChoice, .diplomaSpeech:
                        break
                    case .diplomaThemeCorrection:
                        let deadline = Date.toDate(dateString: model.deadline)
                        self?.viewInput?.setupReadMode()
                        self?.viewInput?.updateData(deadline: deadline, descr: model.description)
                    case .message:
                        self?.viewInput?.setupMessage(text: model.description)
                    }
                    
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
        case EventType.diplomaThemeCorrection.rawValue:
            return .diplomaThemeCorrection
        default:
            return .message
        }
    }
}

extension NotificationPresenter: EventViewOutput {
    func selectCourse(at index: Int) { 
        moduleOutput?.moduleWantsToOpenEstimation(
            courseID: courses[index].id,
            courseTitle: courses[index].title
        )
    }
    
    func viewIsReady() {
        watchedEvent()
        getEvent()
    }
    
    func createButtonTapped(deadline: Date, descr: String) { }
    
    func goOverButtonTapped() {
        if eventType == .preliminaryCourseChoice {
            moduleOutput?.moduleWantsToOpenCourseSelection()
        } else {
            moduleOutput?.moduleWantsToOpenFinalCourseSelection()
        }
    }
    
    func saveButtonTapped(deadline: Date, descr: String) { }
}
