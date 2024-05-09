//
//  CoursesEstimatingModuleOutput.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import UIKit

protocol CoursesEstimatingModuleOutput: AnyObject {
    func moduleWantsToAddCourses(studentID: Int, controller: UINavigationController?)
}
