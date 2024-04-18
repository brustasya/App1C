//
//  TeachersListModuleOutput.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol TeachersListModuleOutput: AnyObject {
    func moduleWantsToCloseTeachersList()
    func moduleWantsToOpenAddTeacher()
    func moduleWantsToOpenTeacherDetails(for id: Int)
}
