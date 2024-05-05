//
//  NotificationsViewInput.swift
//  App1C
//
//  Created by Станислава on 03.05.2024.
//

import Foundation

protocol NotificationsViewInput: AnyObject {
    func setupEvents(with notifications: [NotificationModel])
}
