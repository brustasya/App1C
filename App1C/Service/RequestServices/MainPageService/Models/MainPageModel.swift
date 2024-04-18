//
//  MainPageModel.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

struct MainPageModel: Codable {
    let telegramChannelURL: String
    let telegramBotURL: String
    let siteURL: String
    let events: [MainPageEvent]
    let unseenEvents: Bool?
    let startedCourseAggregation: Bool
    
    enum CodingKeys: String, CodingKey {
        case telegramChannelURL = "telegram_channel_url"
        case telegramBotURL = "telegram_bot_url"
        case siteURL = "site_url"
        case events = "events"
        case unseenEvents = "unseenEvents"
        case startedCourseAggregation = "startedCourseAggregation"
    }
}

struct MainPageEvent: Codable {
    let id: Int
    let title: String
    let deadline: String
}
