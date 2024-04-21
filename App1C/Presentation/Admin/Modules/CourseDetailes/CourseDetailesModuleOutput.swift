//
//  CourseDetailesModuleOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import UIKit

protocol CourseDetailesModuleOutput: AnyObject {
    func moduleWantsToOpenEditModule(id: Int, navigationController: UINavigationController?)
    func moduleWantsToOpenDeps(navigationController: UINavigationController?)
    func moduleWantsToOpenStudents(navigationController: UINavigationController?)
    func moduleWantsToOpenTeachers(navigationController: UINavigationController?)
}
