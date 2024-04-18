//
//  UserCreationURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

protocol UserCreationURLRequestFactory: AnyObject {
    func createStudent(with model: CreateStudentModel) throws -> URLRequest
}

extension URLRequestFactory: UserCreationURLRequestFactory {
    func createStudent(with model: CreateStudentModel) throws -> URLRequest {
        guard let url = url(with: "/create/student"),
              var request = makeRequest(with: model, url: url) else {
            throw TFSError.makeRequest
        }
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
}
