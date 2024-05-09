//
//  ProfileViewOutput.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import UIKit

protocol ProfileViewOutput: AnyObject {
    func viewIsReady()
    func editButtonTapped()
    func saveButtonTapped(name: String, surname: String, patronymic: String?,
                          telegram: String?, semester: Int, isInAcademicLeave: Bool,
                          workPlace: String?, job: String?, from: Date?, to: Date?)
    func goBack() -> Bool
    func openGrades(controller: UINavigationController?)
}
