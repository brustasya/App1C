//
//  RoleSelectionModuleOutput.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import Foundation

protocol RoleSelectionModuleOutput: AnyObject {
    func userWantsToOpenStudentModule()
    func userWantsToOpenTeacherModule()
    func userWantsToOpenAdminModule()
}
