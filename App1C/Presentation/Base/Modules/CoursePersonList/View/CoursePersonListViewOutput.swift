//
//  CoursePersonListViewOutput.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

protocol CoursePersonListViewOutput: AnyObject {
    func viewIsReady()
    func selectedRowAt(index: Int, controller: UINavigationController?)
    func addButtonTapped(controller: UINavigationController?)
}
