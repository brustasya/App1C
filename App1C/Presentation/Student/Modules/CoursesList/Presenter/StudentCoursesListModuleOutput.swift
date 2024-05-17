//
//  StudentCoursesListModuleOutput.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import UIKit

protocol StudentCoursesListModuleOutput: AnyObject {
    func moduleWantsToOpenCourse(for id: Int, navigationController: UINavigationController?)
}
