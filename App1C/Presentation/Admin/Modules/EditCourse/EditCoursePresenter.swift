//
//  EditCoursePresenter.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import UIKit

class EditCoursePresenter {
    weak var viewInput: CourseViewInput?
    
    private let coursesService: CoursesServiceProtocol
    private let id: Int
    
    init(
        id: Int,
        coursesService: CoursesServiceProtocol
    ) {
        self.id = id
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
    
    func saveCourse(model: CourseDetailsModel) {
        coursesService.saveCourseDetailes(courseID: id, model: model) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.viewInput?.close()
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
    
    private func getDayOfWeek(day: String) -> Int? {
        switch day {
        case "Понедельник":
            return 1
        case "Вторник":
            return 2
        case "Среда":
            return 3
        case "Четверг":
            return 4
        case "Пятница":
            return 5
        case "Суббота":
            return 6
        default:
            return nil
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
    
    private func getTypeRawValue(type: String) -> String? {
        switch type {
        case CourseType.department.title:
            return CourseType.department.rawValue
        case CourseType.ownWork.title:
            return CourseType.ownWork.rawValue
        case CourseType.coupleOfLessons.title:
            return CourseType.coupleOfLessons.rawValue
        case CourseType.epr.title:
            return CourseType.epr.rawValue
        case CourseType.hse.title:
            return CourseType.hse.rawValue
        case CourseType.practise.title:
            return CourseType.practise.rawValue
        default:
            return nil
        }
    }
}

extension EditCoursePresenter: CourseViewOutput {
    func addDepsButtonTapped(controller: UINavigationController?) {
        
    }
    
    func addTeachersButtonTapped(controller: UINavigationController?) {
        
    }
    
    func viewWillAppear() { }
    
    func selectItem(id: Int, navigationController: UINavigationController?) {}
    
    func viewIsReady() {
        //viewInput?.setupAddMode()
        viewInput?.setupEditMode()
        getCourse()
    }
    
    func addButtonTapped(name: String, chat: String, type: String, descr: String) { }
    
    func editButtonTapped(navigationController: UINavigationController?) { }
    
    func saveButtonTapped(name: String, chat: String, type: String, dayOfWeek: String,
                          from: Date?, to: Date?, descr: String) {
        var dayModel: DaysModel?
        if let from, let to,
        let dayOfWeek = getDayOfWeek(day: dayOfWeek) {
            dayModel = DaysModel(days: [TimeTableDayModel(dayOfWeek: dayOfWeek, from: Date.toString(date: from), to: Date.toString(date: to))])
        }
        let model = CourseDetailsModel(title: name, description: descr, chat: chat, isStarted: nil, timetable: dayModel, type: getTypeRawValue(type: type))
        saveCourse(model: model)
    }
}
