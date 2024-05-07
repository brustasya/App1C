//
//  DiplomaSpeechesURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

protocol DiplomaSpeechesURLRequestFactory: AnyObject {
    func getSpeeches(type: String, bachelor: Bool) throws -> URLRequest
    func result(studentID: Int, speechID: Int, result: Bool) throws -> URLRequest
}

extension URLRequestFactory: DiplomaSpeechesURLRequestFactory {
    func getSpeeches(type: String, bachelor: Bool) throws -> URLRequest {
        guard let url = url(with: "/diploma/speech", query: "bachelor=\(bachelor)&type=\(type)") else {
            throw TFSError.makeRequest
        }
        
        var request = makeRequest(url: url)
        request.httpMethod = "GET"
        addHeader(request: &request)
        return request
    }
    
    func result(studentID: Int, speechID: Int, result: Bool) throws -> URLRequest {
        guard let url = url(with: "/student/\(studentID)/speech-result/\(speechID)"),
              var request = makeRequest(with: result, url: url)
        else {
            throw TFSError.makeRequest
        }
        
        request.httpMethod = "POST"
        addHeader(request: &request)
        return request
    }
}
