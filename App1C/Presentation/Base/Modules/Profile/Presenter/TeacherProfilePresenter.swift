//
//  TeacherProfilePresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

class TeacherProfilePresenter {
    weak var viewInput: ProfileViewInput?
       
    let id: Int
    private let profileService: ProfileServiceProtocol
    var isEdit = false
    
    init(
        id: Int,
        profileService: ProfileServiceProtocol
    ) {
        self.id = id
        self.profileService = profileService
    }
    
    func getTeacher() {
        profileService.getTeacher(id: id) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.viewInput?.updateUserData(
                        name: model.firstName,
                        surname: model.secondName,
                        patronymic: model.surname,
                        telegram: model.telegram,
                        from: self?.toDate(timeString: model.workTime?.from),
                        to: self?.toDate(timeString: model.workTime?.to)
                    )
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load teacher: \(failure)")
            }
        }
    }
    
    func modifyTeacher(model: UserDetailsModel) {
        profileService.modifyTeacher(id: id, model: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Succes modify teacher")
                DispatchQueue.main.async {
                    self?.viewInput?.changeEnable(isEdit: false)
                    self?.isEdit = false
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed modify teacher: \(failure)")
            }
        }
    }
    
    private func toDate(timeString: String?) -> Date? {
        guard let timeString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.date(from: timeString)
    }
}

