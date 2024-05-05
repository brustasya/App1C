//
//  ThemeSelectionEventViewInput.swift
//  App1C
//
//  Created by Станислава on 05.05.2024.
//

import Foundation

protocol ThemeSelectionEventViewInput: AnyObject {
    func setupCreateMode()
    func setupSaveMode()
    func setupReadMode()
    func updateData(model: ThemeSelectionEventModel, isEdit: Bool)
    func close()
}
