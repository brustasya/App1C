//
//  CourseViewInput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol CourseViewInput: AnyObject {
    func setupAddMode()
    func close()
    func setupEditMode()
    func setupReadMode()
    func addEditButton()
    func setTitle(title: String)
    func updateData(name: String, chat: String, type: String, dayOfWeek: String,
                    from: Date?, to: Date?, descr: String)
}
