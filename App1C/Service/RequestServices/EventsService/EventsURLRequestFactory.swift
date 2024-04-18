//
//  EventsURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol EventsURLRequestFactory: AnyObject {
    func events() throws -> URLRequest
    func eventDetails(for id: Int) throws -> URLRequest
    func getModifyEvent(for id: Int) throws -> URLRequest
    func modifyEvent(for id: Int, with model: EventDetailServiceModel) throws -> URLRequest
    func currentEvents() throws -> URLRequest
    func watchEvent(eventID: Int) throws -> URLRequest
    func createSemester(with model: CreateSemesterModel) throws -> URLRequest
    func createEvent( with model: CreateEventModel) throws -> URLRequest
}

extension URLRequestFactory: EventsURLRequestFactory {
    func events() throws -> URLRequest {
        guard let url = url(with: "/events", query: tokenString) else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func eventDetails(for id: Int) throws -> URLRequest {
        guard let url = url(with: "/event", query: "\(tokenString)&event_id=\(id)") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func getModifyEvent(for id: Int) throws -> URLRequest {
        guard let url = url(with: "/modify-event", query: "\(tokenString)&event_id=\(id)") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func modifyEvent(for id: Int, with model: EventDetailServiceModel) throws -> URLRequest {
        guard let url = url(with: "/modify-event", query: "\(tokenString)&event_id=\(id)"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "PUT"
        return request
    }
    
    func currentEvents() throws -> URLRequest {
        guard let url = url(with: "/current-events", query: tokenString) else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func watchEvent(eventID: Int) throws -> URLRequest {
        guard let url = url(with: "/watched", query: "\(tokenString)&event_id=\(eventID)") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "PUT"
        return request
    }
    
    func createSemester(with model: CreateSemesterModel) throws -> URLRequest {
        guard let url = url(with: "/create/semester", query: tokenString),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        return request
    }
    
    func createEvent(with model: CreateEventModel) throws -> URLRequest {
        guard let url = url(with: "/create/event", query: tokenString),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        return request
    }
}
