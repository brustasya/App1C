//
//  ProfileViewInput.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol ProfileViewInput: AnyObject {
    func setupTitle(title: String)
    func setupStudentFields()
    func setupFields()
    func setupEditButton()
    func setupSaveButton()
    func changeEnable(isEdit: Bool)
    func updateStuedntData(name: String, surname: String, patronymic: String?,
                            telegram: String?, semester: Int, isInAcademivLeave: Bool,
                           workPlace: String?, job: String?)
    func updateUserData(name: String, surname: String, patronymic: String?,
                        telegram: String?, from: Date?, to: Date?)
    func setupGradesButton()
}
