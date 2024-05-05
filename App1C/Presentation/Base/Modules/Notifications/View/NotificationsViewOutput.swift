//
//  NotificationsViewOutput.swift
//  App1C
//
//  Created by Станислава on 03.05.2024.
//

import Foundation

protocol NotificationsViewOutput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func selectedRowAt(index: Int)
}
