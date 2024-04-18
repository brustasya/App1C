//
//  TeachersListPresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

class TeachersListPresenter {
    weak var viewInput: PersonListViewInput?
    weak var moduleOutput: TeachersListModuleOutput?
    
    private var teachers: [BaseModel] = [
        BaseModel(id: 0, title: "Грушина Наталья Игоревна", image: Images.largePerson.uiImage),
        BaseModel(id: 1, title: "Ляхов Андрей Викторович", image: Images.largePerson.uiImage),
        BaseModel(id: 2, title: "Гвоздева Анна Андреевна", image: Images.largePerson.uiImage),
    ]
    
    private let usersListService: UsersListServiceProtocol
    
    init(
        moduleOutput: TeachersListModuleOutput,
        usersListService: UsersListServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.usersListService = usersListService
    }
    
    private func getTeachers() {
        usersListService.getTeachers() { [weak self] result in
            switch result {
            case .success(let model):
                let teachers = model.teachers.map({
                    BaseModel(id: $0.id, title: $0.fullName, image: Images.largePerson.uiImage)
                })
                self?.teachers = teachers
                DispatchQueue.main.async {
                    self?.viewInput?.setupPersonTable(with: teachers)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load teachrs: \(failure)")
            }
        }
    }
}

extension TeachersListPresenter: PersonListViewOutput {
    func selectedRowAt(index: Int) {
        moduleOutput?.moduleWantsToOpenTeacherDetails(for: teachers[index].id)
    }
    
    func viewIsReady() {
        viewInput?.updateTitle(title: "Преподаватели кафедры")
        viewInput?.setupAddButton(title: "Добавить преподавателя")
        //viewInput?.setupPersonTable(with: admins)
        getTeachers()
    }
    
    func goBack() {
        moduleOutput?.moduleWantsToCloseTeachersList()
    }
    
    func addButtonTapped() {
        moduleOutput?.moduleWantsToOpenAddTeacher()
    }
}

