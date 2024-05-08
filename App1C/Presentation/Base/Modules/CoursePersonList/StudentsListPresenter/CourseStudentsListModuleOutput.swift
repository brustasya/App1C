//
//  CourseStudentsListModuleOutput.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

protocol CourseStudentsListModuleOutput: AnyObject {
    func moduleWantsToOpenStudent(studentID: Int, controller: UINavigationController?)
}
