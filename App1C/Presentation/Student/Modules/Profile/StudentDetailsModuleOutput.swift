//
//  StudentDetailsModuleOutput.swift
//  App1C
//
//  Created by Станислава on 09.05.2024.
//

import UIKit

protocol StudentDetailsModuleOutput: AnyObject {
    func moduleWantsToOpenGrades(studentID: Int, controller: UINavigationController?)
}
