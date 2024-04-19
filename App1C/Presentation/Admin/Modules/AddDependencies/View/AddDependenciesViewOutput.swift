//
//  AddDependenciesViewOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol AddDependenciesViewOutput: AnyObject {
    func viewIsReady()
    func addCourse(id: Int)
    func removeCourse(id: Int)
    func addButtonTapped()
}
