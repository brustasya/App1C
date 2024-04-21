//
//  CoursesListViewOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

protocol CoursesListViewOutput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func addCourseButtonTapped(navigationController: UINavigationController?)
    func selectCourse(at index: Int, navigationController: UINavigationController?)
}
