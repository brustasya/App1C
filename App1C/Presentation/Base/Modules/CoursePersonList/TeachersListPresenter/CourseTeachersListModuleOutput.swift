//
//  CourseTeachersListModuleOutput.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

protocol CourseTeachersListModuleOutput: AnyObject {
    func moduleWantsToOpenTeacher(teacherID: Int, controller: UINavigationController?)
    func moduleWantsToAddTeachers(courseID: Int, controller: UINavigationController?)
}
