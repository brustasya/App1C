//
//  DiplomaEstimatingViewOutput.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import Foundation

protocol DiplomaEstimatingViewOutput: AnyObject {
    func selectDegree(bachelor: Bool)
    func selectGrade(type: GradeType)
    func estimate(studentID: Int, gradeID: Int, grade: Int)
}
