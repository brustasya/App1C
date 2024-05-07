//
//  SpeechSelectorDelegate.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import Foundation

protocol SpeechSelectorDelegate: AnyObject {
    func select(studentID: Int, speechID: Int)
    func unSelect(studentID: Int, speechID: Int)
}
