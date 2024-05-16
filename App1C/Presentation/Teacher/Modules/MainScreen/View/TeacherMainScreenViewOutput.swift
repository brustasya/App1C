//
//  TeacherMainScreenViewOutput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol TeacherMainScreenViewOutput: AnyObject {
    func viewIsReady()
    func openTelegram()
    func openChatbot()
    func openSite()
    func selectEvent(at index: Int)
    func openNotifications()
}
