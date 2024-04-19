//
//  AddTeachersViewOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol AddTeachersViewOutput: AnyObject {
    func viewIsReady()
    func addTeacher(id: Int)
    func removeTeacher(id: Int)
    func addButtonTapped()
}
