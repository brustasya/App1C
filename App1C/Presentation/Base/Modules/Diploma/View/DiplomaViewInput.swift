//
//  DiplomaViewInput.swift
//  App1C
//
//  Created by Станислава on 06.05.2024.
//

import Foundation

protocol DiplomaViewInput: AnyObject {
    func setupTitle(title: String)
    func setupEditButton() 
    func updateData(model: DiplomaModel)
}
