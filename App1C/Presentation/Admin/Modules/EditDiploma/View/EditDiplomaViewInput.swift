//
//  EditDiplomaViewInput.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import Foundation

protocol EditDiplomaViewInput: AnyObject {
    func setupTitle(title: String)
    func updateData(model: DiplomaModel)
    func close() 
}
