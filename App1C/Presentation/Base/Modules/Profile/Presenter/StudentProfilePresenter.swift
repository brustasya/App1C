//
//  StudentProfilePresenter.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

class StudentProfilePresenter {
    weak var viewInput: ProfileViewInput?
       
    let id: Int
    let profileService: ProfileServiceProtocol
    var academicLeaveEndDate: String?
    var archive: Bool = false
    var isEdit = false
    
    init(
        id: Int,
        profileService: ProfileServiceProtocol
    ) {
        self.id = id
        self.profileService = profileService
    }
    
    func getStudent() {
        profileService.getStudent(id: id) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.viewInput?.updateStuedntData(
                        name: model.firstName,
                        surname: model.secondName,
                        patronymic: model.surname,
                        telegram: model.telegram,
                        semester: model.semester ?? 5,
                        isInAcademivLeave: model.inAcademicLeave,
                        workPlace: model.workplace,
                        job: model.job
                    )
                }
                self?.academicLeaveEndDate = model.academicLeaveEndDate
                self?.archive = model.archive
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load student: \(failure)")
            }
        }
    }
    
    func modifyStudent(model: StudentDetailsModel) {
        profileService.modifyStudent(id: id, model: model) { [weak self] result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Succes modify student")
                DispatchQueue.main.async {
                    self?.viewInput?.changeEnable(isEdit: false)
                    self?.isEdit = false
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed modify student: \(failure)")
            }
        }
    }
}

