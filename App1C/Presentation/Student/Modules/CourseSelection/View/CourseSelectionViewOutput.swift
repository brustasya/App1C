//
//  CourseSelectionViewOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol CourseSelectionViewOutput: AnyObject {
    func viewIsReady()
    func chooseButtonTapped(selectedCorses: [CourseSelectedModel])
}
