//
//  StudentMainScreenViewOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol StudentMainScreenViewOutput: AnyObject {
    func viewIsReady()
    func openTelegram()
    func openChatbot()
    func openSite()
    func openTimeTable()
    func selectEvent(at index: Int)
    func openNotifications()
    func viewWillAppear()
}
