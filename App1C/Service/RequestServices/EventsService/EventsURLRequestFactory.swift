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
    func createThemeSelectionEvent(with model: CreateThemeSelectionModel) throws -> URLRequest
    func createDiplomaSpeechEvent(with model: CreateDiplomaSpeechModel) throws -> URLRequest
}

extension URLRequestFactory: EventsURLRequestFactory {
    func events() throws -> URLRequest {
        guard let url = url(with: "/events") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func eventDetails(for id: Int) throws -> URLRequest {
        guard let url = url(with: "/event/\(id)") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func getModifyEvent(for id: Int) throws -> URLRequest {
        guard let url = url(with: "/modify-event/\(id)") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func modifyEvent(for id: Int, with model: EventDetailServiceModel) throws -> URLRequest {
        guard let url = url(with: "/modify-event/\(id)"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "PUT"
        addHeader(request: &request)
        return request
    }
    
    func currentEvents() throws -> URLRequest {
        guard let url = url(with: "/current-events") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func watchEvent(eventID: Int) throws -> URLRequest {
        guard let url = url(with: "/watched/\(eventID)") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "PUT"
        addHeader(request: &request)
        return request
    }
    
    func createSemester(with model: CreateSemesterModel) throws -> URLRequest {
        guard let url = url(with: "/create/semester"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
    
    func createEvent(with model: CreateEventModel) throws -> URLRequest {
        guard let url = url(with: "/create/event"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
    
    func createThemeSelectionEvent(with model: CreateThemeSelectionModel) throws -> URLRequest {
        guard let url = url(with: "/create/event/diploma"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
    
    func createDiplomaSpeechEvent(with model: CreateDiplomaSpeechModel) throws -> URLRequest {
        guard let url = url(with: "/create/event/speech"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
}
