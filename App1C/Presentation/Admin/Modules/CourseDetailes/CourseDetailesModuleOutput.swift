//
//  CourseDetailesModuleOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol CourseDetailesModuleOutput: AnyObject {
    func moduleWantsToOpenEditModule(id: Int)
    func moduleWantsToOpenDeps()
    func moduleWantsToOpenStudents()
    func moduleWantsToOpenTeachers()
}
