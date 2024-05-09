//
//  CourseEstimatingDelegate.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import UIKit

protocol CourseEstimatingDelegate: AnyObject {
    func setGrade(cell: CourseEstimationCell)
    func estimate(courseID: Int, grade: Int, isRetake: Bool)
}
