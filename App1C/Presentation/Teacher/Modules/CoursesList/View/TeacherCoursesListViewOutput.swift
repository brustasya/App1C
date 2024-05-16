//
//  TeacherCoursesListViewOutput.swift
//  App1C
//
//  Created by Станислава on 16.05.2024.
//

import UIKit

protocol TeacherCoursesListViewOutput: AnyObject {
    func viewIsReady()
    func selectCourse(index: Int, controller: UINavigationController?)
}
