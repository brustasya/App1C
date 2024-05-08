//
//  CourseDetailesModuleOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import UIKit

protocol CourseDetailesModuleOutput: AnyObject {
    func moduleWantsToOpenEditModule(id: Int, navigationController: UINavigationController?)
    func moduleWantsToOpenDeps(courseID: Int, courseTitle: String, navigationController: UINavigationController?)
    func moduleWantsToOpenStudents(courseID: Int, courseTitle: String, navigationController: UINavigationController?)
    func moduleWantsToOpenTeachers(courseID: Int, courseTitle: String, navigationController: UINavigationController?)
}
