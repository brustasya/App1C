//
//  StudentsListViewOutput.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol StudentsListViewOutput: AnyObject {
    func addStudent()
    func goBack()
    func selectCourse(at index: Int)
    func selectStudent(at index: Int)
}

