//
//  CoursesEstimatingViewOutput.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import Foundation

protocol CoursesEstimatingViewOutput: AnyObject {
    func viewIsReady()
    func setGrade(grade: Int, inLoad: Bool)
}
