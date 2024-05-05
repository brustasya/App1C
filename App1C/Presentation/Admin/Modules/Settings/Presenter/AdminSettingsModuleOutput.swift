//
//  AdminSettingsModuleOutput.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import Foundation

protocol AdminSettingsModuleOutput: AnyObject {
    func moduleWantsToOpenProfile()
    func moduleWantsToOpenAdminList()
    func moduleWantsToOpenRoleSelection()
    func moduleWantsToOpenDepartmentCourses()
    func moduleWantsToOpenStudentsList()
    func moduleWantsToOpenTeachersList()
    func moduleWantsToOpenDiplomaThemes()
    func moduleWantsToOpenSRWResults()
    func moduleWantsToOpenSRWGrades()
}
