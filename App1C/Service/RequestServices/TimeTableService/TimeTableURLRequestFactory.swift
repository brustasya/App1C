//
//  TimeTableURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol TimeTableURLRequestFactory: AnyObject {
    func timeTable() throws -> URLRequest 
}

extension URLRequestFactory: TimeTableURLRequestFactory {
    func timeTable() throws -> URLRequest {
        guard let url = url(with: "/timetable", query: tokenString) else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
