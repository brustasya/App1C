//
//  AddPersonViewOutput.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol AddPersonViewOutput: AnyObject {
    func addButtonTapped(secondName: String, firstName: String, surname: String,
                                email: String, semester: Int)
    func goBack()
    
    func viewIsReady()
}
