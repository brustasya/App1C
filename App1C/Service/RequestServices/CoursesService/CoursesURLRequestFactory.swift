//
//  CoursesURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol CoursesURLRequestFactory: AnyObject {
    func createCourse(with model: CreateCourseModel) throws -> URLRequest
    func getCourses() throws -> URLRequest
    func getDeps(courseID: Int) throws -> URLRequest
    func changeDeps(courseID: Int, deps: [Int]) throws -> URLRequest
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
    
    func createCourse(with model: CreateCourseModel) throws -> URLRequest {
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
    
    func getDeps(courseID: Int) throws -> URLRequest {
        guard let url = url(with: "/courses", query: "course_id=\(courseID)") else {
            throw TFSError.makeRequest
        }
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func changeDeps(courseID: Int, deps: [Int]) throws -> URLRequest {
        guard let url = url(with: "/course/\(courseID)/dependencies"),
              var request = makeRequest(with: deps, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
}
