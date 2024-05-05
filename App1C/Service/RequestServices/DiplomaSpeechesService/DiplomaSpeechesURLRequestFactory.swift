//
//  DiplomaSpeechesURLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 04.05.2024.
//

import Foundation

protocol DiplomaSpeechesURLRequestFactory: AnyObject {
    func getSpeeches(type: String, bachelor: Bool) throws -> URLRequest
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
}
