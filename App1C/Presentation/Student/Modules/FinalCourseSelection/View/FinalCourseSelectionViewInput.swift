//
//  FinalCourseSelectionViewInput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol FinalCourseSelectionViewInput: AnyObject {
    func close()
    func setupCourses(
        startedCoursesDict: [Int: CourseSelectionModel],
        choosenCoursesDict: [Int: ChoosenCourseSelectionModel],
        closedCourses: [AddDependenceModel]
    )
    func setupAmount(amount: Int)
}
