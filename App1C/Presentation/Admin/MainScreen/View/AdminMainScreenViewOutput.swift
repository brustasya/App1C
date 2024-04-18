//
//  AdminMainScreenViewOutput.swift
//  App1C
//
//  Created by Станислава on 17.04.2024.
//

import Foundation

protocol AdminMainScreenViewOutput: AnyObject {
    func viewIsReady()
    func updateTelegramURL(url: String)
    func updateChatbotURL(url: String)
    func updateSiteURL(url: String)
    func openTelegram()
    func openChatbot()
    func openSite()
}
