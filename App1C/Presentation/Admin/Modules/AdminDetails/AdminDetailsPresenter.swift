//
//  AdminDetailsPresenter.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

final class AdminDetailsPresenter: AdminProfilePresenter { }

extension AdminDetailsPresenter: ProfileViewOutput {
    func viewIsReady() {
        viewInput?.setupFields()
        viewInput?.changeEnable(isEdit: false)
        viewInput?.setupTitle(title: "Данные администратора")
        
        getAdmin()
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
