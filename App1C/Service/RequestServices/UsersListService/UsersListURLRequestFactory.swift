//
//  UsersListURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol UsersListURLRequestFactory: AnyObject {
    func getStudentsByYear(course: Int) throws -> URLRequest
    func getAdmins() throws -> URLRequest
    func getTeachers() throws -> URLRequest
}

extension URLRequestFactory: UsersListURLRequestFactory {
    func getStudentsByYear(course: Int) throws -> URLRequest {
        guard let url = url(with: "/students/by-year/\(course)") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func getAdmins() throws -> URLRequest {
        guard let url = url(with: "/admins") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func getTeachers() throws -> URLRequest {
        guard let url = url(with: "/teachers") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
}
