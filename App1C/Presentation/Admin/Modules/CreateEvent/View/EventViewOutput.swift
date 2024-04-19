//
//  EventViewOutput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol EventViewOutput: AnyObject {
    func viewIsReady()
    func createButtonTapped(deadline: Date, descr: String)
    func goOverButtonTapped()
    func saveButtonTapped(deadline: Date, descr: String)
}
