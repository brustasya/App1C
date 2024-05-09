//
//  AddDependenciesViewInput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol AddDependenciesViewInput: AnyObject {
    func updateCourses(with courses: [AddDependenceModel])
    func setTitle(title: String)
    func close()
}
