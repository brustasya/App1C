//
//  AddStudentPresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

final class AddStudentPresenter {
    weak var viewInput: AddPersonViewInput?
    weak var moduleOutput: AddStudentModuleOutput?
        
    private let userCreationService: UserCreationServiceProtocol
    
    init(
        moduleOutput: AddStudentModuleOutput,
        userCreationService: UserCreationServiceProtocol
    ) {
        self.moduleOutput = moduleOutput
        self.userCreationService = userCreationService
        
    }
    
    private func createStudent(model: CreateStudentModel) {
        userCreationService.createStudent(model: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success added student")
                DispatchQueue.main.async {
                    self?.moduleOutput?.moduleWantsToCloseAddStudent()
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed added student: \(failure)")
            }
        }
    }
}

extension AddStudentPresenter: AddPersonViewOutput {
    func viewIsReady() {
        viewInput?.setupTitle(title: "Добавить студента")
        viewInput?.setupStudentsFields()
    }
    
    func addButtonTapped(secondName: String, firstName: String, surname: String,
                                email: String, semester: Int) {
        let model = CreateStudentModel(
            secondName: secondName,
            firstName: firstName,
            surname: surname,
            email: email,
            semester: semester
        )
        
        createStudent(model: model)
    }
    
    func goBack() {
        moduleOutput?.moduleWantsToCloseAddStudent()
    }
}
