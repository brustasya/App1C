//
//  DiplomasInfoURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

protocol DiplomasInfoURLRequestFactory: AnyObject {
    func getDiplomas(bachelor: Bool) throws -> URLRequest
    func getDiplomaDetails(studentID: Int) throws -> URLRequest
    func modifyDiplomaDetails(studentID: Int, bachelor: Bool, model: DiplomaDetailsServiceModel) throws -> URLRequest
}

extension URLRequestFactory: DiplomasInfoURLRequestFactory {
    func getDiplomas(bachelor: Bool) throws -> URLRequest {
        guard let url = url(with: "/diplomas", query: "bachelor=\(bachelor)") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func getDiplomaDetails(studentID: Int) throws -> URLRequest {
        guard let url = url(with: "/student/\(studentID)/diploma") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func modifyDiplomaDetails(studentID: Int, bachelor: Bool, model: DiplomaDetailsServiceModel) throws -> URLRequest {
        guard let url = url(with: "/student/\(studentID)/diploma", query: "bachelor=\(bachelor)"),
              var request = makeRequest(with: model, url: url)
        else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "PUT"
        addHeader(request: &request)
        return request
    }
}
