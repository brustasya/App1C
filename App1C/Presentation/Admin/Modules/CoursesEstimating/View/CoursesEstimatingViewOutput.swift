//
//  CoursesEstimatingViewOutput.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import UIKit

protocol CoursesEstimatingViewOutput: AnyObject {
    func viewIsReady()
    func setGrade(courseId: Int, grade: Int, isRetake: Bool)
    func addButtonTapped(controller: UINavigationController?)
}
