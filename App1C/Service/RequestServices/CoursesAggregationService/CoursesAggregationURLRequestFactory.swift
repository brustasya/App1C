//
//  CoursesAggregationURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol CoursesAggregationURLRequestFactory: AnyObject {
    func aggregation() throws -> URLRequest
    func verdict(courseID: Int, model: VerdictModel) throws -> URLRequest
    func startChosen() throws -> URLRequest
}

extension URLRequestFactory: CoursesAggregationURLRequestFactory{
    func aggregation() throws -> URLRequest {
        guard let url = url(with: "/aggregation") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func verdict(courseID: Int, model: VerdictModel) throws -> URLRequest {
        guard let url = url(with: "/verdict/\(courseID)"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
    
    func startChosen() throws -> URLRequest {
        guard let url = url(with: "/start-chosen") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
}
