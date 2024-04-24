//
//  TeacherEventModuleOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol TeacherEventModuleOutput: AnyObject {
    func moduleWantsToOpenEstimation(courseID: Int, courseTitle: String)
}
