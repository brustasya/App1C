//
//  AdminDepartmentCoursesModuleOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol AdminDepartmentCoursesModuleOutput: AnyObject {
    func moduleWantsToOPenAddCourse()
    func moduleWantsToOpenCourse(for id: Int)
}
