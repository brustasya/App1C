//
//  Images.swift
//  App1C
//
//  Created by Станислава on 03.04.2024.
//

import UIKit

enum Images: String, CaseIterable, Codable, Equatable {
    case logo = "1c"
    case biglogo = "1С"
    case telegram = "telegram"
    case chatbot = "chatbot"
    case back = "chevron.backward"
    case bell = "bell"
    case bellBadge = "bell.badge"
    case flame = "flame"
    case graduationcap = "graduationcap"
    case events = "calendar.badge.clock"
    case more = "line.3.horizontal"
    case house = "house"
    case book = "book"
    case graduationcapfill = "graduationcap.fill"
    case estimating = "chart.bar.doc.horizontal"
    case forward = "chevron.forward"
    case shedule = "calendar"
    case edit = "square.and.pencil"
    case person = "person.circle"
    case persons = "person.2"
    case chat = "bubble.left.and.bubble.right"
    case books = "books.vertical"
    case archive = "archivebox"
    case reload = "return.right"
    case exit = "rectangle.portrait.and.arrow.right"
    case up = "chevron.up"
    case down = "chevron.down"
    case gear = "gearshape"
    case largePerson = "person"
    case check = "checkmark.square"
    case checkmark = "checkmark"
    case info = "info.circle"
    case plus = "plus.circle"
    case exclamationmark = "exclamationmark.triangle"
    
    var uiImage: UIImage? {
        return UIImage(named: self.rawValue)
            ?? UIImage(systemName: self.rawValue)
    }
}
