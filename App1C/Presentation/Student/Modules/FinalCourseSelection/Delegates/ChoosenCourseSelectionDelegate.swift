//
//  ChoosenCourseSelectionDelegate.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol ChoosenCourseSelectionDelegate: AnyObject {
    func openChoosenDependencies(view: ChoosenCourseView)
    func closeChoosenDependencies(view: ChoosenCourseView)
    func unselectChoosenCourse(id: Int)
    func selectChoosenCourse(id: Int)
    func getInfo(id: Int)
}
