//
//  ThemeSelectionEventViewOutput.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

protocol ThemeSelectionEventViewOutput: AnyObject {
    func viewIsReady()
    func createButtonTapped(model: ThemeSelectionEventModel)
    func saveButtonTapped(model: ThemeSelectionEventModel)
}
