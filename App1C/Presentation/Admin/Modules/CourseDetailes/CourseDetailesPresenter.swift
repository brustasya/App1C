//
//  CourseDetailesPresenter.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

class CourseDetailesPresenter {
    weak var viewInput: CourseViewInput?
    weak var moduleOutput: CourseDetailesModuleOutput?
    
    private let coursesService: CoursesServiceProtocol
    private let id: Int
    
    private lazy var teachers: [Int] = []
    private lazy var courses: [Int] = []
    
    init(
        id: Int,
        moduleOutput: CourseDetailesModuleOutput,
        coursesService: CoursesServiceProtocol
    ) {
        self.id = id
        self.moduleOutput = moduleOutput
        self.coursesService = coursesService
    }
    
    func getCourse() {
        coursesService.getCourseDetailes(courseID: id) { [weak self] result in
            switch result {
            case .success(let model):
                var dayOfWeek = "Не указан"
                var from: Date?
                var to: Date?
                if let days = model.timetable?.days {
                    for day in days {
                        dayOfWeek = self?.getDayOfWeek(day: day.dayOfWeek) ?? "Не указан"
                        from = Date.toDate(dateString: day.from)
                        to = Date.toDate(dateString: day.to)
                    }
                }
                let type = (self?.getType(type: model.type ?? "")) ?? "Не указан"
                DispatchQueue.main.async {
                    self?.viewInput?.setTitle(title: model.title)
                    self?.viewInput?.updateData(name: model.title, chat: model.chat, type: type, dayOfWeek: dayOfWeek, from: from, to: to, descr: model.description)
                }
            case .failure(let error):
                Logger.shared.printLog(log: "Failed load course: \(error)")
            }
        }
    }
    
    private func getDayOfWeek(day: Int) -> String {
        switch day {
        case 1:
            return "Понедельник"
        case 2:
            return "Вторник"
        case 3:
            return "Среда"
        case 4:
            return "Четверг"
        case 5:
            return "Пятница"
        case 6:
            return "Суббота"
        default:
            return "Не указан"
        }
    }
    
    private func getType(type: String) -> String {
        switch type {
        case CourseType.department.rawValue:
            return CourseType.department.title
        case CourseType.ownWork.rawValue:
            return CourseType.ownWork.title
        case CourseType.coupleOfLessons.rawValue:
            return CourseType.coupleOfLessons.title
        case CourseType.epr.rawValue:
            return CourseType.epr.title
        case CourseType.hse.rawValue:
            return CourseType.hse.title
        case CourseType.practise.rawValue:
            return CourseType.practise.title
        default:
            return "Не указан"
        }
    }
}

extension CourseDetailesPresenter: CourseViewOutput {
    func selectItem(id: Int) {
        switch id {
        case 0:
            moduleOutput?.moduleWantsToOpenTeachers()
        case 1:
            moduleOutput?.moduleWantsToOpenStudents()
        case 2:
            moduleOutput?.moduleWantsToOpenDeps()
        case 3:
            break
        default:
            return
        }
    }
    
    func viewIsReady() {
        //viewInput?.setupAddMode()
        viewInput?.setupReadMode()
        viewInput?.addEditButton()
        getCourse()
        //viewInput?.setupEditMode()
    }
    
    func addDepsButtonTapped() { }
    
    func addTeachersButtonTapped() { }
    
    func addButtonTapped(name: String, chat: String, type: String, descr: String) { }
    
    func editButtonTapped() {
        moduleOutput?.moduleWantsToOpenEditModule(id: id)
    }
    
    func saveButtonTapped() { }
}
