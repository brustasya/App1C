//
//  NotificationModuleOutput.swift
//  App1C
//
//  Created by Станислава on 03.05.2024.
//

import Foundation

protocol NotificationModuleOutput: AnyObject {
    func moduleWantsToOpenCourseSelection()
    func moduleWantsToOpenFinalCourseSelection()
    func moduleWantsToOpenEstimation(courseID: Int, courseTitle: String)
}
