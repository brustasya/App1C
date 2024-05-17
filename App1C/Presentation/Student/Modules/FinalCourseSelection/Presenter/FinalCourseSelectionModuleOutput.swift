//
//  FinalCourseSelectionModuleOutput.swift
//  App1C
//
//  Created by Станислава on 17.05.2024.
//

import UIKit

protocol FinalCourseSelectionModuleOutput: AnyObject {
    func moduleWantsToOpenCourse(for id: Int, navigationController: UINavigationController?)
}
