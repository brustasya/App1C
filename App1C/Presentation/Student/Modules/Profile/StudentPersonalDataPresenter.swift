//
//  StudentPersonalDataPresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

final class StudentPersonalDataPresenter: StudentProfilePresenter { }

extension StudentPersonalDataPresenter: ProfileViewOutput {
    func viewIsReady() {
        viewInput?.setupStudentFields()
        viewInput?.setupEditButton()
        viewInput?.setupSaveButton()
        viewInput?.changeEnable(isEdit: false)
        
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
