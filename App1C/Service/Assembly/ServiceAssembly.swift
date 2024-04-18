//
//  ServiceAssembly.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import Foundation

final class ServiceAssembly {
   // private let host = "37.77.106.55"
    private let host = "192.168.100.5"
    private let port = 8080
    
    func makeVerificationService() -> VerificationServiceProtocol {
        VerificationService(
            networkService: NetworkService(),
            requestFactory: URLRequestFactory(host: host, port: port)
        )
    }
    
    func makeMainPageService() -> MainPageServiceProtocol {
        MainPageService(
            networkService: NetworkService(),
            requestFactory: URLRequestFactory(host: host, port: port)
        )
    }
    
    func makeTimeTableService() -> TimeTableServiceProtocol {
        TimeTableService(
            networkService: NetworkService(),
            requestFactory: URLRequestFactory(host: host, port: port)
        )
    }
    
    func makeUserCreationService() -> UserCreationServiceProtocol {
        UserCreationService(
            networkService: NetworkService(),
            requestFactory: URLRequestFactory(host: host, port: port)
        )
    }
    
    func makeUsersListService() -> UsersListServiceProtocol {
        UsersListService(
            networkService: NetworkService(),
            requestFactory: URLRequestFactory(host: host, port: port)
        )
    }
    
    func makeProfileService() -> ProfileServiceProtocol {
        ProfileService(
            networkService: NetworkService(),
            requestFactory: URLRequestFactory(host: host, port: port)
        )
    }
}
