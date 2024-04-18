//
//  AddPersonViewInput.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol AddPersonViewInput: AnyObject {
    func setupStudentsFields()
    func setupEmailField()
    func setupTitle(title: String)
}
