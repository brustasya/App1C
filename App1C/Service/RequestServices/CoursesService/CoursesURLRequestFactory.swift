//
//  CoursesURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol CoursesURLRequestFactory: AnyObject {
    
}

extension URLRequestFactory: CoursesURLRequestFactory {
    func getCourseDetails(for id: Int) throws -> URLRequest {
        guard let url = url(with: "/course", query: "\(tokenString)&course_id=\(id)") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func saveCourseDetails(for id: Int, with model: CourseDetailsModel) throws -> URLRequest {
        guard let url = url(with: "/course", query: "\(tokenString)&course_id=\(id)"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "PUT"
        return request
    }
    
    func createCourse(with model: CourseDetailsModel) throws -> URLRequest {
        guard let url = url(with: "/create/course", query: tokenString),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        return request
    }
}
