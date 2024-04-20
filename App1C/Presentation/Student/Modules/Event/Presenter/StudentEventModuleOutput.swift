//
//  StudentEventModuleOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol StudentEventModuleOutput: AnyObject {
    func moduleWantsToOpenCourseSelection()
    func moduleWantsToOpenFinalCourseSelection()
}
