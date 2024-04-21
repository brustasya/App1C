//
//  AdminDepartmentCoursesModuleOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

protocol AdminDepartmentCoursesModuleOutput: AnyObject {
    func moduleWantsToOPenAddCourse(navigationController: UINavigationController?)
    func moduleWantsToOpenCourse(for id: Int, navigationController: UINavigationController?)
}
