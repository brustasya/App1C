//
//  AddCourseModuleOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

protocol AddCourseModuleOutput: AnyObject {
    func moduleWantsToOpenAddDeps(delegate: CourseDelegate, controller: UINavigationController?)
    func moduleWantsToOpenAddTeachers(delegate: CourseDelegate, controller: UINavigationController?)
}
