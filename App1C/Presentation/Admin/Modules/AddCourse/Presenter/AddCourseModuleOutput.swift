//
//  AddCourseModuleOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol AddCourseModuleOutput: AnyObject {
    func moduleWantsToOpenAddDeps(delegate: CourseDelegate)
    func moduleWantsToOpenAddTeachers(delegate: CourseDelegate)
}
