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
    func getTeachers(courseID: Int) throws -> URLRequest
    func changeTeachers(id: Int, teachers: [Int]) throws -> URLRequest
    func getTeachersByCourse(id: Int) throws -> URLRequest
    func getStudentsByCourse(courseID: Int) throws -> URLRequest
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
    
    func getStudentsByCourse(courseID: Int) throws -> URLRequest {
        guard let url = url(with: "/students/by-course/\(courseID)") else {
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
    
    func getTeachers(courseID: Int) throws -> URLRequest {
        guard let url = url(with: "/teachers", query: "course_id=\(courseID)") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func getTeachersByCourse(id: Int) throws -> URLRequest {
        guard let url = url(with: "/teachers/by-course/\(id)") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func changeTeachers(id: Int, teachers: [Int]) throws -> URLRequest {
        guard let url = url(with: "/course/\(id)/change-teachers"),
              var request = makeRequest(with: teachers, url: url)
        else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "PUT"
        addHeader(request: &request)
        return request
    }
}
