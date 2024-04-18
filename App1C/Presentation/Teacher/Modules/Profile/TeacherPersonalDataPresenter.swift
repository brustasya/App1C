//
//  TeacherPersonalDataPresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

final class TeacherPersonalDataPresenter: TeacherProfilePresenter {
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

extension TeacherPersonalDataPresenter: ProfileViewOutput {
    func viewIsReady() {
        viewInput?.setupFields()
        viewInput?.setupEditButton()
        viewInput?.setupSaveButton()
        viewInput?.changeEnable(isEdit: false)
        
        getTeacher()
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
        modifyTeacher(model: model)
    }
    
    func goBack() -> Bool {
        if isEdit {
            getTeacher()
            isEdit = false
            viewInput?.changeEnable(isEdit: isEdit)
            return false
        }
        return true
    }
   
}

