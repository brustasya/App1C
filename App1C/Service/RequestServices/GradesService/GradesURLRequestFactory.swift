//
//  GradesURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol GradesURLRequestFactory: AnyObject {
    func estimate(courseID: Int, studentID: Int, model: EstimateServerModel) throws -> URLRequest
    func finishEstimation(courseID: Int) throws -> URLRequest
    func getGrades(studentID: Int) throws -> URLRequest
}

extension URLRequestFactory: GradesURLRequestFactory {
    func getGrades(studentID: Int) throws -> URLRequest {
        guard let url = url(with: "/student/\(studentID)/grades") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func estimate(courseID: Int, studentID: Int, model: EstimateServerModel) throws -> URLRequest {
        guard let url = url(with: "/course/\(courseID)/estimate/\(studentID)"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
    
    func finishEstimation(courseID: Int) throws -> URLRequest {
        guard let url = url(with: "/course/\(courseID)/finish-estimation") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
}
