//
//  AdminSettingsViewOutput.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import Foundation

protocol AdminSettingsViewOutput: AnyObject {
    func selectRowAt(index: Int)
    func selectEducationRowAt(index: Int)
}
