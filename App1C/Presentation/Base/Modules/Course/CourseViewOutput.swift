//
//  CourseViewOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import UIKit

protocol CourseViewOutput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func addDepsButtonTapped()
    func addTeachersButtonTapped()
    func addButtonTapped(name: String, chat: String, type: String, descr: String)
    func editButtonTapped(navigationController: UINavigationController?)
    func saveButtonTapped(name: String, chat: String, type: String, dayOfWeek: String,
                          from: Date?, to: Date?, descr: String)
    func selectItem(id: Int, navigationController: UINavigationController?)
}
