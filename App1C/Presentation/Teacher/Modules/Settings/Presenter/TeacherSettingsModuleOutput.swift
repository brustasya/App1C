//
//  TeacherSettingsModuleOutput.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import Foundation

protocol TeacherSettingsModuleOutput: AnyObject {
    func moduleWantsToOpenProfile()
    func moduleWantsToOpenAdminList()
    func moduleWantsToOpenRoleSelection()
    func moduleWantsToOpenDepartmentCourses()
    func moduleWantsToOpenAuthorization()
}
