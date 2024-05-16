//
//  TeacherCoursesListModuleOutput.swift
//  App1C
//
//  Created by Станислава on 16.05.2024.
//

import UIKit

protocol TeacherCoursesListModuleOutput: AnyObject {
    func moduleWantsToOpenCourse(id: Int, isEditEnable: Bool, controller: UINavigationController?)
}
