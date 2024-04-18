//
//  RoleSelectionViewOutput.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import Foundation

protocol RoleSelectionViewOutput: AnyObject {
    func viewIsReady()
    func selectedRowAt(index: Int)
}
