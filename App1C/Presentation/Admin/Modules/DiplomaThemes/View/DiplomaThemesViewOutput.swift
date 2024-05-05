//
//  DiplomaThemesViewOutput.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

protocol DiplomaThemesViewOutput: AnyObject {
    func selectType(bachelor: Bool)
    func selectStudent(index: Int)
}
