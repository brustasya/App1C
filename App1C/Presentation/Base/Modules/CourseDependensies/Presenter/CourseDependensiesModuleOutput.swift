//
//  CourseDependensiesModuleOutput.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

protocol CourseDependensiesModuleOutput: AnyObject {
    func moduleWantsToAddDependensies(courseID: Int, controller: UINavigationController?)
}
