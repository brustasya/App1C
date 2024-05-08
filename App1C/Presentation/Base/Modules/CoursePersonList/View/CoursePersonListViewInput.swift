//
//  CoursePersonListViewInput.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import Foundation

protocol CoursePersonListViewInput: AnyObject {
    func setupPersonTable(with persons: [BaseModel], title: String)
    func updateTitle(title: String)
    func setupAddButton(title: String)
    func updatePersons(with persons: [BaseModel])
}
