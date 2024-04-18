//
//  AddStudentViewOutput.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol AddStudentViewOutput: AnyObject {
    func addStudentButtonTapped(secondName: String, firstName: String, surname: String,
                                email: String, semester: Int) 
    func goBack()
}
