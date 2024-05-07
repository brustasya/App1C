//
//  AdminDiplomaModuleOutput.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import Foundation

protocol AdminDiplomaModuleOutput: AnyObject {
    func moduleWantToEditDiploma(studentID: Int, bachelor: Bool, model: DiplomaModel)
}
