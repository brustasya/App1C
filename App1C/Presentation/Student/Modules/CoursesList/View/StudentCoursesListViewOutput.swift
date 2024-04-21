//
//  StudentCoursesListViewOutput.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import Foundation

protocol StudentCoursesListViewOutput: AnyObject {
    func viewIsReady()
    func selectClosedCourse(at index: Int)
    func selectCurrentCourse(at index: Int)
}
