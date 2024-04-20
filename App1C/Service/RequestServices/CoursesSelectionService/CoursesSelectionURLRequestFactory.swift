//
//  CoursesSelectionURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol CoursesSelectionURLRequestFactory: AnyObject {
    func getPreliminaryChoise() throws -> URLRequest
    func preliminaryChoise(model: SelectedCoursesModel) throws -> URLRequest
    func getFinalChoise() throws -> URLRequest
    func finalChoise(model: SelectedCoursesModel) throws -> URLRequest 
}

extension URLRequestFactory: CoursesSelectionURLRequestFactory {
    func getPreliminaryChoise() throws -> URLRequest {
        guard let url = url(with: "/preliminary-choice") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func preliminaryChoise(model: SelectedCoursesModel) throws -> URLRequest {
        guard let url = url(with: "/preliminary-choice"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
    
    func getFinalChoise() throws -> URLRequest {
        guard let url = url(with: "/final-choice") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func finalChoise(model: SelectedCoursesModel) throws -> URLRequest {
        guard let url = url(with: "/final-choice"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
}


//preliminary-choice
