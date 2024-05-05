//
//  StudentCoursesListViewInput.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import Foundation

protocol StudentCoursesListViewInput: AnyObject {
    func setupCourses(closedCourses: [StudentCourseModel], currentCourses: [StudentCourseModel])
    func updateCourses(closedCourses: [StudentCourseModel], currentCourses: [StudentCourseModel])
}
