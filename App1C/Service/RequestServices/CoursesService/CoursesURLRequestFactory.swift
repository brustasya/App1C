//
//  CoursesURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol CoursesURLRequestFactory: AnyObject {
    func getCourses() throws -> URLRequest
}

extension URLRequestFactory: CoursesURLRequestFactory {
    func getCourseDetails(for id: Int) throws -> URLRequest {
        guard let url = url(with: "/course", query: "course_id=\(id)") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func saveCourseDetails(for id: Int, with model: CourseDetailsModel) throws -> URLRequest {
        guard let url = url(with: "/course", query: "course_id=\(id)"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "PUT"
        addHeader(request: &request)
        return request
    }
    
    func createCourse(with model: CourseDetailsModel) throws -> URLRequest {
        guard let url = url(with: "/create/course"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
    
    func getCourses() throws -> URLRequest {
        guard let url = url(with: "/courses") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
}
