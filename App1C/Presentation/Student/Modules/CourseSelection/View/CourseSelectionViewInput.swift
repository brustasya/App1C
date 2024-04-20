//
//  CourseSelectionViewInput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol CourseSelectionViewInput: AnyObject {
    func updateCourses(coursesDict: [Int: CourseSelectionModel])
    func setupAmount(amount: Int)
    func close()
}
