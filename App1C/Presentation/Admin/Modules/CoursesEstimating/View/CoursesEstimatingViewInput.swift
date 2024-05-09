//
//  CoursesEstimatingViewInput.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import Foundation

protocol CoursesEstimatingViewInput: AnyObject {
    func setupCourses(lastCourses: [StudentCourseModel], currentCourses: [StudentCourseModel], unusedCourses: [StudentCourseModel])
}
