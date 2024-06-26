//
//  EventViewInput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol EventViewInput: AnyObject {
    func setTitle(title: String)
    func setupCreateMode()
    func setupSaveMode()
    func close()
    func setupReadMode()
    func addGoOverButton()
    func updateData(deadline: Date, descr: String)
    func updateCourses(courses: [CourseModel])
    func setupMessage(text: String) 
}
