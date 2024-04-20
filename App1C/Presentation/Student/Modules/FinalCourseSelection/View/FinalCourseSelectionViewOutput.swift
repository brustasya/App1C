//
//  FinalCourseSelectionViewOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol FinalCourseSelectionViewOutput: AnyObject {
    func viewIsReady()
    func chooseButtonTapped(selectedCorses: [CourseSelectedModel])
}
