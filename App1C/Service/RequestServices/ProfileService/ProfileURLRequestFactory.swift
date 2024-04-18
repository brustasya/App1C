//
//  ProfileURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol ProfileURLRequestFactory: AnyObject {
    func getStudent(id: Int) throws -> URLRequest
    func modifyStudent(id: Int, model: StudentDetailsModel) throws -> URLRequest
    func getTeacher(id: Int) throws -> URLRequest
    func modifyTeacher(id: Int, model: UserDetailsModel) throws -> URLRequest
    func getAdmin(id: Int) throws -> URLRequest
    func modifyAdmin(id: Int, model: UserDetailsModel) throws -> URLRequest
}

extension URLRequestFactory: ProfileURLRequestFactory {
    func getStudent(id: Int) throws -> URLRequest {
        guard let url = url(with: "/student/\(id)") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func modifyStudent(id: Int, model: StudentDetailsModel) throws -> URLRequest {
        guard let url = url(with: "/student/\(id)"),
        var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "PUT"
        addHeader(request: &request)
        return request
    }
    
    func getTeacher(id: Int) throws -> URLRequest {
        guard let url = url(with: "/teacher/\(id)") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func modifyTeacher(id: Int, model: UserDetailsModel) throws -> URLRequest {
        guard let url = url(with: "/teacher/\(id)"),
        var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "PUT"
        addHeader(request: &request)
        return request
    }
    
    func getAdmin(id: Int) throws -> URLRequest {
        guard let url = url(with: "/admin/\(id)") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func modifyAdmin(id: Int, model: UserDetailsModel) throws -> URLRequest {
        guard let url = url(with: "/admin/\(id)"),
        var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "PUT"
        addHeader(request: &request)
        return request
    }
}
