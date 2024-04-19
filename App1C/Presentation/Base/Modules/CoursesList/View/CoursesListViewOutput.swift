//
//  CoursesListViewOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol CoursesListViewOutput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func addCourseButtonTapped()
    func selectCourse(at index: Int)
}
