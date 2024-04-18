//
//  StudentDetailsPresenter.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

final class StudentDetailsPresenter: StudentProfilePresenter { }

extension StudentDetailsPresenter: ProfileViewOutput {
    func viewIsReady() {
        viewInput?.setupStudentFields()
        viewInput?.changeEnable(isEdit: false)
        viewInput?.setupTitle(title: "Данные студента")
        
        getStudent()
    }
    
    func editButtonTapped() {
        isEdit = true
        viewInput?.changeEnable(isEdit: isEdit)
    }
    
    func saveButtonTapped(name: String, surname: String, patronymic: String?,
                          telegram: String?, semester: Int, isInAcademicLeave: Bool,
                          workPlace: String?, job: String?, from: Date?, to: Date?) { }
    
    func goBack() -> Bool { return true }
   
}
