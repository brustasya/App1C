//
//  StudentPersonalDataPresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import UIKit

final class StudentPersonalDataPresenter: StudentProfilePresenter { 
    weak var moduleOutput: StudentDetailsModuleOutput?
        
    init(
        id: Int,
        profileService: ProfileServiceProtocol,
        moduleOutput: StudentDetailsModuleOutput
    ) {
        self.moduleOutput = moduleOutput
        super.init(id: id, profileService: profileService)
    }
}

extension StudentPersonalDataPresenter: ProfileViewOutput {
    func openGrades(controller: UINavigationController?) {
        moduleOutput?.moduleWantsToOpenGrades(studentID: id, controller: controller)
    }
    
    func viewIsReady() {
        viewInput?.setupStudentFields()

        if TokenService.shared.id != id || TokenService.shared.role != .student {
            viewInput?.setupTitle(title: "Данные студента")
        }
        
        if TokenService.shared.role == .admin || TokenService.shared.id == id {
            viewInput?.setupEditButton()
            viewInput?.setupSaveButton()
            viewInput?.changeEnable(isEdit: false)
        }
        
        if TokenService.shared.role == .admin {
            viewInput?.setupGradesButton()
        }
        
        getStudent()
    }
    
    func editButtonTapped() {
        isEdit = true
        viewInput?.changeEnable(isEdit: isEdit)
    }
    
    func saveButtonTapped(name: String, surname: String, patronymic: String?,
                          telegram: String?, semester: Int, isInAcademicLeave: Bool,
                          workPlace: String?, job: String?, from: Date?, to: Date?) {
        let model = StudentDetailsModel(
            secondName: surname,
            firstName: name,
            surname: patronymic,
            telegram: telegram,
            academicLeaveEndDate: academicLeaveEndDate,
            workplace: workPlace,
            job: job,
            archive: archive,
            inAcademicLeave: isInAcademicLeave,
            semester: semester
        )
        modifyStudent(model: model)
    }
    
    func goBack() -> Bool {
        if isEdit {
            getStudent()
            isEdit = false
            viewInput?.changeEnable(isEdit: isEdit)
            return false
        }
        return true
    }
   
}
