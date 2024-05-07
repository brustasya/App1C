//
//  EditDiplomaViewOutput.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import Foundation

protocol EditDiplomaViewOutput: AnyObject {
    func saveButtonTapped(model: DiplomaModel)
    func viewIsReady()
}
