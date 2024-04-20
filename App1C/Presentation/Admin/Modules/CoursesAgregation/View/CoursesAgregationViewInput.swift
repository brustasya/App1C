//
//  CoursesAgregationViewInput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol CoursesAgregationViewInput: AnyObject {
    func updateCourses(courses: [CourseAgregationModel]) 
}
