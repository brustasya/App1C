//
//  CoursesListViewInput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol CoursesListViewInput: AnyObject {
    func setupTitle(title: String)
    func setupCourses(courses: [CourseModel])
    func setupBaseMode()
    func setupAdminMode()
}
