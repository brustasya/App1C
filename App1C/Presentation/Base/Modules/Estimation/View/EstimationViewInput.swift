//
//  EstimationViewInput.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import Foundation

protocol EstimationViewInput: AnyObject {
    func setupGrades(grades: [EstimationModel])
    func setTitle(title: String) 
    func close() 
}
