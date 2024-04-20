//
//  CoursesAgregationViewOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol CoursesAgregationViewOutput: AnyObject {
    func selectCourse(id: Int, isSelect: Bool)
    func startChoosenButtonTapped()
    func viewIsReady()
}
