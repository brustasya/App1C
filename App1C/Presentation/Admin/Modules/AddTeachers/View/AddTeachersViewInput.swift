//
//  AddTeachersViewInput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol AddTeachersViewInput: AnyObject {
    func updateTeachers(with teachers: [AddTeacherModel])
    func close()
}
