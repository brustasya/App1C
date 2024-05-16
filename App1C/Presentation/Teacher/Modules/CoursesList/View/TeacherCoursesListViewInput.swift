//
//  TeacherCoursesListViewInput.swift
//  App1C
//
//  Created by Станислава on 16.05.2024.
//

import Foundation

protocol TeacherCoursesListViewInput: AnyObject {
    func setupCourses(courses: [CourseModel])
}
