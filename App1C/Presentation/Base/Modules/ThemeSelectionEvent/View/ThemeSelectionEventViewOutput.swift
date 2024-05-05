//
//  ThemeSelectionEventViewOutput.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

protocol ThemeSelectionEventViewOutput: AnyObject {
    func viewIsReady()
    func createButtonTapped(deadline: Date, descr: String)
    func saveButtonTapped(deadline: Date, descr: String)
}
