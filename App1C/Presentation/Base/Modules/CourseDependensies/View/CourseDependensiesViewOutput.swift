//
//  CourseDependensiesViewOutput.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import UIKit

protocol CourseDependensiesViewOutput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func addButtonTapped(controller: UINavigationController?)
}
