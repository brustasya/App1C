//
//  DiplomaThemesModuleOutput.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

protocol DiplomaThemesModuleOutput: AnyObject {
    func moduleWantsToOpenDiploma(studentID: Int, bachelor: Bool)
}
