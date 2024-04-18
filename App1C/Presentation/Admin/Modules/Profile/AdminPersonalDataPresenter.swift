//
//  AdminPersonalDataPresenter.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

final class AdminPersonalDataPresenter: AdminProfilePresenter {
    private func makeWorkTimeModel(from: Date?, to: Date?) -> WorkTimeModel? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let from, let to {
            return WorkTimeModel(
                from: dateFormatter.string(from: from),
                to: dateFormatter.string(from: to)
            )
        }
        return nil
    }
}

extension AdminPersonalDataPresenter: ProfileViewOutput {
    func viewIsReady() {
        viewInput?.setupFields()
        viewInput?.setupEditButton()
        viewInput?.setupSaveButton()
        viewInput?.changeEnable(isEdit: false)
        
        getAdmin()
    }
    
    func editButtonTapped() {
        isEdit = true
        viewInput?.changeEnable(isEdit: isEdit)
    }
    
    func saveButtonTapped(name: String, surname: String, patronymic: String?,
                          telegram: String?, semester: Int, isInAcademicLeave: Bool,
                          workPlace: String?, job: String?, from: Date?, to: Date?) {
        let model = UserDetailsModel(
            secondName: surname,
            firstName: name,
            surname: patronymic,
            telegram: telegram,
            workTime: makeWorkTimeModel(from: from, to: to)
        )
        modifyAdmin(model: model)
    }
    
    func goBack() -> Bool {
        if isEdit {
            getAdmin()
            isEdit = false
            viewInput?.changeEnable(isEdit: isEdit)
            return false
        }
        return true
    }
   
}

