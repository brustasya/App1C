//
//  AdminMainScreenViewInput.swift
//  App1C
//
//  Created by Станислава on 17.04.2024.
//

import Foundation

protocol AdminMainScreenViewInput: AnyObject {
    func setupCourseAggregationButton() 
    func setupBell(newEvents: Bool)
}
