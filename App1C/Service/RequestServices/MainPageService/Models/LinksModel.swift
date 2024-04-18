//
//  LinksModel.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

struct LinksModel: Codable {
    let telegramChannelURL: String
    let telegramBotURL: String
    let siteURL: String
    
    enum CodingKeys: String, CodingKey {
        case telegramChannelURL = "telegram_channel_url"
        case telegramBotURL = "telegram_bot_url"
        case siteURL = "site_url"
    }
}
