//
//  StudentMainScreenViewInput.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

protocol StudentMainScreenViewInput: AnyObject {
    func updateEvents(events: [EventModel])
}
