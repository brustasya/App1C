//
//  CourseDependensiesViewInput.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import Foundation

protocol CourseDependensiesViewInput: AnyObject {
    func updateCoursesTable(with courses: [CourseModel])
    func updateTitle(title: String)
    func setupBaseMode()
    func setupEditMode()
}
