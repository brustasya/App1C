//
//  StudentSettingsModuleOutput.swift
//  App1C
//
//  Created by Станислава on 08.04.2024.
//

import Foundation

protocol StudentSettingsModuleOutput: AnyObject {
    func moduleWantsToOpenProfile()
    func moduleWantsToOpenAdminList()
    func moduleWantsToOpenRoleSelection()
    func moduleWantsToOpenDepartmentCourses()
}
