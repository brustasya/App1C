//
//  CourseViewOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol CourseViewOutput: AnyObject {
    func viewIsReady()
    func addDepsButtonTapped()
    func addTeachersButtonTapped()
    func addButtonTapped(name: String, chat: String, type: String, descr: String)
    func editButtonTapped()
    func saveButtonTapped()
}
