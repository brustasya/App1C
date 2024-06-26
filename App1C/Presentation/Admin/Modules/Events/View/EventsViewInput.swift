//
//  EventsViewInput.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol EventsViewInput: AnyObject {
    func updateEvents(events: [EventModel])
}
