//
//  StudentCoursesListViewOutput.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import UIKit

protocol StudentCoursesListViewOutput: AnyObject {
    func viewIsReady()
    func selectClosedCourse(at index: Int, navigationController: UINavigationController?)
    func selectCurrentCourse(at index: Int, navigationController: UINavigationController?)
}
