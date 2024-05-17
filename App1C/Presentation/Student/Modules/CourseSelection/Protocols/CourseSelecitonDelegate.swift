//
//  CourseSelecitonDelegate.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol CourseSelecitonDelegate: AnyObject {
    func openDependencies(view: CourseView)
    func closeDependencies(view: CourseView)
    func unselectCourse(id: Int)
    func selectCourse(id: Int)
    func getInfo(id: Int)
}
