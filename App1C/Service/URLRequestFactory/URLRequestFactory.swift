//
//  URLRequestFactory.swift
//  App1C
//
//  Created by Станислава on 13.04.2024.
//

import Foundation

final class URLRequestFactory {
    
    private let host: String
    private let port: Int
    
    init(host: String, port: Int) {
        self.host = host
        self.port = port
    }
    
    var tokenString = {
        return "X-Auth_Token=\(TokenService.shared.token)"
    }()
    
    func url(with path: String, query: String? = nil) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = host
        urlComponents.port = port
        urlComponents.path = path
        urlComponents.query = query
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        return url
    }
    
    func makeRequest<T: Codable>(with model: T, url: URL) -> URLRequest? {
        var request = makeRequest(url: url)
        
        guard let jsonData = try? JSONEncoder().encode(model) else {
            return nil
        }
        request.httpBody = jsonData
        
        return request
    }
    
    func makeRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    func addHeader(request: inout URLRequest) {
        request.addValue(TokenService.shared.token, forHTTPHeaderField: "X-Auth_Token")
        print()
    }
}
